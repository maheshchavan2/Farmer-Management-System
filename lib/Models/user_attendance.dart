class UserDetailsMasterModel {
  int? attendanceId;
  String? attendanceStartTime;
  String? attendanceEndTime;
  String? attendanceStartLocation;
  String? attendanceEndLocation;
  String? workingHours;
  int? workingOnProject;
  int? userId;
  String? taskRemark;
  String? attendanceDate;

  UserDetailsMasterModel(
      {this.attendanceId,
      this.attendanceStartTime,
      this.attendanceEndTime,
      this.attendanceStartLocation,
      this.attendanceEndLocation,
      this.workingHours,
      this.workingOnProject,
      this.userId,
      this.taskRemark,
      this.attendanceDate});

  UserDetailsMasterModel.fromJson(Map<String, dynamic> json) {
    attendanceId = json['AttendanceId'];
    attendanceStartTime = json['AttendanceStartTime'];
    attendanceEndTime = json['AttendanceEndTime'];
    attendanceStartLocation = json['AttendanceStartLocation'];
    attendanceEndLocation = json['AttendanceEndLocation'];
    workingHours = json['WorkingHours'];
    workingOnProject = json['WorkingOnProject'];
    userId = json['UserId'];
    taskRemark = json['TaskRemark'];
    attendanceDate = json['AttendanceDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AttendanceId'] = this.attendanceId;
    data['AttendanceStartTime'] = this.attendanceStartTime;
    data['AttendanceEndTime'] = this.attendanceEndTime;
    data['AttendanceStartLocation'] = this.attendanceStartLocation;
    data['AttendanceEndLocation'] = this.attendanceEndLocation;
    data['WorkingHours'] = this.workingHours;
    data['WorkingOnProject'] = this.workingOnProject;
    data['UserId'] = this.userId;
    data['TaskRemark'] = this.taskRemark;
    data['AttendanceDate'] = this.attendanceDate;
    return data;
  }
}
