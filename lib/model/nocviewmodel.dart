class NOCListViewModel {
  String? status;
  String? message;
  Data? data;

  NOCListViewModel({this.status, this.message, this.data});

  NOCListViewModel.fromJson(Map<String, dynamic> json) {
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
  NocApplication? nocApplication;
  String? userGroup;
  List<DivisionCommentsAndFiles>? divisionCommentsAndFiles;
  List<ClerkCommentsAndFiles>? clerkCommentsAndFiles;
  String? hasValidEntry;
  String? hasDivisionEntry;
  List<DeputyRfos>? deputyRfos;
  List<AdditionalDocument>? additionalDocuments;
  ImageDocuments? imageDocuments;

  Data(
      {this.nocApplication,
      this.userGroup,
      this.divisionCommentsAndFiles,
      this.clerkCommentsAndFiles,
      this.hasValidEntry,
      this.hasDivisionEntry,
      this.deputyRfos,
      this.additionalDocuments,
      this.imageDocuments});

  Data.fromJson(Map<String, dynamic> json) {
    nocApplication = json['noc_application'] != null
        ? NocApplication.fromJson(json['noc_application'])
        : null;
    userGroup = json['user_group'];
    if (json['division_comments_and_files'] != null) {
      divisionCommentsAndFiles = <DivisionCommentsAndFiles>[];
      json['division_comments_and_files'].forEach((v) {
        divisionCommentsAndFiles!.add(DivisionCommentsAndFiles.fromJson(v));
      });
    }
    if (json['clerk_comments_and_files'] != null) {
      clerkCommentsAndFiles = <ClerkCommentsAndFiles>[];
      json['clerk_comments_and_files'].forEach((v) {
        clerkCommentsAndFiles!.add(ClerkCommentsAndFiles.fromJson(v));
      });
    }
    hasValidEntry = json['has_valid_entry'];
    hasDivisionEntry = json['has_division_entry'];
    if (json['deputy_rfos'] != null) {
      deputyRfos = <DeputyRfos>[];
      json['deputy_rfos'].forEach((v) {
        deputyRfos!.add(DeputyRfos.fromJson(v));
      });
    }
    if (json['additional_documents'] != null) {
      additionalDocuments = <AdditionalDocument>[];
      json['additional_documents'].forEach((v) {
        additionalDocuments!.add(AdditionalDocument.fromJson(v));
      });
    }
    if (json['image_documents'] != null &&
        json['image_documents'] is Map<String, dynamic>) {
      imageDocuments = ImageDocuments.fromJson(json['image_documents']);
    } else {
      imageDocuments = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (nocApplication != null) {
      data['noc_application'] = nocApplication!.toJson();
    }
    data['user_group'] = userGroup;
    if (divisionCommentsAndFiles != null) {
      data['division_comments_and_files'] =
          divisionCommentsAndFiles!.map((v) => v.toJson()).toList();
    }
    if (clerkCommentsAndFiles != null) {
      data['clerk_comments_and_files'] =
          clerkCommentsAndFiles!.map((v) => v.toJson()).toList();
    }
    data['has_valid_entry'] = hasValidEntry;
    data['has_division_entry'] = hasDivisionEntry;
    if (deputyRfos != null) {
      data['deputy_rfos'] = deputyRfos!.map((v) => v.toJson()).toList();
    }
    if (additionalDocuments != null) {
      data['additional_documents'] =
          additionalDocuments!.map((v) => v.toJson()).toList();
    }
    if (imageDocuments != null) {
      data['image_documents'] = imageDocuments!.toJson();
    }
    return data;
  }
}

class NocApplication {
  int? id;
  String? nocOfLandApplicationId;
  int? byUserId;
  Null previousNocId;
  String? division;
  String? range;
  bool? hasAppliedBefore;
  Null previousNoc;
  String? name;
  String? nocIssuedName;
  String? otherName;
  bool? isInstitute;
  String? designation;
  String? instituteName;
  String? address;
  String? surveyNumber;
  String? district;
  String? taluka;
  bool? withForest;
  String? approximateDistance;
  String? village;
  String? panchayat;
  String? legislativeAssembly;
  String? block;
  String? pinCode;
  String? purpose;
  String? selectedIdProof;
  String? photoIdProof;
  String? ownershipPattyam;
  String? registrationDeed;
  String? possessionCertificate;
  String? landTaxReceipt;
  String? nocCreatedAt;
  int? clerkDivisionId;
  String? clerkDivisionCommentStepOne;
  String? clerkDivisionFileStepOne;
  String? clerkDivisionStepOneCommentDate;
  String? clerkDivisionStepOneApplicationStatus;
  Null clerkDivisionCommentStepTwo;
  Null clerkDivisionFileStepTwo;
  Null clerkDivisionStepTwoCommentDate;
  String? clerkDivisionStepTwoApplicationStatus;
  int? assignedDyrfoUserId;
  int? ministerialHeadId;
  String? ministerialHeadCommentStepOne;
  String? ministerialHeadFileStepOne;
  String? ministerialHeadStepOneCommentDate;
  String? ministerialHeadStepOneApplicationStatus;
  Null ministerialHeadCommentStepTwo;
  Null ministerialHeadFileStepTwo;
  Null ministerialHeadStepTwoCommentDate;
  String? ministerialHeadStepTwoApplicationStatus;
  int? dfoId;
  String? dfoCommentStepOne;
  String? dfoFileStepOne;
  String? dfoStepOneCommentDate;
  String? dfoStepOneApplicationStatus;
  Null dfoCommentStepTwo;
  Null dfoFileStepTwo;
  Null dfoStepTwoCommentDate;
  String? dfoStepTwoApplicationStatus;
  int? clerkRangeId;
  String? clerkRangeComment;
  String? clerkRangeFile;
  String? clerkRangeCommentDate;
  String? clerkRangeApplicationStatus;
  int? rfoId;
  String? rfoCommentStepOne;
  String? rfoFileStepOne;
  String? rfoStepOneCommentDate;
  String? rfoStepOneApplicationStatus;
  Null rfoCommentStepTwo;
  Null rfoFileStepTwo;
  Null rfoStepTwoCommentDate;
  String? rfoStepTwoApplicationStatus;
  int? dyrfoId;
  String? dyrfoComment;
  String? dyrfoFile;
  String? dyrfoCommentDate;
  String? dyrfoApplicationStatus;
  String? inspectionReport;
  String? surveyReport;
  String? surveySketches;
  Null dfoDigitalSignature;
  String? clarificationSought;
  String? returnedOn;
  String? clarificationResponse;
  bool? siteInception;
  String? stepStatus;

  NocApplication(
      {this.id,
      this.nocOfLandApplicationId,
      this.byUserId,
      this.previousNocId,
      this.division,
      this.range,
      this.hasAppliedBefore,
      this.previousNoc,
      this.name,
      this.nocIssuedName,
      this.otherName,
      this.isInstitute,
      this.designation,
      this.instituteName,
      this.address,
      this.surveyNumber,
      this.district,
      this.taluka,
      this.withForest,
      this.approximateDistance,
      this.village,
      this.panchayat,
      this.legislativeAssembly,
      this.block,
      this.pinCode,
      this.purpose,
      this.selectedIdProof,
      this.photoIdProof,
      this.ownershipPattyam,
      this.registrationDeed,
      this.possessionCertificate,
      this.landTaxReceipt,
      this.nocCreatedAt,
      this.clerkDivisionId,
      this.clerkDivisionCommentStepOne,
      this.clerkDivisionFileStepOne,
      this.clerkDivisionStepOneCommentDate,
      this.clerkDivisionStepOneApplicationStatus,
      this.clerkDivisionCommentStepTwo,
      this.clerkDivisionFileStepTwo,
      this.clerkDivisionStepTwoCommentDate,
      this.clerkDivisionStepTwoApplicationStatus,
      this.assignedDyrfoUserId,
      this.ministerialHeadId,
      this.ministerialHeadCommentStepOne,
      this.ministerialHeadFileStepOne,
      this.ministerialHeadStepOneCommentDate,
      this.ministerialHeadStepOneApplicationStatus,
      this.ministerialHeadCommentStepTwo,
      this.ministerialHeadFileStepTwo,
      this.ministerialHeadStepTwoCommentDate,
      this.ministerialHeadStepTwoApplicationStatus,
      this.dfoId,
      this.dfoCommentStepOne,
      this.dfoFileStepOne,
      this.dfoStepOneCommentDate,
      this.dfoStepOneApplicationStatus,
      this.dfoCommentStepTwo,
      this.dfoFileStepTwo,
      this.dfoStepTwoCommentDate,
      this.dfoStepTwoApplicationStatus,
      this.clerkRangeId,
      this.clerkRangeComment,
      this.clerkRangeFile,
      this.clerkRangeCommentDate,
      this.clerkRangeApplicationStatus,
      this.rfoId,
      this.rfoCommentStepOne,
      this.rfoFileStepOne,
      this.rfoStepOneCommentDate,
      this.rfoStepOneApplicationStatus,
      this.rfoCommentStepTwo,
      this.rfoFileStepTwo,
      this.rfoStepTwoCommentDate,
      this.rfoStepTwoApplicationStatus,
      this.dyrfoId,
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

  NocApplication.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nocOfLandApplicationId = json['noc_of_land_application_id'];
    byUserId = json['by_user_id'];
    previousNocId = json['previous_noc_id'];
    division = json['division'];
    range = json['range'];
    hasAppliedBefore = json['has_applied_before'];
    previousNoc = json['previous_noc'];
    name = json['name'];
    nocIssuedName = json['noc_issued_name'];
    otherName = json['other_name'];
    isInstitute = json['is_institute'];
    designation = json['designation'];
    instituteName = json['institute_name'];
    address = json['address'];
    surveyNumber = json['survey_number'];
    district = json['district'];
    taluka = json['taluka'];
    withForest = json['with_forest'];
    approximateDistance = json['approximate_distance'];
    village = json['village'];
    panchayat = json['panchayat'];
    legislativeAssembly = json['legislative_assembly'];
    block = json['block'];
    pinCode = json['pin_code'];
    purpose = json['purpose'];
    selectedIdProof = json['selected_id_proof'];
    photoIdProof = json['photo_id_proof'];
    ownershipPattyam = json['ownership_pattyam'];
    registrationDeed = json['registration_deed'];
    possessionCertificate = json['possession_certificate'];
    landTaxReceipt = json['land_tax_receipt'];
    nocCreatedAt = json['noc_created_at'];
    clerkDivisionId = json['clerk_division_id'];
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
    ministerialHeadId = json['ministerial_head_id'];
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
    dfoId = json['dfo_id'];
    dfoCommentStepOne = json['dfo_comment_step_one'];
    dfoFileStepOne = json['dfo_file_step_one'];
    dfoStepOneCommentDate = json['dfo_step_one_comment_date'];
    dfoStepOneApplicationStatus = json['dfo_step_one_application_status'];
    dfoCommentStepTwo = json['dfo_comment_step_two'];
    dfoFileStepTwo = json['dfo_file_step_two'];
    dfoStepTwoCommentDate = json['dfo_step_two_comment_date'];
    dfoStepTwoApplicationStatus = json['dfo_step_two_application_status'];
    clerkRangeId = json['clerk_range_id'];
    clerkRangeComment = json['clerk_range_comment'];
    clerkRangeFile = json['clerk_range_file'];
    clerkRangeCommentDate = json['clerk_range_comment_date'];
    clerkRangeApplicationStatus = json['clerk_range_application_status'];
    rfoId = json['rfo_id'];
    rfoCommentStepOne = json['rfo_comment_step_one'];
    rfoFileStepOne = json['rfo_file_step_one'];
    rfoStepOneCommentDate = json['rfo_step_one_comment_date'];
    rfoStepOneApplicationStatus = json['rfo_step_one_application_status'];
    rfoCommentStepTwo = json['rfo_comment_step_two'];
    rfoFileStepTwo = json['rfo_file_step_two'];
    rfoStepTwoCommentDate = json['rfo_step_two_comment_date'];
    rfoStepTwoApplicationStatus = json['rfo_step_two_application_status'];
    dyrfoId = json['dyrfo_id'];
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
    data['noc_of_land_application_id'] = nocOfLandApplicationId;
    data['by_user_id'] = byUserId;
    data['previous_noc_id'] = previousNocId;
    data['division'] = division;
    data['range'] = range;
    data['has_applied_before'] = hasAppliedBefore;
    data['previous_noc'] = previousNoc;
    data['name'] = name;
    data['noc_issued_name'] = nocIssuedName;
    data['other_name'] = otherName;
    data['is_institute'] = isInstitute;
    data['designation'] = designation;
    data['institute_name'] = instituteName;
    data['address'] = address;
    data['survey_number'] = surveyNumber;
    data['district'] = district;
    data['taluka'] = taluka;
    data['with_forest'] = withForest;
    data['approximate_distance'] = approximateDistance;
    data['village'] = village;
    data['panchayat'] = panchayat;
    data['legislative_assembly'] = legislativeAssembly;
    data['block'] = block;
    data['pin_code'] = pinCode;
    data['purpose'] = purpose;
    data['selected_id_proof'] = selectedIdProof;
    data['photo_id_proof'] = photoIdProof;
    data['ownership_pattyam'] = ownershipPattyam;
    data['registration_deed'] = registrationDeed;
    data['possession_certificate'] = possessionCertificate;
    data['land_tax_receipt'] = landTaxReceipt;
    data['noc_created_at'] = nocCreatedAt;
    data['clerk_division_id'] = clerkDivisionId;
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
    data['ministerial_head_id'] = ministerialHeadId;
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
    data['dfo_id'] = dfoId;
    data['dfo_comment_step_one'] = dfoCommentStepOne;
    data['dfo_file_step_one'] = dfoFileStepOne;
    data['dfo_step_one_comment_date'] = dfoStepOneCommentDate;
    data['dfo_step_one_application_status'] = dfoStepOneApplicationStatus;
    data['dfo_comment_step_two'] = dfoCommentStepTwo;
    data['dfo_file_step_two'] = dfoFileStepTwo;
    data['dfo_step_two_comment_date'] = dfoStepTwoCommentDate;
    data['dfo_step_two_application_status'] = dfoStepTwoApplicationStatus;
    data['clerk_range_id'] = clerkRangeId;
    data['clerk_range_comment'] = clerkRangeComment;
    data['clerk_range_file'] = clerkRangeFile;
    data['clerk_range_comment_date'] = clerkRangeCommentDate;
    data['clerk_range_application_status'] = clerkRangeApplicationStatus;
    data['rfo_id'] = rfoId;
    data['rfo_comment_step_one'] = rfoCommentStepOne;
    data['rfo_file_step_one'] = rfoFileStepOne;
    data['rfo_step_one_comment_date'] = rfoStepOneCommentDate;
    data['rfo_step_one_application_status'] = rfoStepOneApplicationStatus;
    data['rfo_comment_step_two'] = rfoCommentStepTwo;
    data['rfo_file_step_two'] = rfoFileStepTwo;
    data['rfo_step_two_comment_date'] = rfoStepTwoCommentDate;
    data['rfo_step_two_application_status'] = rfoStepTwoApplicationStatus;
    data['dyrfo_id'] = dyrfoId;
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

class DivisionCommentsAndFiles {
  String? officer;
  String? comment;
  String? file;
  String? date;

  DivisionCommentsAndFiles({this.officer, this.comment, this.file, this.date});

  DivisionCommentsAndFiles.fromJson(Map<String, dynamic> json) {
    officer = json['officer'];
    comment = json['comment'];
    file = json['file'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['officer'] = officer;
    data['comment'] = comment;
    data['file'] = file;
    data['date'] = date;
    return data;
  }
}

class ClerkCommentsAndFiles {
  String? officer;
  String? comment;
  String? file;
  String? date;

  ClerkCommentsAndFiles({this.officer, this.comment, this.file, this.date});

  ClerkCommentsAndFiles.fromJson(Map<String, dynamic> json) {
    officer = json['officer'];
    comment = json['comment'];
    file = json['file'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['officer'] = officer;
    data['comment'] = comment;
    data['file'] = file;
    data['date'] = date;
    return data;
  }
}

class DeputyRfos {
  int? id;
  String? name;
  String? address;

  DeputyRfos({this.id, this.name, this.address});

  DeputyRfos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    return data;
  }
}

class ImageDocuments {
  String? locationImg1;
  String? locationImg2;
  String? locationImg3;
  String? locationImg4;
  String? image1Lat;
  String? image2Lat;
  String? image3Lat;
  String? image4Lat;
  String? image1Log;
  String? image2Log;
  String? image3Log;
  String? image4Log;

  ImageDocuments(
      {this.locationImg1,
      this.locationImg2,
      this.locationImg3,
      this.locationImg4,
      this.image1Lat,
      this.image2Lat,
      this.image3Lat,
      this.image4Lat,
      this.image1Log,
      this.image2Log,
      this.image3Log,
      this.image4Log});

  ImageDocuments.fromJson(Map<String, dynamic> json) {
    locationImg1 = json['location_img1'];
    locationImg2 = json['location_img2'];
    locationImg3 = json['location_img3'];
    locationImg4 = json['location_img4'];
    image1Lat = json['image1_lat'];
    image2Lat = json['image2_lat'];
    image3Lat = json['image3_lat'];
    image4Lat = json['image4_lat'];
    image1Log = json['image1_log'];
    image2Log = json['image2_log'];
    image3Log = json['image3_log'];
    image4Log = json['image4_log'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['location_img1'] = locationImg1;
    data['location_img2'] = locationImg2;
    data['location_img3'] = locationImg3;
    data['location_img4'] = locationImg4;
    data['image1_lat'] = image1Lat;
    data['image2_lat'] = image2Lat;
    data['image3_lat'] = image3Lat;
    data['image4_lat'] = image4Lat;
    data['image1_log'] = image1Log;
    data['image2_log'] = image2Log;
    data['image3_log'] = image3Log;
    data['image4_log'] = image4Log;
    return data;
  }
}

class AdditionalDocument {
  int? id;
  String? category;
  String? document;
  String? name;
  String? uploadedAt;

  AdditionalDocument({
    this.id,
    this.category,
    this.document,
    this.name,
    this.uploadedAt,
  });

  AdditionalDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    document = json['document'];
    name = json['name'];
    uploadedAt = json['uploaded_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['document'] = document;
    data['name'] = name;
    data['uploaded_at'] = uploadedAt;
    return data;
  }
}
