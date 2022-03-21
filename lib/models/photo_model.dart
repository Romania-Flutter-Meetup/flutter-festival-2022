class PhotoModel {
  String? photoLink;

  PhotoModel.fromJson(Map<String, dynamic> json) {
    photoLink = json['photo_link'] ?? '';
  }
}
