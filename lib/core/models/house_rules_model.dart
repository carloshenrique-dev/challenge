import 'data_model.dart';

class HouseRulesModel {
  bool? success;
  Data? data;
  String? message;

  HouseRulesModel({this.success, this.data, this.message});

  HouseRulesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  bool operator ==(covariant HouseRulesModel other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.data == data &&
        other.message == message;
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode ^ message.hashCode;
}
