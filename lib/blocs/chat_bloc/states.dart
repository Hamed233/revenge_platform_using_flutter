
abstract class ChatStates {}

class ChatInitialState extends ChatStates {}
class SocialGetAllUsersLoadingState extends ChatStates {}
class SocialGetAllUsersSuccessState extends ChatStates {}
class SocialGetAllUsersErrorState extends ChatStates {
  final String error;
  SocialGetAllUsersErrorState(this.error);
}

// Chat
class ChatSendMessageSuccessState extends ChatStates {}
class ChatSendMessageErrorState extends ChatStates {}
class ChatGetMessageSuccessState extends ChatStates {}
class ChatGetMessageErrorState extends ChatStates {}
class ChatGetMessageLoadingState extends ChatStates {}
