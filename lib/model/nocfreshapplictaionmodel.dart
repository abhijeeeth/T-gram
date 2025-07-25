class NOCFreshapplicationModel {
  String? status;
  String? message;
  Data? data;

  NOCFreshapplicationModel({this.status, this.message, this.data});

  NOCFreshapplicationModel.fromJson(Map<String, dynamic> json) {
    status = json['status']?.toString();
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
  List<PendingList>? pendingList;

  Data({this.areaRangeName, this.group, this.pendingList});

  Data.fromJson(Map<String, dynamic> json) {
    areaRangeName = json['area_range_name'];
    group = json['group'];
    if (json['pending_list'] != null) {
      pendingList = <PendingList>[];
      json['pending_list'].forEach((v) {
        pendingList!.add(PendingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area_range_name'] = areaRangeName;
    data['group'] = group;
    if (pendingList != null) {
      data['pending_list'] = pendingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PendingList {
  int? id;
  int? idMain; // Added field
  String? nocApplicationIdNocOfLandApplicationId;
  String? nocApplicationIdName;
  String? nocApplicationIdNocCreatedAt;
  String? nocApplicationIdPurpose;
  bool? siteInception;
  bool? rfoSiteInception;
  bool? siteInceptionRfo;

  PendingList({
    this.id,
    this.idMain, // Added to constructor
    this.nocApplicationIdNocOfLandApplicationId,
    this.nocApplicationIdName,
    this.nocApplicationIdNocCreatedAt,
    this.nocApplicationIdPurpose,
    this.siteInception,
    this.rfoSiteInception,
    this.siteInceptionRfo,
  });

  PendingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idMain = json['id_main']; // Added fromJson
    nocApplicationIdNocOfLandApplicationId =
        json['noc_application_id__noc_of_land_application_id'];
    nocApplicationIdName = json['noc_application_id__name'];
    nocApplicationIdNocCreatedAt = json['noc_application_id__noc_created_at'];
    nocApplicationIdPurpose = json['noc_application_id__purpose'];
    siteInception = json['site_inception'];
    rfoSiteInception = json['rfo_site_inception'];
    siteInceptionRfo = json['site_inception_rfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_main'] = idMain; // Added toJson
    data['noc_application_id__noc_of_land_application_id'] =
        nocApplicationIdNocOfLandApplicationId;
    data['noc_application_id__name'] = nocApplicationIdName;
    data['noc_application_id__noc_created_at'] = nocApplicationIdNocCreatedAt;
    data['noc_application_id__purpose'] = nocApplicationIdPurpose;
    data['site_inception'] = siteInception;
    data['rfo_site_inception'] = rfoSiteInception;
    data['site_inception_rfo'] = siteInceptionRfo;
    return data;
  }
}
