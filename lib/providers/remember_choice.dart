import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revenge_platform/network/local/cache_helper.dart';

final rememberChoiceProvider =
    StateNotifierProvider<RememberChoiceNotifier, bool>(
  (_) =>
      RememberChoiceNotifier(state: CacheHelper.getData(key: 'remember_choice') ?? false),
);

class RememberChoiceNotifier extends StateNotifier<bool> {
  RememberChoiceNotifier({required bool state}) : super(state);

  set value(bool newChoice) {
    state = newChoice;
    CacheHelper.saveData(key: 'remember_choice', value: state);
  }

  void reset() {
    CacheHelper.removeData(key: 'remember_choice').whenComplete(() => state = false);
  }
}
