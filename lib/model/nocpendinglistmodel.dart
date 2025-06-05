class NOCPendingModel {
  String? status;
  String? message;
  Data? data;

  NOCPendingModel({this.status, this.message, this.data});

  NOCPendingModel.fromJson(Map<String, dynamic> json) {
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
  List<InProcessingList>? inProcessingList;

  Data({this.areaRangeName, this.group, this.inProcessingList});

  Data.fromJson(Map<String, dynamic> json) {
    areaRangeName = json['area_range_name'];
    group = json['group'];
    if (json['in_processing_list'] != null) {
      inProcessingList = <InProcessingList>[];
      json['in_processing_list'].forEach((v) {
        inProcessingList!.add(InProcessingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area_range_name'] = areaRangeName;
    data['group'] = group;
    if (inProcessingList != null) {
      data['in_processing_list'] =
          inProcessingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InProcessingList {
  int? id;
  String? nocApplicationIdNocOfLandApplicationId;
  String? nocApplicationIdName;
  String? nocApplicationIdNocCreatedAt;
  String? nocApplicationIdPurpose;

  InProcessingList(
      {this.id,
      this.nocApplicationIdNocOfLandApplicationId,
      this.nocApplicationIdName,
      this.nocApplicationIdNocCreatedAt,
      this.nocApplicationIdPurpose});

  InProcessingList.fromJson(Map<String, dynamic> json) {
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
