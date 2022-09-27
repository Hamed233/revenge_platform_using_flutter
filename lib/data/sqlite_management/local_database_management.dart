import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/constants/enum_generator.dart';
import 'package:revenge_platform/models/connection_primary_info.dart';
import 'package:revenge_platform/models/latest_message_from_connection.dart';
import 'package:revenge_platform/models/previous_message.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
//for important table
  final String _importantTableData = "__app_table_data__";
//all columns
  final String _colUsername = "username";
  final String _colUserMail = "userEmail";
  final String _colId = "id";
  final String _colProfileImagePath = "profileImagePath";
  final String _colProfileImageUrl = "profileImageUrl";
  final String _colBio = "bio";
  final String _colWallpaper = "chatWallpaper";
  final String _colNotification = "notificationStatus";
  final String _colMobileNumber = "UserMobileNumber";
  final String _colAccountCreationDate = "accountCreationDate";
  final String _colAccountCreationTime = "accountCreationTime";

  // For chat messages with connection
  final String _colActualMessage = "message";
  final String _colMessageType = "messageType";
  final String _colMessageDate = "messageDate";
  final String _colMessageTime = "messageTime";
  final String _colMessageHolder = "messageHolder";

  // Create Singleton Objects(Only Created once in the whole application)
  static late LocalDatabase _localStorageHelper =
      LocalDatabase._createInstance();
  static late Database _database;

  // Instantiate the obj
  LocalDatabase._createInstance(); //named constructor

  //For accessing the Singleton object
  factory LocalDatabase() {
    _localStorageHelper = LocalDatabase._createInstance();
    return _localStorageHelper;
  }

//getter for taking instance of database
  Future<Database> get database async {
    _database = await initializeDatabase();
    return _database;
  }

  //making a database
  Future<Database> initializeDatabase() async {
    // Get the directory path to store the database
    final String desiredPath = await getDatabasesPath();

    //creates a hidden folder for the databases
    final Directory newDirectory =
        await Directory(desiredPath + "/.Databases/").create();
    final String path = newDirectory.path + "/revenge_app_local_storage.db";

    // create the database
    final Database getDatabase = await openDatabase(path, version: 1);
    return getDatabase;
  }

  //creae table to store important data using username as primary key
  Future<void> createTableToStoreImportantData() async {
    Database db = await database;

    try {
      await db.execute(
          """CREATE TABLE $_importantTableData($_colId TEXT PRIMARY KEY, 
          $_colUserMail TEXT, $_colUsername TEXT, $_colProfileImagePath TEXT,
           $_colProfileImageUrl TEXT, $_colBio TEXT, $_colWallpaper TEXT,
            $_colNotification TEXT, $_colMobileNumber TEXT,
             $_colAccountCreationDate TEXT, $_colAccountCreationTime TEXT)""");
    } catch (e) {
      print("Error in createTableToStoreImportantData: ${e.toString()}");
    }
  }

//insert or update important data table
  Future<bool> insertOrUpdateDataForThisAccount({
    required String userName,
    required String userMail,
    required String userId,
    required String userBio,
    required String profileImagePath,
    required String profileImageUrl,
    String? userAccCreationDate,
    String? userAccCreationTime,
    String chatWallpaper = "",
    String purpose = "insert",
  }) async {
    try {
      final Database db = await database;

      if (purpose != 'insert') {
        final int updateResult = await db.rawUpdate(
            "UPDATE $_importantTableData SET $_colUsername = '$userName', $_colBio = '$userBio', $_colProfileImagePath = '$profileImagePath', $_colProfileImageUrl = '$profileImageUrl',  $_colUserMail = '$userMail', $_colAccountCreationDate = '$userAccCreationDate', $_colAccountCreationTime = '$userAccCreationTime' WHERE $_colId = '$userId'");

        print('Update Result is: $updateResult');
      } else {
        final Map<String, dynamic> _accountData = <String, dynamic>{};

        _accountData[_colUsername] = userName;
        _accountData[_colUserMail] = userMail;
        _accountData[_colId] = userId;
        _accountData[_colProfileImagePath] = profileImagePath;
        _accountData[_colProfileImageUrl] = profileImageUrl;
        _accountData[_colBio] = userBio;
        _accountData[_colWallpaper] = chatWallpaper;
        _accountData[_colMobileNumber] = '';
        _accountData[_colNotification] = '1';
        _accountData[_colAccountCreationDate] = userAccCreationDate;
        _accountData[_colAccountCreationTime] = userAccCreationTime;

        await db.insert(_importantTableData, _accountData);
      }

      return true;
    } catch (e) {
      print(
          'Error in Insert or Update operations of important data table: ${e.toString()}');
      return false;
    }
  }

  //create table to store messages for connections
  Future<void> createTableForEveryUser({required String id}) async {
    try {
      final Database db = await database;

      await db.execute(
          "CREATE TABLE $id($_colActualMessage TEXT, $_colMessageType TEXT, $_colMessageHolder TEXT, $_colMessageDate TEXT, $_colMessageTime TEXT, $_colProfileImagePath TEXT)");
    } catch (e) {
      print("Error in Creating Table For Every User: ${e.toString()}");
    }
  }

  //insert messages for conections
  Future<void> insertMessageInUserTable(
      {required String receiveId,
      required String actualMessage,
      required ChatMessageType chatMessageTypes,
      required MessageHolderType messageHolderType,
      required String messageDateLocal,
      required String messageTimeLocal,
      required String profilePic}) async {
    try {
      final Database db = await database;

      Map<String, String> tempMap = <String, String>{};

      tempMap[_colActualMessage] = actualMessage;
      tempMap[_colMessageType] = chatMessageTypes.toString();
      tempMap[_colMessageHolder] = messageHolderType.toString();
      tempMap[_colMessageDate] = messageDateLocal;
      tempMap[_colMessageTime] = messageTimeLocal;
      tempMap[_colProfileImagePath] = profilePic;

      final int rowAffected = await db.insert(receiveId, tempMap);
      print('Row Affected: $rowAffected');
    } catch (e) {
      print('Error in Insert Message In User Table: ${e.toString()}');
    }
  }

  //get any field data from the importantTableData using receiveId
  Future<String?> getParticularFieldDataFromImportantTable(
      {required String receiveId,
      required GetFieldForImportantDataLocalDatabase getField}) async {
    try {
      final Database db = await database;

      final String? _particularSearchField = _getFieldName(getField);

      List<Map<String, Object?>> getResult = await db.rawQuery(
          "SELECT $_particularSearchField FROM $_importantTableData WHERE $_colId = '$receiveId'");

      return getResult[0].values.first.toString();
    } catch (e) {
      print(
          'Error in getParticularFieldDataFromImportantTable: ${e.toString()}');
      return null;
    }
  }

  ////get username for any user from the importantTableData using email
  Future<List?> getUserInfoForAnyUser(String userId) async {
    try {
      final Database db = await database;

      List<Map<String, Object?>> result = await db.rawQuery(
          "SELECT * FROM $_importantTableData WHERE $_colId='$userId'");

      return result;
    } catch (e) {
      print('error in getting current user\'s username');
      return null;
    }
  }

  //return field name
  String? _getFieldName(GetFieldForImportantDataLocalDatabase getField) {
    switch (getField) {
      case GetFieldForImportantDataLocalDatabase.userName:
        return _colUsername;
      case GetFieldForImportantDataLocalDatabase.userEmail:
        return _colUserMail;
      case GetFieldForImportantDataLocalDatabase.id:
        return _colId;
      case GetFieldForImportantDataLocalDatabase.profileImagePath:
        return _colProfileImagePath;
      case GetFieldForImportantDataLocalDatabase.profileImageUrl:
        return _colProfileImageUrl;
      case GetFieldForImportantDataLocalDatabase.bio:
        return _colBio;
      case GetFieldForImportantDataLocalDatabase.wallPaper:
        return _colWallpaper;
      case GetFieldForImportantDataLocalDatabase.mobileNumber:
        return _colMobileNumber;
      case GetFieldForImportantDataLocalDatabase.notification:
        return _colNotification;
      case GetFieldForImportantDataLocalDatabase.accountCreationDate:
        return _colAccountCreationDate;
      case GetFieldForImportantDataLocalDatabase.accountCreationTime:
        return _colAccountCreationTime;
    }
  }

  //get all conections username and Bio
  Future<List<String>> extractAllConnectionsUsernames() async {
    try {
      final Database db = await database;

      List<String> allConnectionsUsernames = [];
      //extract all usernames excluding the current users's
      List<Map<String, Object?>> result = await db.rawQuery(
          """SELECT $_colUsername FROM $_importantTableData WHERE $_colId != "${userId.toString()}" """);

      for (int i = 0; i < result.length; i++) {
        allConnectionsUsernames.add(result[i].values.first.toString());
      }
      return allConnectionsUsernames;
    } catch (e) {
      print('error in getting all connectons usernames : ${e.toString()}');
      return [];
    }
  }

  //get all conections username and Bio
  Future<List<String>> extractAllUsernamesIncludingCurrentUser() async {
    try {
      final Database db = await database;

      List<String> allUsernames = [];
      //extract all usernames including the current users's
      List<Map<String, Object?>> result = await db
          .rawQuery("""SELECT $_colUsername FROM $_importantTableData """);

      for (int i = 0; i < result.length; i++) {
        allUsernames.add(result[i].values.first.toString());
      }
      return allUsernames;
    } catch (e) {
      print('error in getting all usernames : ${e.toString()}');
      return [];
    }
  }

  //get all conections username and Bio
  Future<List<ConnectionPrimaryInfo>> getConnectionPrimaryInfo() async {
    try {
      final Database db = await database;

      List<ConnectionPrimaryInfo> allConnectionsPrimaryInfo = [];
      //extract all usernames and Bio excluding the current users's
      List<Map<String, Object?>> result = await db.rawQuery(
          """SELECT $_colUsername, $_colBio, $_colProfileImagePath FROM $_importantTableData WHERE $_colId != "${userId.toString()}" """);

      for (int i = 0; i < result.length; i++) {
        Map<String, dynamic> tempMap = result[i];
        allConnectionsPrimaryInfo.add(ConnectionPrimaryInfo.toJson(tempMap));
      }
      return allConnectionsPrimaryInfo;
    } catch (e) {
      print(
          'error in getting all connectons primary info from local : ${e.toString()}');
      return [];
    }
  }

  //get all prevoius messages for a particular connection
  Future<List<PreviousMessageStructure>> getAllPreviousMessages(
      String connectionUserId) async {
    try {
      final Database db = await database;

      final List<Map<String, Object?>> result =
          await db.rawQuery("SELECT * from $connectionUserId");

      List<PreviousMessageStructure> takePreviousMessages = [];

      for (int i = 0; i < result.length; i++) {
        Map<String, dynamic> tempMap = result[i];
        takePreviousMessages.add(PreviousMessageStructure.toJson(tempMap));
      }

      return takePreviousMessages;
    } catch (e) {
      print("Error in getAllPreviousMessages: ${e.toString}");
      return [];
    }
  }

  //get last sent messages from connections
  Future<List<LatestMessageFromConnection>>
      getLatestMessageFromConnections(_userId) async {
    try {
      final Database db = await database;

      List<LatestMessageFromConnection> lastestMessageFromConnections = [];

      List<Map<String, Object?>> getUsernames = await db.rawQuery(
          """SELECT $_colUsername FROM $_importantTableData WHERE $_colId != "${_userId.toString()}" """);
      //WHERE $_colMessageHolder == "${MessageHolderType.connectedUsers.toString()}"
      if (getUsernames.isNotEmpty) {
        for (int i = 0; i < getUsernames.length; i++) {
          List<Map<String, Object?>> result = await db.rawQuery(
              """SELECT * FROM ${getUsernames[i].values.first.toString()} """);

          if (result.isNotEmpty) {
            Map<String, dynamic> tempMap = result[result.length - 1];
            lastestMessageFromConnections.add(
                LatestMessageFromConnection.toJson(
                    userName: getUsernames[i].values.first.toString(),
                    map: tempMap));
          }
        }
      }

      return lastestMessageFromConnections;
    } catch (e) {
      print(
          'error in getting last messages from connections : ${e.toString()}');
      return [];
    }
  }













//   Future<void> insertProfilePictureInImportant(
//       {required String imagePath,
//       required String imageUrl,
//       required String mail}) async {
//     try {
//       final Database db = await this.database;

//       final int result = await db.rawUpdate(
//           """UPDATE $_allImportantDataStore 3SET $_colProfileImagePath = "$imagePath", $_colProfileImageUrl = "$imageUrl" WHERE $_colAccountUserMail = "$mail" """);

//       result == 1
//           ? print("Success: New Profile Picture Update Successful")
//           : print("Failed: New Profile Picture Update Fail");
//     } catch (e) {
//       print("Insert Profile Picture to Local Database Error: ${e.toString()}");
//     }
//   }
}
