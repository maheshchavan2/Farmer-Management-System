class VillageList {
  int? villageId;
  String? villageName;

  VillageList({this.villageId, this.villageName});

  VillageList.fromJson(Map<String, dynamic> json) {
    villageId = json['VillageId'];
    villageName = json['VillageName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VillageId'] = this.villageId;
    data['VillageName'] = this.villageName;
    return data;
  }
}
