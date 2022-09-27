import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:revenge_platform/network/local/cache_helper.dart';

final thumbnailDownloaderProvider =
    StateNotifierProvider<ThumbnailDownloaderNotifier, bool>(
  (_) => ThumbnailDownloaderNotifier(
    state: CacheHelper.getData(key: 'thumbnailDownloader') ?? false,
  ),
);

class ThumbnailDownloaderNotifier extends StateNotifier<bool> {
  ThumbnailDownloaderNotifier({required bool state}) : super(state);

  set value(bool value) {
    state = value;
    CacheHelper.saveData(key: 'thumbnailDownloader', value: state);
  }

  void reset() {
    CacheHelper.removeData(key: 'thumbnailDownloader')
        .whenComplete(() => state = false);
  }
}
