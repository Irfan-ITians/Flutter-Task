class CategoryModel {
  final String slug;
  final String name;
  final String? url; // Make url optional

  CategoryModel({
    required this.slug,
    required this.name,
    this.url,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json['slug'],
      name: json['name'],
      url: json['url'], // Some categories might not have a URL
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
      'url': url,
    };
  }
}

