class UserFields {
  static String id = "id";
  static String name = "username";
  static String imageUrl = "image_url";
  static String createdAt = "created_at";
}

class CategoryModel{
  final int id;
  final String name;
  final String imageUrl;
  final String createdAt;

  CategoryModel({
     required this.id,
     required this.name,
     required this.imageUrl,
     required this.createdAt
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
        id: json['id']  as int? ?? 0, 
        name: json['name']  as String? ?? '', 
        imageUrl: json['image_url']  as String? ?? '', 
        createdAt: json['created_at']  as String? ?? '',
        );
  }

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.imageUrl: imageUrl,
        UserFields.createdAt: createdAt,
      };
  
   CategoryModel copyWith({
    int? id,
    String? name,
    String? imageUrl,
    String? createdAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}