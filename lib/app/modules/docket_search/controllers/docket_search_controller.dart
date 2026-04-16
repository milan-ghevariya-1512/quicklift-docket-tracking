
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../Reusability/utils/util.dart';
import '../../../../Reusability/widgets/common_widget.dart';
import '../../../data/model/get_organization_model.dart';
import '../../../data/service/api_services.dart';
import '../../../routes/app_pages.dart';

class DocketSearchController extends GetxController {

  GetOrganizationModel organizationModel = GetOrganizationModel();
  var args = [];

  TextEditingController docketController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled.obs;

  DashBoardService dashBoardService = DashBoardService();
  final fd = FocusNode();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    args = Get.arguments;
    if (args.isNotEmpty) {
      organizationModel = args.first;
    }
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
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'username' : 'QUICKAPI',
      'password' : 'QUi(&*qe3&.01!'
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