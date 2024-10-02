class GetProjectAuthority {
  int? projectId;
  String? projectName;
  int? stateId;
  String? stateName;
  int? projectGroupId;
  String? projectGroupName;
  int? createdBy;
  String? createdOn;
  int? modifyBy;
  String? modifyOn;
  String? active;
  int? cCA;
  double? duty;

  GetProjectAuthority(
      {this.projectId,
      this.projectName,
      this.stateId,
      this.stateName,
      this.projectGroupId,
      this.projectGroupName,
      this.createdBy,
      this.createdOn,
      this.modifyBy,
      this.modifyOn,
      this.active,
      this.cCA,
      this.duty});

  GetProjectAuthority.fromJson(Map<String, dynamic> json) {
    projectId = json['ProjectId'];
    projectName = json['ProjectName'];
    stateId = json['StateId'];
    stateName = json['StateName'];
    projectGroupId = json['ProjectGroupId'];
    projectGroupName = json['ProjectGroupName'];
    createdBy = json['CreatedBy'];
    createdOn = json['CreatedOn'];
    modifyBy = json['ModifyBy'];
    modifyOn = json['ModifyOn'];
    active = json['Active'];
    cCA = json['CCA'];
    duty = json['Duty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjectId'] = this.projectId;
    data['ProjectName'] = this.projectName;
    data['StateId'] = this.stateId;
    data['StateName'] = this.stateName;
    data['ProjectGroupId'] = this.projectGroupId;
    data['ProjectGroupName'] = this.projectGroupName;
    data['CreatedBy'] = this.createdBy;
    data['CreatedOn'] = this.createdOn;
    data['ModifyBy'] = this.modifyBy;
    data['ModifyOn'] = this.modifyOn;
    data['Active'] = this.active;
    data['CCA'] = this.cCA;
    data['Duty'] = this.duty;
    return data;
  }
}
