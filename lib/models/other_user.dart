

class User {
  final String uid;
  final String username;
  final String iconURL;
  final List<String> following;
  final List<String> followers;
  final List<String> posts;

  User({
    required this.uid,
    required this.username,
    required this.iconURL,
    required this.following,
    required this.followers,
    required this.posts,
  });
}
