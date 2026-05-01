import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../Reusability/utils/storage_util.dart';
import '../../../../Reusability/utils/util.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../data/model/getLoginClaimModel.dart';
import '../../../data/model/get_organization_model.dart';
import '../../../data/service/api_services.dart';
import '../../../data/service/vehicle_service.dart';
import '../../../routes/app_pages.dart';

class DashboardController extends GetxController {

  var isLoaded = true.obs;
  List<GetOrganizationModel> organizationList = [];
  List<String> organizationIdList = ['1'];
  DashBoardService dashBoardService = DashBoardService();

  TextEditingController docketController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled.obs;
  final fd = FocusNode();
  GetLoginClaimModel? getLoginClaimModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getClaims();
    // getOrganization(filter: true);
  }

  getOrganization({bool filter = false}) async {
    isLoaded.value = true;
    organizationList.clear();
    var result = await dashBoardService.getOrganization();
    if(result != null) {
      if (filter) {
        result.forEach((element) {
          for(int i=0;i<organizationIdList.length;i++){
            if(element.organizationId == organizationIdList[i]){
              organizationList.add(element);
            }
          }
        });
      } else{
        organizationList.addAll(result);
      }
    }
    isLoaded.value = false;
    update();
  }

  validate(){
    if(formKey.currentState!.validate()) {
      fd.unfocus();
      searchDocket();
    } else {
      autoValidateMode.value = AutovalidateMode.disabled;
    }
    update();
  }

  searchDocket() async {
    Utils.showLoadingDialog();
    var body = {
      "dockets": [
        docketController.text.trim()
      ]
    };
    var result = await dashBoardService.searchDocket(body: body);
    if(Get.isDialogOpen!) Get.back();
    if(result != null
        && result.isNotEmpty
        && result.first.apiDocket != null
    ) {
      Get.toNamed(Routes.DOCKETDETAILS,arguments: [result.first,docketController.text.trim()]);
    } else{
      Utils.toastWarning("Docket No Is Invalid Or Not Belongs To This Company");
    }
    update();
  }

  getClaims() async {
    isLoaded.value = true;
    getLoginClaimModel = null;
    var result = await VehicleService().getClaims(navigateToCheck: true);
    isLoaded.value = false;
    if(result != null) {
      getLoginClaimModel = result;
      Utils().box.write(StorageUtil.currencyId, '');
      Utils().box.write(StorageUtil.locationId, '');
      Utils().box.write(StorageUtil.locationCode, '');
      Utils().box.write(StorageUtil.locationName, '');
      Utils().box.write(StorageUtil.companyId, '');
      Utils().box.write(StorageUtil.yearId, '');
      Utils().box.write(StorageUtil.organizationId, '');
      Utils().box.write(StorageUtil.userId, '');
      Utils().box.write(StorageUtil.currencyId, (result.baseCurrency ?? '').toString());
      Utils().box.write(StorageUtil.locationId, (result.currentLocationId ?? '').toString());
      Utils().box.write(StorageUtil.locationCode, (result.currentLocationCode ?? '').toString());
      Utils().box.write(StorageUtil.locationName, (result.currentLocationName ?? '').toString());
      Utils().box.write(StorageUtil.companyId, (result.companyId ?? '').toString());
      Utils().box.write(StorageUtil.yearId, (result.currentFinancialYear ?? '').toString());
      Utils().box.write(StorageUtil.organizationId, (result.organizationId ?? '').toString());
      Utils().box.write(StorageUtil.userId, (result.userId ?? '').toString());
    }
  }

}