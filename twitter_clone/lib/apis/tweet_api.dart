import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';
import 'package:twitter_clone/core/core.dart';
import 'package:twitter_clone/core/provider.dart';
import 'package:twitter_clone/models/tweet_model.dart';

final tweetApiProvider = Provider((ref) => TweetAPI(db: ref.watch(databaseProvider)));


abstract class ITweetAPI {
  FutureEither<Document> shareTweet(Tweet tweet);
}

class TweetAPI implements ITweetAPI {
  
  final Databases _db;

  TweetAPI({required Databases db}) : _db = db;
  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      // add tweet to database
      final doc=await _db.createDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.tweetsCollection,
          documentId:  ID.unique(),
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
}
