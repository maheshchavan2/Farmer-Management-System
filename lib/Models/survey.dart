class Survey_page {
  int? projectId;
  String? projectName;
  int? stateId;
  String? stateName;
  String? projectGroupName;
  int? cCA;
  int? noOfFarmer;
  int? noOfFROs;
  double? areaAllocated;
  int? surveyed;
  int? notSurvey;
  int? surveyedApproved;

  Survey_page(
      {this.projectId,
      this.projectName,
      this.stateId,
      this.stateName,
      this.projectGroupName,
      this.cCA,
      this.noOfFarmer,
      this.noOfFROs,
      this.areaAllocated,
      this.surveyed,
      this.notSurvey,
      this.surveyedApproved});

  Survey_page.fromJson(Map<String, dynamic> json) {
    projectId = json['ProjectId'];
    projectName = json['ProjectName'];
    stateId = json['StateId'];
    stateName = json['StateName'];
    projectGroupName = json['ProjectGroupName'];
    cCA = json['CCA'];
    noOfFarmer = json['NoOfFarmer'];
    noOfFROs = json['NoOfFROs'];
    areaAllocated = json['AreaAllocated'];
    surveyed = json['Surveyed'];
    notSurvey = json['NotSurvey'];
    surveyedApproved = json['SurveyedApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjectId'] = this.projectId;
    data['ProjectName'] = this.projectName;
    data['StateId'] = this.stateId;
    data['StateName'] = this.stateName;
    data['ProjectGroupName'] = this.projectGroupName;
    data['CCA'] = this.cCA;
    data['NoOfFarmer'] = this.noOfFarmer;
    data['NoOfFROs'] = this.noOfFROs;
    data['AreaAllocated'] = this.areaAllocated;
    data['Surveyed'] = this.surveyed;
    data['NotSurvey'] = this.notSurvey;
    data['SurveyedApproved'] = this.surveyedApproved;
    return data;
  }
}
