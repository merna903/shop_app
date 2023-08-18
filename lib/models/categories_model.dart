class CategoriesModel {
  late bool status;
  late CategoriesDateModel data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDateModel.fromJson(json['data']);
  }
}

class CategoriesDateModel {
  late int currentPage;
  late List<CurrentPageData> data;

  CategoriesDateModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = List<CurrentPageData>.from(
      json['data'].map((element) => CurrentPageData.fromJson(element)),
    );
  }
}

class CurrentPageData {
  late int id;
  late String name;
  late String image;

  CurrentPageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }
}

