class SliderModel {
  String? urlToImage;
  String? title;
  SliderModel({required this.urlToImage, required this.title});

  factory SliderModel.fromJson(Map<String, dynamic> jsonData) {
    return SliderModel(urlToImage: jsonData['urlToImage'], title: jsonData['title']);
  }

}