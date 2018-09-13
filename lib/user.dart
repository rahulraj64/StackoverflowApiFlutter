class User {
  String name;
  String profilePicUrl;
  int reputation;
  int gold;

  User({this.name, this.profilePicUrl, this.reputation, this.gold});
}


List<User> parseUsersFromJsonMap(Map<String, dynamic> jsonMap) {
  List<User> users = [];
  List items = jsonMap["items"];
  for (int i = 0; i < items.length; i++) {
    String name = items[i]["display_name"];
    String profileImage = items[i]["profile_image"];
    int reputation = items[i]["reputation"];
    int gold = items[i]["badge_counts"]["gold"];
    User user = User(
        name: name,
        profilePicUrl: profileImage,
        reputation: reputation,
        gold: gold);
    users.add(user);
  }
  return users;
}