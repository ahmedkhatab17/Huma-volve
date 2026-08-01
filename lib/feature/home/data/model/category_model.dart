import 'package:recipy_app_offline/feature/home/domain/entity/home_category_entity.dart';

class CategoryModel {
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;

  const CategoryModel({
    this.idCategory = '',
    this.strCategory = '',
    this.strCategoryThumb = '',
    this.strCategoryDescription = '',
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      idCategory: json['idCategory'] as String? ?? '',
      strCategory: json['strCategory'] as String? ?? '',
      strCategoryThumb: json['strCategoryThumb'] as String? ?? '',
      strCategoryDescription:
          json['strCategoryDescription'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategory': idCategory,
      'strCategory': strCategory,
      'strCategoryThumb': strCategoryThumb,
      'strCategoryDescription': strCategoryDescription,
    };
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      idCategory: idCategory,
      strCategory: strCategory,
      strCategoryThumb: strCategoryThumb,
      strCategoryDescription: strCategoryDescription,
    );
  }
}
