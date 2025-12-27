import '../constants/admob_ids.dart';

class AdService {
  Future<String> loadBannerAdId({bool isIOS = false}) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return isIOS ? AdmobIds.iosBannerId : AdmobIds.androidBannerId;
  }

  Future<String> loadRewardedAdId({bool isIOS = false}) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return isIOS ? AdmobIds.iosRewardedId : AdmobIds.androidRewardedId;
  }
}
