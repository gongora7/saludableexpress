class MyAddress {
  int defaultAddress;
  int addressId;
  String gender;
  String company;
  String firstname;
  String lastname;
  String street;
  String suburb;
  String postcode;
  String city;
  String state;
  String latitude;
  String longitude;
  int countriesId;
  String countryName;
  int zoneId;
  String zoneCode;
  String zoneName;

  MyAddress(
      {this.defaultAddress,
        this.addressId,
        this.gender,
        this.company,
        this.firstname,
        this.lastname,
        this.street,
        this.suburb,
        this.postcode,
        this.city,
        this.state,
        this.latitude,
        this.longitude,
        this.countriesId,
        this.countryName,
        this.zoneId,
        this.zoneCode,
        this.zoneName});

  MyAddress.fromJson(Map<String, dynamic> json) {
    defaultAddress = json['default_address'];
    addressId = json['address_id'];
    gender = json['gender'];
    company = json['company'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    street = json['street'];
    suburb = json['suburb'];
    postcode = json['postcode'];
    city = json['city'];
    state = json['state'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    countriesId = json['countries_id'];
    countryName = json['country_name'];
    zoneId = json['zone_id'];
    zoneCode = json['zone_code'];
    zoneName = json['zone_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['default_address'] = this.defaultAddress;
    data['address_id'] = this.addressId;
    data['gender'] = this.gender;
    data['company'] = this.company;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['street'] = this.street;
    data['suburb'] = this.suburb;
    data['postcode'] = this.postcode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['countries_id'] = this.countriesId;
    data['country_name'] = this.countryName;
    data['zone_id'] = this.zoneId;
    data['zone_code'] = this.zoneCode;
    data['zone_name'] = this.zoneName;
    return data;
  }
}