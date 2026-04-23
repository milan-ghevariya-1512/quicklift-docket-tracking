class LegLocationModel{
  String? pointSequence;
  String? pointAddress;
  String? pointCity;
  String? pointState;
  String? pointCountry;
  String? pointPincode;
  String? pointAreaName;

  LegLocationModel(
      {this.pointSequence, this.pointAddress, this.pointCity, this.pointState, this.pointCountry, this.pointPincode, this.pointAreaName});

  factory LegLocationModel.fromJson(Map<String, dynamic> json) {
    return LegLocationModel(
      pointSequence : (json['PointSequence'] ?? 0).toString(),
      pointAddress : (json['PointAddress'] ?? '').toString(),
      pointCity : (json['PointCity'] ?? '').toString(),
      pointState : (json['PointState'] ?? '').toString(),
      pointCountry : (json['PointCountry'] ?? '').toString(),
      pointPincode : (json['PointPincode'] ?? '').toString(),
      pointAreaName : (json['PointAreaName'] ?? '').toString(),
    );
  }
}