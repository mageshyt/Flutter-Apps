import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/provider.dart';
import 'package:twitter_clone/models/tweet_model.dart';

final tweetApiProvider = Provider((ref) => TweetAPI(
    db: ref.watch(databaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider)));

final getLatestTweetProvider = StreamProvider((ref) {
  final tweetApi = ref.watch(tweetApiProvider);

  return tweetApi.getLatestTweet();
});

abstract class ITweetAPI {
  FutureEither<Document> shareTweet(Tweet tweet);

  Future<List<Document>> getTweets();

  Stream<RealtimeMessage> getLatestTweet();

  FutureEither<Document> likeTweet(Tweet tweet);

  FutureEither<Document> updateReshareCount(Tweet tweet);

  Future<List<Document>> getTweetReplies(Tweet tweet);
}

class TweetAPI implements ITweetAPI {
  final Databases _db;
  final Realtime _realtime;

  TweetAPI({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;
  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      print(tweet.toMap());
      // add tweet to database
      final doc = await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.tweetsCollection,
          documentId: ID.unique(),
          data: tweet.toMap());

      // // add tweet to user's tweets
      // await _db.updateDocument(
      //     databaseId: AppwriteConstants.databaseId,
      //     collectionId: AppwriteConstants.usersCollection,
      //     documentId: tweet.uid,
      //     data: {
      //       "tweets": Field.valueAppend(tweet.id),
      //     });

      return right(doc);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  @override
  Future<List<Document>> getTweets() async {
    try {
      final response = await _db.listDocuments(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.tweetsCollection,
          queries: [Query.orderDesc('tweetedAt')]);

      return response.documents;
    } catch (e, stackTrace) {
      throw Failure(message: e.toString(), stackTrace: stackTrace);
    }
  }

  @override
  Stream<RealtimeMessage> getLatestTweet() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.tweetsCollection}.documents'
    ]).stream;
  }

  @override
  FutureEither<Document> likeTweet(Tweet tweet) async {
    try {
      final doc = await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.tweetsCollection,
          documentId: tweet.id,
          data: {
            "likes": tweet.likes,
          });

      return right(doc);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<Document> updateReshareCount(Tweet tweet) async {
    try {
      final doc = await _db.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.tweetsCollection,
          documentId: tweet.id,
          data: {
            "reshareCount": tweet.reshareCount,
          });

      return right(doc);
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }

  @override
  Future<List<Document>> getTweetReplies(Tweet tweet) async {
    final doc = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.tweetsCollection,
        queries: [
          Query.equal(
            'repliedTo',
            tweet.id,
          ),
          Query.orderDesc('tweetedAt'),
        ]);

    return doc.documents;
  }
}
