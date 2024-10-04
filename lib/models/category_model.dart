import 'package:hive/hive.dart';

part 'category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel extends HiveObject{
  @HiveField(0)
  String? category;
  @HiveField(1)
  String? id;

  CategoryModel({this.category, this.id});

  @override
  bool operator ==(covariant Object other) {
    return identical(this, other) ||
        other is CategoryModel &&
            category == other.category &&
            id == other.id;
  }

  @override
  int get hashCode => id.hashCode ^ category.hashCode;
}
