import 'package:cloud_firestore/cloud_firestore.dart';

class AuctionModel {
  final String id;
  final String title;
  final double currentBid;
  final double minIncrement;
  final Timestamp endTime;
  final String sellerId;
  final String highestBidderId;

  AuctionModel({
    required this.id,
    required this.title,
    required this.currentBid,
    required this.minIncrement,
    required this.endTime,
    required this.sellerId,
    required this.highestBidderId,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'currentBid': currentBid,
        'minIncrement': minIncrement,
        'endTime': endTime,
        'sellerId': sellerId,
        'highestBidderId': highestBidderId,
      };

  factory AuctionModel.fromMap(Map<String, dynamic> data) => AuctionModel(
        id: data['id'],
        title: data['title'],
        currentBid: data['currentBid'],
        minIncrement: data['minIncrement'],
        endTime: data['endTime'],
        sellerId: data['sellerId'],
        highestBidderId: data['highestBidderId'],
      );
}
