class Country {
  int countriesId;
  String countriesName;
  String countriesIsoCode3;
  String countriesIsoCode2;
  String countryCode;
  String createdAt;
  String updatedAt;
  int addressFormatId;

  Country(
      {this.countriesId,
        this.countriesName,
        this.countriesIsoCode3,
        this.countriesIsoCode2,
        this.countryCode,
        this.createdAt,
        this.updatedAt,
        this.addressFormatId});

  Country.fromJson(Map<String, dynamic> json) {
    countriesId = json['countries_id'];
    countriesName = json['countries_name'];
    countriesIsoCode3 = json['countries_iso_code_3'];
    countriesIsoCode2 = json['countries_iso_code_2'];
    countryCode = json['country_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    addressFormatId = json['address_format_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countries_id'] = this.countriesId;
    data['countries_name'] = this.countriesName;
    data['countries_iso_code_3'] = this.countriesIsoCode3;
    data['countries_iso_code_2'] = this.countriesIsoCode2;
    data['country_code'] = this.countryCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['address_format_id'] = this.addressFormatId;
    return data;
  }
}