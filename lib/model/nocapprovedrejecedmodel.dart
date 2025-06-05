class NOCApprovedRejectedModel {
  String? status;
  String? message;
  Data? data;

  NOCApprovedRejectedModel({this.status, this.message, this.data});

  NOCApprovedRejectedModel.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] is bool ? json['status'].toString() : json['status'];
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
  List<ApprovedRejectList>? approvedRejectList;

  Data({this.areaRangeName, this.group, this.approvedRejectList});

  Data.fromJson(Map<String, dynamic> json) {
    areaRangeName = json['area_range_name'];
    group = json['group'];
    if (json['approved_reject_list'] != null) {
      approvedRejectList = <ApprovedRejectList>[];
      json['approved_reject_list'].forEach((v) {
        approvedRejectList!.add(ApprovedRejectList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area_range_name'] = areaRangeName;
    data['group'] = group;
    if (approvedRejectList != null) {
      data['approved_reject_list'] =
          approvedRejectList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApprovedRejectList {
  int? id;
  String? nocApplicationIdNocOfLandApplicationId;
  String? nocApplicationIdName;
  String? nocApplicationIdNocCreatedAt;
  String? nocApplicationIdPurpose;

  ApprovedRejectList(
      {this.id,
      this.nocApplicationIdNocOfLandApplicationId,
      this.nocApplicationIdName,
      this.nocApplicationIdNocCreatedAt,
      this.nocApplicationIdPurpose});

  ApprovedRejectList.fromJson(Map<String, dynamic> json) {
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
