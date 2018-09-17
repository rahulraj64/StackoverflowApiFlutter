class User {
  String name;
  String profilePicUrl;
  int reputation;
  int gold;
  int silver;
  String location;
  int bronze;
  String link;

  User(
      {this.name,
      this.location,
      this.profilePicUrl,
      this.reputation,
      this.gold,
      this.silver,
      this.bronze,
      this.link});
}

List<User> parseUsersFromJsonMap(Map<String, dynamic> jsonMap) {
  List<User> users = [];
  List items = jsonMap["items"];
  for (int i = 0; i < items.length; i++) {
    String name = items[i]["display_name"];
    String profileImage = items[i]["profile_image"];
    int reputation = items[i]["reputation"];
    String location = items[i]["location"];
    String link = items[i]["link"];
    int gold = items[i]["badge_counts"]["gold"];
    int silver = items[i]["badge_counts"]["silver"];
    int bronze = items[i]["badge_counts"]["bronze"];
    User user = User(
        name: name,
        location: location,
        profilePicUrl: profileImage,
        reputation: reputation,
        gold: gold,
        silver: silver,
        bronze: bronze,
        link: link);
    users.add(user);
  }
  return users;
}
