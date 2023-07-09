class AppwriteConstants {
  static const String databaseId = '64a031f32dc925d11396';
  static const String projectId = '64a02e6ff00ebd2ad578';
  static const String endPoint = 'https://cloud.appwrite.io/v1';

  static const String usersCollection = '64a032a8d953c59b1a90';
  static const String tweetsCollection = '64aa525240c5af11ad67';
  static const String notificationsCollection = '64aa5260c43f9060c111';

  static const String imagesBucket = '64a51b2c589c04488bb5';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
