import 'package:reciepe_app/feature/home/domain/entity/home_category_entity.dart';

class CategoryModel {
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  CategoryModel({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }
  //toEntity
  CategoryEntity toEntity() {
    return CategoryEntity(
      idCategory: idCategory ?? '',
      strCategory: strCategory ?? '',
      strCategoryThumb: strCategoryThumb ?? '',
      strCategoryDescription: strCategoryDescription ?? '',
    );
  }
}
