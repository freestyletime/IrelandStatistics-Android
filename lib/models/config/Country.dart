class Country {
  String? numCode;
  String? alpha2Code;
  String? alpha3Code;
  String? enShortName;
  String? nationality;

  Country(
      {this.numCode,
        this.alpha2Code,
        this.alpha3Code,
        this.enShortName,
        this.nationality});

  Country.fromJson(Map<String, dynamic> json) {
    numCode = json['num_code'];
    alpha2Code = json['alpha_2_code'];
    alpha3Code = json['alpha_3_code'];
    enShortName = json['en_short_name'];
    nationality = json['nationality'];
  }
}