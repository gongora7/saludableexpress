class Zone {
  int zoneId;
  String zoneName;
  int zoneCountryId;
  String zoneCode;
  String createdAt;
  String updatedAt;

  Zone(
      {this.zoneId,
        this.zoneName,
        this.zoneCountryId,
        this.zoneCode,
        this.createdAt,
        this.updatedAt});

  Zone.fromJson(Map<String, dynamic> json) {
    zoneId = json['zone_id'];
    zoneName = json['zone_name'];
    zoneCountryId = json['zone_country_id'];
    zoneCode = json['zone_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zone_id'] = this.zoneId;
    data['zone_name'] = this.zoneName;
    data['zone_country_id'] = this.zoneCountryId;
    data['zone_code'] = this.zoneCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}