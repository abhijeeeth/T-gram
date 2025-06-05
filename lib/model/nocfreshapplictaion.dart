class NOCFreshapplication {
  String? status;
  String? message;
  Data? data;

  NOCFreshapplication({this.status, this.message, this.data});

  NOCFreshapplication.fromJson(Map<String, dynamic> json) {
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
  int? nocApplicationIdId;
  int? clerkDivisionIdId;
  String? clerkDivisionCommentStepOne;
  String? clerkDivisionFileStepOne;
  String? clerkDivisionStepOneCommentDate;
  String? clerkDivisionStepOneApplicationStatus;
  Null clerkDivisionCommentStepTwo;
  Null clerkDivisionFileStepTwo;
  Null clerkDivisionStepTwoCommentDate;
  String? clerkDivisionStepTwoApplicationStatus;
  int? assignedDyrfoUserId;
  int? ministerialHeadIdId;
  String? ministerialHeadCommentStepOne;
  String? ministerialHeadFileStepOne;
  String? ministerialHeadStepOneCommentDate;
  String? ministerialHeadStepOneApplicationStatus;
  Null ministerialHeadCommentStepTwo;
  Null ministerialHeadFileStepTwo;
  Null ministerialHeadStepTwoCommentDate;
  String? ministerialHeadStepTwoApplicationStatus;
  int? dfoIdId;
  String? dfoCommentStepOne;
  String? dfoFileStepOne;
  String? dfoStepOneCommentDate;
  String? dfoStepOneApplicationStatus;
  Null dfoCommentStepTwo;
  Null dfoFileStepTwo;
  Null dfoStepTwoCommentDate;
  String? dfoStepTwoApplicationStatus;
  int? clerkRangeIdId;
  String? clerkRangeComment;
  String? clerkRangeFile;
  String? clerkRangeCommentDate;
  String? clerkRangeApplicationStatus;
  int? rfoIdId;
  String? rfoCommentStepOne;
  String? rfoFileStepOne;
  String? rfoStepOneCommentDate;
  String? rfoStepOneApplicationStatus;
  Null rfoCommentStepTwo;
  Null rfoFileStepTwo;
  Null rfoStepTwoCommentDate;
  String? rfoStepTwoApplicationStatus;
  int? dyrfoIdId;
  String? dyrfoComment;
  String? dyrfoFile;
  String? dyrfoCommentDate;
  String? dyrfoApplicationStatus;
  Null inspectionReport;
  Null surveyReport;
  Null surveySketches;
  Null dfoDigitalSignature;
  Null clarificationSought;
  Null returnedOn;
  String? clarificationResponse;
  bool? siteInception;
  String? stepStatus;

  PendingList(
      {this.id,
      this.nocApplicationIdId,
      this.clerkDivisionIdId,
      this.clerkDivisionCommentStepOne,
      this.clerkDivisionFileStepOne,
      this.clerkDivisionStepOneCommentDate,
      this.clerkDivisionStepOneApplicationStatus,
      this.clerkDivisionCommentStepTwo,
      this.clerkDivisionFileStepTwo,
      this.clerkDivisionStepTwoCommentDate,
      this.clerkDivisionStepTwoApplicationStatus,
      this.assignedDyrfoUserId,
      this.ministerialHeadIdId,
      this.ministerialHeadCommentStepOne,
      this.ministerialHeadFileStepOne,
      this.ministerialHeadStepOneCommentDate,
      this.ministerialHeadStepOneApplicationStatus,
      this.ministerialHeadCommentStepTwo,
      this.ministerialHeadFileStepTwo,
      this.ministerialHeadStepTwoCommentDate,
      this.ministerialHeadStepTwoApplicationStatus,
      this.dfoIdId,
      this.dfoCommentStepOne,
      this.dfoFileStepOne,
      this.dfoStepOneCommentDate,
      this.dfoStepOneApplicationStatus,
      this.dfoCommentStepTwo,
      this.dfoFileStepTwo,
      this.dfoStepTwoCommentDate,
      this.dfoStepTwoApplicationStatus,
      this.clerkRangeIdId,
      this.clerkRangeComment,
      this.clerkRangeFile,
      this.clerkRangeCommentDate,
      this.clerkRangeApplicationStatus,
      this.rfoIdId,
      this.rfoCommentStepOne,
      this.rfoFileStepOne,
      this.rfoStepOneCommentDate,
      this.rfoStepOneApplicationStatus,
      this.rfoCommentStepTwo,
      this.rfoFileStepTwo,
      this.rfoStepTwoCommentDate,
      this.rfoStepTwoApplicationStatus,
      this.dyrfoIdId,
      this.dyrfoComment,
      this.dyrfoFile,
      this.dyrfoCommentDate,
      this.dyrfoApplicationStatus,
      this.inspectionReport,
      this.surveyReport,
      this.surveySketches,
      this.dfoDigitalSignature,
      this.clarificationSought,
      this.returnedOn,
      this.clarificationResponse,
      this.siteInception,
      this.stepStatus});

  PendingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nocApplicationIdId = json['noc_application_id_id'];
    clerkDivisionIdId = json['clerk_division_id_id'];
    clerkDivisionCommentStepOne = json['clerk_division_comment_step_one'];
    clerkDivisionFileStepOne = json['clerk_division_file_step_one'];
    clerkDivisionStepOneCommentDate =
        json['clerk_division_step_one_comment_date'];
    clerkDivisionStepOneApplicationStatus =
        json['clerk_division_step_one_application_status'];
    clerkDivisionCommentStepTwo = json['clerk_division_comment_step_two'];
    clerkDivisionFileStepTwo = json['clerk_division_file_step_two'];
    clerkDivisionStepTwoCommentDate =
        json['clerk_division_step_two_comment_date'];
    clerkDivisionStepTwoApplicationStatus =
        json['clerk_division_step_two_application_status'];
    assignedDyrfoUserId = json['assigned_dyrfo_user_id'];
    ministerialHeadIdId = json['ministerial_head_id_id'];
    ministerialHeadCommentStepOne = json['ministerial_head_comment_step_one'];
    ministerialHeadFileStepOne = json['ministerial_head_file_step_one'];
    ministerialHeadStepOneCommentDate =
        json['ministerial_head_step_one_comment_date'];
    ministerialHeadStepOneApplicationStatus =
        json['ministerial_head_step_one_application_status'];
    ministerialHeadCommentStepTwo = json['ministerial_head_comment_step_two'];
    ministerialHeadFileStepTwo = json['ministerial_head_file_step_two'];
    ministerialHeadStepTwoCommentDate =
        json['ministerial_head_step_two_comment_date'];
    ministerialHeadStepTwoApplicationStatus =
        json['ministerial_head_step_two_application_status'];
    dfoIdId = json['dfo_id_id'];
    dfoCommentStepOne = json['dfo_comment_step_one'];
    dfoFileStepOne = json['dfo_file_step_one'];
    dfoStepOneCommentDate = json['dfo_step_one_comment_date'];
    dfoStepOneApplicationStatus = json['dfo_step_one_application_status'];
    dfoCommentStepTwo = json['dfo_comment_step_two'];
    dfoFileStepTwo = json['dfo_file_step_two'];
    dfoStepTwoCommentDate = json['dfo_step_two_comment_date'];
    dfoStepTwoApplicationStatus = json['dfo_step_two_application_status'];
    clerkRangeIdId = json['clerk_range_id_id'];
    clerkRangeComment = json['clerk_range_comment'];
    clerkRangeFile = json['clerk_range_file'];
    clerkRangeCommentDate = json['clerk_range_comment_date'];
    clerkRangeApplicationStatus = json['clerk_range_application_status'];
    rfoIdId = json['rfo_id_id'];
    rfoCommentStepOne = json['rfo_comment_step_one'];
    rfoFileStepOne = json['rfo_file_step_one'];
    rfoStepOneCommentDate = json['rfo_step_one_comment_date'];
    rfoStepOneApplicationStatus = json['rfo_step_one_application_status'];
    rfoCommentStepTwo = json['rfo_comment_step_two'];
    rfoFileStepTwo = json['rfo_file_step_two'];
    rfoStepTwoCommentDate = json['rfo_step_two_comment_date'];
    rfoStepTwoApplicationStatus = json['rfo_step_two_application_status'];
    dyrfoIdId = json['dyrfo_id_id'];
    dyrfoComment = json['dyrfo_comment'];
    dyrfoFile = json['dyrfo_file'];
    dyrfoCommentDate = json['dyrfo_comment_date'];
    dyrfoApplicationStatus = json['dyrfo_application_status'];
    inspectionReport = json['inspection_report'];
    surveyReport = json['survey_report'];
    surveySketches = json['survey_sketches'];
    dfoDigitalSignature = json['dfo_digital_signature'];
    clarificationSought = json['clarification_sought'];
    returnedOn = json['returned_on'];
    clarificationResponse = json['clarification_response'];
    siteInception = json['site_inception'];
    stepStatus = json['step_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['noc_application_id_id'] = nocApplicationIdId;
    data['clerk_division_id_id'] = clerkDivisionIdId;
    data['clerk_division_comment_step_one'] = clerkDivisionCommentStepOne;
    data['clerk_division_file_step_one'] = clerkDivisionFileStepOne;
    data['clerk_division_step_one_comment_date'] =
        clerkDivisionStepOneCommentDate;
    data['clerk_division_step_one_application_status'] =
        clerkDivisionStepOneApplicationStatus;
    data['clerk_division_comment_step_two'] = clerkDivisionCommentStepTwo;
    data['clerk_division_file_step_two'] = clerkDivisionFileStepTwo;
    data['clerk_division_step_two_comment_date'] =
        clerkDivisionStepTwoCommentDate;
    data['clerk_division_step_two_application_status'] =
        clerkDivisionStepTwoApplicationStatus;
    data['assigned_dyrfo_user_id'] = assignedDyrfoUserId;
    data['ministerial_head_id_id'] = ministerialHeadIdId;
    data['ministerial_head_comment_step_one'] = ministerialHeadCommentStepOne;
    data['ministerial_head_file_step_one'] = ministerialHeadFileStepOne;
    data['ministerial_head_step_one_comment_date'] =
        ministerialHeadStepOneCommentDate;
    data['ministerial_head_step_one_application_status'] =
        ministerialHeadStepOneApplicationStatus;
    data['ministerial_head_comment_step_two'] = ministerialHeadCommentStepTwo;
    data['ministerial_head_file_step_two'] = ministerialHeadFileStepTwo;
    data['ministerial_head_step_two_comment_date'] =
        ministerialHeadStepTwoCommentDate;
    data['ministerial_head_step_two_application_status'] =
        ministerialHeadStepTwoApplicationStatus;
    data['dfo_id_id'] = dfoIdId;
    data['dfo_comment_step_one'] = dfoCommentStepOne;
    data['dfo_file_step_one'] = dfoFileStepOne;
    data['dfo_step_one_comment_date'] = dfoStepOneCommentDate;
    data['dfo_step_one_application_status'] = dfoStepOneApplicationStatus;
    data['dfo_comment_step_two'] = dfoCommentStepTwo;
    data['dfo_file_step_two'] = dfoFileStepTwo;
    data['dfo_step_two_comment_date'] = dfoStepTwoCommentDate;
    data['dfo_step_two_application_status'] = dfoStepTwoApplicationStatus;
    data['clerk_range_id_id'] = clerkRangeIdId;
    data['clerk_range_comment'] = clerkRangeComment;
    data['clerk_range_file'] = clerkRangeFile;
    data['clerk_range_comment_date'] = clerkRangeCommentDate;
    data['clerk_range_application_status'] = clerkRangeApplicationStatus;
    data['rfo_id_id'] = rfoIdId;
    data['rfo_comment_step_one'] = rfoCommentStepOne;
    data['rfo_file_step_one'] = rfoFileStepOne;
    data['rfo_step_one_comment_date'] = rfoStepOneCommentDate;
    data['rfo_step_one_application_status'] = rfoStepOneApplicationStatus;
    data['rfo_comment_step_two'] = rfoCommentStepTwo;
    data['rfo_file_step_two'] = rfoFileStepTwo;
    data['rfo_step_two_comment_date'] = rfoStepTwoCommentDate;
    data['rfo_step_two_application_status'] = rfoStepTwoApplicationStatus;
    data['dyrfo_id_id'] = dyrfoIdId;
    data['dyrfo_comment'] = dyrfoComment;
    data['dyrfo_file'] = dyrfoFile;
    data['dyrfo_comment_date'] = dyrfoCommentDate;
    data['dyrfo_application_status'] = dyrfoApplicationStatus;
    data['inspection_report'] = inspectionReport;
    data['survey_report'] = surveyReport;
    data['survey_sketches'] = surveySketches;
    data['dfo_digital_signature'] = dfoDigitalSignature;
    data['clarification_sought'] = clarificationSought;
    data['returned_on'] = returnedOn;
    data['clarification_response'] = clarificationResponse;
    data['site_inception'] = siteInception;
    data['step_status'] = stepStatus;
    return data;
  }
}
