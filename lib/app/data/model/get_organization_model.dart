class GetOrganizationModel{
  String? organizationName;
  String? organizationPrefix;
  String? organizationId;
  String? companyImage;
  String? mobileAppLogo;

  GetOrganizationModel(
      {this.organizationName, this.organizationPrefix, this.organizationId, this.companyImage, this.mobileAppLogo});

  factory GetOrganizationModel.fromJson(Map<String, dynamic> json) {
    return GetOrganizationModel(
      organizationName : json['OrganizationName'] ?? '',
      organizationPrefix : json['OrganizationPrefix'] ?? '',
      organizationId : json['OrganizationId'] ?? '',
      companyImage : json['CompanyImage'] ?? '',
      mobileAppLogo : json['MobileAppLogo'] ?? '',
    );
  }
}
