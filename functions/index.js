const admin = require('firebase-admin');
const functions = require('firebase-functions');

admin.initializeApp();

exports.autoBid = functions.firestore
  .document('auctions/{id}/bids/{bidId}')
  .onCreate(async (snap, context) => {
    const bidData = snap.data();
    if (bidData?.autoBid) {
      return null;
    }

    const auctionRef = admin.firestore().doc(`auctions/${context.params.id}`);

    return admin.firestore().runTransaction(async (transaction) => {
      const auctionSnap = await transaction.get(auctionRef);
      if (!auctionSnap.exists) {
        return null;
      }

      const auction = auctionSnap.data() || {};
      const autoBidders = Array.isArray(auction.autoBidders)
        ? auction.autoBidders
        : [];

      if (!autoBidders.length) {
        return null;
      }

      const currentBid = typeof auction.currentBid === 'number' ? auction.currentBid : 0;
      const eligibleBidders = autoBidders.filter((bidder) => {
        if (!bidder || typeof bidder.maxBid !== 'number') {
          return false;
        }

        return bidder.maxBid >= currentBid + 1;
      });

      if (!eligibleBidders.length) {
        return null;
      }

      const nextBid = currentBid + 1;
      const nextBidder = eligibleBidders.sort((a, b) => b.maxBid - a.maxBid)[0];
      const bidderId = nextBidder.userId || nextBidder.id || null;

      if (!bidderId) {
        return null;
      }

      const bidRef = auctionRef.collection('bids').doc();
      const timestamp = admin.firestore.FieldValue.serverTimestamp();

      transaction.set(bidRef, {
        amount: nextBid,
        autoBid: true,
        createdAt: timestamp,
        userId: bidderId,
      });

      transaction.update(auctionRef, {
        currentBid: nextBid,
        currentBidder: bidderId,
        updatedAt: timestamp,
      });

      return null;
    });
  });
