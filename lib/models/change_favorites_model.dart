class ChangeFavouritesModel {
  late bool status;
  late String message;

  ChangeFavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
