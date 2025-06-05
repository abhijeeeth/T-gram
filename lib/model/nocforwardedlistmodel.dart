class NOCForwardedListModel {
  String? status;
  String? message;
  Data? data;

  NOCForwardedListModel({this.status, this.message, this.data});

  NOCForwardedListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? areaRangeName;
  String? group;
  List<ForwardedList>? forwardedList;

  Data({this.areaRangeName, this.group, this.forwardedList});

  Data.fromJson(Map<String, dynamic> json) {
    areaRangeName = json['area_range_name'];
    group = json['group'];
    if (json['forwarded_list'] != null) {
      forwardedList = <ForwardedList>[];
      json['forwarded_list'].forEach((v) {
        forwardedList!.add(ForwardedList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area_range_name'] = areaRangeName;
    data['group'] = group;
    if (forwardedList != null) {
      data['forwarded_list'] = forwardedList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ForwardedList {
  int? id;
  String? nocApplicationIdNocOfLandApplicationId;
  String? nocApplicationIdName;
  String? nocApplicationIdNocCreatedAt;
  String? nocApplicationIdPurpose;

  ForwardedList(
      {this.id,
      this.nocApplicationIdNocOfLandApplicationId,
      this.nocApplicationIdName,
      this.nocApplicationIdNocCreatedAt,
      this.nocApplicationIdPurpose});

  ForwardedList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nocApplicationIdNocOfLandApplicationId =
        json['noc_application_id__noc_of_land_application_id'];
    nocApplicationIdName = json['noc_application_id__name'];
    nocApplicationIdNocCreatedAt = json['noc_application_id__noc_created_at'];
    nocApplicationIdPurpose = json['noc_application_id__purpose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['noc_application_id__noc_of_land_application_id'] =
        nocApplicationIdNocOfLandApplicationId;
    data['noc_application_id__name'] = nocApplicationIdName;
    data['noc_application_id__noc_created_at'] = nocApplicationIdNocCreatedAt;
    data['noc_application_id__purpose'] = nocApplicationIdPurpose;
    return data;
  }
}
