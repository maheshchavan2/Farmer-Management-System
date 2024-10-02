class Frolist {
  int? froid;
  String? froname;
  int? noOfFarmer;
  double? areaAllocated;
  int? surveyed;
  int? notSurvey;
  int? surveyedApproved;
  Null? frmId;
  Null? frmName;

  Frolist(
      {this.froid,
      this.froname,
      this.noOfFarmer,
      this.areaAllocated,
      this.surveyed,
      this.notSurvey,
      this.surveyedApproved,
      this.frmId,
      this.frmName});

  Frolist.fromJson(Map<String, dynamic> json) {
    froid = json['froid'];
    froname = json['froname'];
    noOfFarmer = json['NoOfFarmer'];
    areaAllocated = json['AreaAllocated'];
    surveyed = json['Surveyed'];
    notSurvey = json['NotSurvey'];
    surveyedApproved = json['SurveyedApproved'];
    frmId = json['FrmId'];
    frmName = json['FrmName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['froid'] = this.froid;
    data['froname'] = this.froname;
    data['NoOfFarmer'] = this.noOfFarmer;
    data['AreaAllocated'] = this.areaAllocated;
    data['Surveyed'] = this.surveyed;
    data['NotSurvey'] = this.notSurvey;
    data['SurveyedApproved'] = this.surveyedApproved;
    data['FrmId'] = this.frmId;
    data['FrmName'] = this.frmName;
    return data;
  }
}
