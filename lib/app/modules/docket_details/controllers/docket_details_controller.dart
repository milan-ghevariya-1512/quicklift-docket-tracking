import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../Reusability/utils/app_images.dart';
import '../../../../Reusability/utils/util.dart';
import '../../../data/model/get_docket_details_model.dart';

class DocketDetailsController extends GetxController {

  var isType = 0.obs;
  var docketNo = ''.obs;
  var podUrl = ''.obs;

  GetDocketDetailsModel docketDetails = GetDocketDetailsModel();
  List<ApiDocketEvents> apiDocketEvents = [];

  List<String> imgList = [AppImage.docketDetails1Image,AppImage.docketDetails2Image,AppImage.docketDetails3Image,AppImage.docketDetails4Image,AppImage.docketDetails5Image];
  List<String> title = ["Booking","Dispatched From Hub","Arrived At Hub","Out For Delivery","Delivery"];
  // List<String> subTitle = [
  //   "Date: 28-06-2022, Booked On jun 28,2022 from 327-jodhpur to 106-Bhagalpur Packages 1 gross weight 70",
  //   "Date: 03-07-2022 Despatched on jul 03,2022 11:36 from 323- Jaipur transhipment To 106-Bhagalpur by vehicle number",
  //   "",
  //   "",
  //   "Date: 12-10-2022 Delivered on oct 12, 2022 branch 106 - Bhagalpur"
  // ];

  List subTitle = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var args = Get.arguments ?? '';
    if(args.isNotEmpty){
      apiDocketEvents.clear();
      docketDetails = args.first;
      docketNo.value = args.last;
      apiDocketEvents.addAll(docketDetails.apiDocketEvents ?? []);
      latestEvent();
      podDownload();
    }
  }
  
  latestEvent(){
    subTitle.clear();
    subTitle = ["0","1","2","3","4"];
    var status = ["BK","OP2","OOP2","DS","DDSS"];
    var statusCode = [];
    (docketDetails.apiDocketEvents ?? []).sort((a, b) => DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse(a.trans_dtm ?? ''))).compareTo(DateTime.parse(DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.parse(b.trans_dtm ?? '')))));
    docketDetails.apiDocketEvents = (docketDetails.apiDocketEvents ?? []).reversed.toList();

    (docketDetails.apiDocketEvents ?? []).forEach((element) {
      log("${element.status_code} : ${element.trans_dtm}");
      status.forEach((e) {
        if(e == element.status_code && !statusCode.contains(element.status_code ?? '')){
          statusCode.add("$e");
          if(element.status_code == "BK"){
            subTitle.replaceRange(status.indexOf(element.status_code ?? ''), status.indexOf(element.status_code ?? '') + 1 , ["${element.docno} Booked On ${Utils.setDate(element.trans_dtm ?? '')}"]);
            log("${element.status_code} ${subTitle}");
          } else if(element.status_code == "OP2"){
            subTitle.replaceRange(status.indexOf(element.status_code ?? ''), status.indexOf(element.status_code ?? '') + 1, ["${element.docno} Dispatched On ${Utils.setDate(element.trans_dtm ?? '')}"]);
            log("${element.status_code} ${subTitle}");
          } else if(element.status_code == "OOP2"){
            subTitle.replaceRange(status.indexOf(element.status_code ?? ''), status.indexOf(element.status_code ?? '') + 1, ["${element.status} On ${Utils.setDate(element.trans_dtm ?? '')}"]);
            log("${element.status_code} ${subTitle}");
          } else if(element.status_code == "DS"){
            subTitle.replaceRange(status.indexOf(element.status_code ?? ''), status.indexOf(element.status_code ?? '') + 1, ["${element.docno} is ${element.status} on ${Utils.setDate(element.trans_dtm ?? '')}"]);
            log("${element.status_code} ${subTitle}");
          } else if(element.status_code == "DDSS"){
            subTitle.replaceRange(status.indexOf(element.status_code ?? ''), status.indexOf(element.status_code ?? '') + 1, ["${element.docno} is ${element.status} on ${Utils.setDate(element.trans_dtm ?? '')}"]);
            log("${element.status_code} ${subTitle}");
          }
        }
      });
    });

    List difference = status.toSet().difference(statusCode.toSet()).toList();
    // difference.forEach((ele) {subTitle.insert(status.indexOf(ele), "");});
    difference.forEach((ele) {subTitle.replaceRange(status.indexOf(ele ?? ''), status.indexOf(ele ?? '') + 1 , [""]);});

    log("difference : ${difference}");
    log("subTitle : ${statusCode}");
    log("subTitle11111111 :: ${subTitle.length}");
    log("subTitle11111111 :: $subTitle");
  }

  podDownload(){
    (docketDetails.apiDocketDeliveryAttempts ?? []).forEach((element) {
      if(element.is_delivered ?? false){
        if((element.podList ?? []).isNotEmpty){
          podUrl.value = (element.podList ?? []).first.url ?? '';
          print("podUrl.value ${podUrl.value}");
        }
      }
    });
  }

}