import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_delivery_boy/common/models/api_response_model.dart';
import 'package:grocery_delivery_boy/common/models/config_model.dart';
import 'package:grocery_delivery_boy/features/home/screens/home_screen.dart';
import 'package:grocery_delivery_boy/features/maintainance/screens/maintenance_screen.dart';
import 'package:grocery_delivery_boy/features/splash/domain/reposotories/splash_repo.dart';
import 'package:grocery_delivery_boy/helper/api_checker_helper.dart';
import 'package:grocery_delivery_boy/helper/maintenance_helper.dart';
import 'package:grocery_delivery_boy/main.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo? splashRepo;
  SplashProvider({required this.splashRepo});

  ConfigModel? _configModel;
  BaseUrls? _baseUrls;

  ConfigModel? get configModel => _configModel;
  BaseUrls? get baseUrls => _baseUrls;

  void _startTimer (DateTime startTime){
    Timer.periodic(const Duration(seconds: 30), (Timer timer){

      DateTime now = DateTime.now();

      if (now.isAfter(startTime) || now.isAtSameMomentAs(startTime)) {
        timer.cancel();
        Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (_) => const MaintenanceScreen()), (route) => false);
      }

    });
  }

  Future<bool> initConfig({bool? fromNotification}) async {
    ApiResponseModel apiResponse = await splashRepo!.getConfig();
    bool isSuccess;

    print('--------------------(CONFIG MODEL)---------------${apiResponse.toString()}');

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _configModel = ConfigModel.fromJson(apiResponse.response!.data);


      _baseUrls = ConfigModel.fromJson(apiResponse.response!.data).baseUrls;
      isSuccess = true;

      if(!MaintenanceHelper.isMaintenanceModeEnable(configModel)){
        if(MaintenanceHelper.isDeliveryMaintenanceEnable(configModel)){
          if(MaintenanceHelper.isCustomizeMaintenance(configModel)){

            DateTime now = DateTime.now();
            DateTime specifiedDateTime = DateTime.parse(_configModel!.maintenanceMode!.maintenanceTypeAndDuration!.startDate!);

            Duration difference = specifiedDateTime.difference(now);

            if(difference.inMinutes > 0 && (difference.inMinutes < 60 || difference.inMinutes == 60)){
              _startTimer(specifiedDateTime);
            }

          }
        }
      }

      if(fromNotification ?? false){
        print("-------------HERE I AM---------------");
        if(MaintenanceHelper.isMaintenanceModeEnable(configModel) && MaintenanceHelper.isDeliveryMaintenanceEnable(configModel)) {
          print("-------------HERE I AM INSIDE---------------");
          Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (_) => const MaintenanceScreen()), (route) => false);
        }else if (!MaintenanceHelper.isMaintenanceModeEnable(configModel)){
          print("-------------HERE I AM MORE INSIDE---------------");
          Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
        }
      }

      notifyListeners();
    } else {
      isSuccess = false;
      ApiCheckerHelper.checkApi( apiResponse);
    }
    return isSuccess;
  }

  Future<bool> initSharedData() {
    return splashRepo!.initSharedData();
  }

  Future<bool> removeSharedData() {
    return splashRepo!.removeSharedData();
  }


}