class CategoryData {
  String id;
  String name;
  String image;

  CategoryData({required this.id, required this.name, required this.image});


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryData &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;

  static List<CategoryData> categories = [
    CategoryData(
        id: "sports", name: "Sports", image: "assets/images/sports.png"),
    CategoryData(
        id: "birthday", name: "Birthday", image: "assets/images/birthday.png"),
    CategoryData(
        id: "book_club",
        name: "Book Club",
        image: "assets/images/book_club.png"),
    CategoryData(
        id: "eating", name: "Eating", image: "assets/images/eating.png"),
    CategoryData(
        id: "exhibition",
        name: "Exhibition",
        image: "assets/images/exhibition.png"),
    CategoryData(
        id: "gaming", name: "Gaming", image: "assets/images/gaming.png"),
    CategoryData(
        id: "holiday", name: "Holiday", image: "assets/images/holiday.png"),
    CategoryData(
        id: "meeting", name: "Meeting", image: "assets/images/meeting.png"),
    CategoryData(
        id: "work_shop",
        name: "workShop",
        image: "assets/images/work_shop.png"),
  ];
  static List<CategoryData> categoriesWithAll = [
    CategoryData(
        id: "all", name: "All", image: "assets/images/sports.png"),

    CategoryData(
        id: "sports", name: "Sports", image: "assets/images/sports.png"),
    CategoryData(
        id: "birthday", name: "Birthday", image: "assets/images/birthday.png"),
    CategoryData(
        id: "book_club",
        name: "Book Club",
        image: "assets/images/book_club.png"),
    CategoryData(
        id: "eating", name: "Eating", image: "assets/images/eating.png"),
    CategoryData(
        id: "exhibition",
        name: "Exhibition",
        image: "assets/images/exhibition.png"),
    CategoryData(
        id: "gaming", name: "Gaming", image: "assets/images/gaming.png"),
    CategoryData(
        id: "holiday", name: "Holiday", image: "assets/images/holiday.png"),
    CategoryData(
        id: "meeting", name: "Meeting", image: "assets/images/meeting.png"),
    CategoryData(
        id: "work_shop",
        name: "workShop",
        image: "assets/images/work_shop.png"),
  ];
}


