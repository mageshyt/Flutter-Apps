class AppwriteConstants {
  static const String databaseId = '64a031f32dc925d11396';
  static const String projectId = '64a02e6ff00ebd2ad578';
  static const String endPoint = 'https://cloud.appwrite.io/v1';

  static const String usersCollection = '64a032a8d953c59b1a90';
  static const String tweetsCollection = '63cbd6781a8ce89dcb95';
  static const String notificationsCollection = '63cd5ff88b08e40a11bc';

  static const String imagesBucket = '63cbdab48cdbccb6b34e';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
