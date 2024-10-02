class CropAdvisoryModel {
  CropAdvisoryModel({
    required this.id,
    required this.stateId,
    required this.stateName,
    required this.cropId,
    required this.cropName,
    required this.seasonId,
    required this.seasonName,
    required this.link,
    required this.recommendation,
    required this.filename,
    required this.path,
    required this.createdBy,
    required this.createdOn,
    required this.modifyBy,
    required this.active,
  });

  final int? id;
  final int? stateId;
  final String? stateName;
  final int? cropId;
  final String? cropName;
  final int? seasonId;
  final String? seasonName;
  final String? link;
  final String? recommendation;
  final String? filename;
  final String? path;
  final int? createdBy;
  final DateTime? createdOn;
  final int? modifyBy;
  final String? active;

  factory CropAdvisoryModel.fromJson(Map<String, dynamic> json) {
    return CropAdvisoryModel(
      id: json["id"],
      stateId: json["stateId"],
      stateName: json["stateName"],
      cropId: json["cropId"],
      cropName: json["cropName"],
      seasonId: json["seasonId"],
      seasonName: json["seasonName"],
      link: json["link"],
      recommendation: json["recommendation"],
      filename: json["filename"],
      path: json["path"],
      createdBy: json["createdBy"],
      createdOn: DateTime.tryParse(json["createdOn"] ?? ""),
      modifyBy: json["modifyBy"],
      active: json["active"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "stateId": stateId,
        "stateName": stateName,
        "cropId": cropId,
        "cropName": cropName,
        "seasonId": seasonId,
        "seasonName": seasonName,
        "link": link,
        "recommendation": recommendation,
        "filename": filename,
        "path": path,
        "createdBy": createdBy,
        "createdOn": createdOn?.toIso8601String(),
        "modifyBy": modifyBy,
        "active": active,
      };
}
