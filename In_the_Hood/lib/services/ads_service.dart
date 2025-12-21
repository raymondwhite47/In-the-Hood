import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/business_ad_model.dart';

class AdsService {
  final adsRef = FirebaseFirestore.instance.collection('business_ads');

  Future<void> createAd(BusinessAdModel ad) async {
    await adsRef.doc(ad.id).set(ad.toMap());
  }

  Stream<List<BusinessAdModel>> getActiveAds() {
    final now = DateTime.now();
    return adsRef
        .where('startDate', isLessThanOrEqualTo: now.toIso8601String())
        .where('endDate', isGreaterThanOrEqualTo: now.toIso8601String())
        .snapshots()
        .map((snap) => snap.docs.map((doc) => BusinessAdModel.fromMap(doc.data(), doc.id)).toList());
  }
}
