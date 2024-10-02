class User {
  int? userId;
  String? username;
  int? roleId;
  String? roleName;
  int? deptId;
  String? loginId;
  String? phoneNo;
  String? email;
  int? fType;
  String? farmerType;
  String? states;
  String? projects;

  User(
      {this.userId,
      this.username,
      this.roleId,
      this.roleName,
      this.deptId,
      this.loginId,
      this.phoneNo,
      this.email,
      this.fType,
      this.farmerType,
      this.states,
      this.projects});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    username = json['Username'];
    roleId = json['RoleId'];
    roleName = json['RoleName'];
    deptId = json['DeptId'];
    loginId = json['LoginId'];
    phoneNo = json['PhoneNo'];
    email = json['Email'];
    fType = json['FType'];
    farmerType = json['FarmerType'];
    states = json['States'];
    projects = json['Projects'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['Username'] = this.username;
    data['RoleId'] = this.roleId;
    data['RoleName'] = this.roleName;
    data['DeptId'] = this.deptId;
    data['LoginId'] = this.loginId;
    data['PhoneNo'] = this.phoneNo;
    data['Email'] = this.email;
    data['FType'] = this.fType;
    data['FarmerType'] = this.farmerType;
    data['States'] = this.states;
    data['Projects'] = this.projects;
    return data;
  }
}
