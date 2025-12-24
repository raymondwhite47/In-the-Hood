import '../models/business_ad_model.dart';
import 'aws_store.dart';

class AdsService {
  final AwsStore _store = AwsStore.instance;

  Future<void> createAd(BusinessAdModel ad) async {
    _store.set('business_ads', ad.id, ad.toMap());
  }

  Stream<List<BusinessAdModel>> getActiveAds() {
    final now = DateTime.now();
    return _store.watch('business_ads').map((items) {
      return items
          .where((doc) {
            final start = DateTime.tryParse(doc['startDate'] ?? '');
            final end = DateTime.tryParse(doc['endDate'] ?? '');
            if (start == null || end == null) {
              return false;
            }
            return !start.isAfter(now) && !end.isBefore(now);
          })
          .map((doc) => BusinessAdModel.fromMap(doc, doc['id'] as String))
          .toList();
    });
  }
}
