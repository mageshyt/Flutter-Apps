class AppwriteConstants {
  static const String databaseId = '64a6c0a6ccbad9e8b628';
  static const String projectId = '64a037829c9397ccc9c6';
  static const String endPoint = 'http://localhost:80/v1';

  static const String usersCollection = '64a6c0b472d67a0f2bc9';
  static const String tweetsCollection = '64a6c0c6e38fa7c0f340';
  static const String notificationsCollection = '64a6c0d3b454c1c8a5ce';

  static const String imagesBucket = '63cbdab48cdbccb6b34e';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
