class Menu {
  final String chef;
  final String menuName;
  final String ingredients;
  final String image;
  Menu({
    required this.chef,
    required this.menuName,
    required this.ingredients,
    required this.image,
  });
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      chef: json['chef']['name'],
      menuName: json['menu_name'],
      ingredients: json['ingredients'],
      image: json['image_url'],
    );
  }
}
