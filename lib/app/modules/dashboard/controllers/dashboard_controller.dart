import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../Reusability/utils/util.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../data/model/get_organization_model.dart';
import '../../../data/service/api_services.dart';
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getOrganization(filter: true);
  }

  getOrganization({bool filter = false}) async {
    isLoaded.value = true;
    organizationList.clear();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    var result = await dashBoardService.getOrganization(header: headers);
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
    print("Utils().box.read('token') ${Utils().getToken()}");
    var token = await Utils().getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization' : "Bearer $token"
      // 'username' : 'QUICKAPI',
      // 'password' : 'QUi(&*qe3&.01!'
    };
    var result = await dashBoardService.searchDocket(body: body,header: headers);
    if(Get.isDialogOpen!) Get.back();
    if(result != null
        && result.isNotEmpty
        && result.first.apiDocket != null
    ) {
      Get.toNamed(Routes.DOCKETDETAILS,arguments: [result.first,docketController.text.trim()]);
    } else{
      CommonWidget.toast("Docket No Is Invalid Or Not Belongs To This Company");
    }
    update();
  }

}