

import 'package:grocery_delivery_boy/common/models/config_model.dart';

class MaintenanceHelper{

  static bool isMaintenanceModeEnable (ConfigModel? configModel) => configModel?.maintenanceMode?.maintenanceStatus ?? false;

  static bool isCustomizeMaintenance (ConfigModel? configModel) => configModel?.maintenanceMode?.maintenanceTypeAndDuration?.maintenanceDuration == 'customize';

  static bool isMaintenanceMessageEmpty (ConfigModel? configModel) => configModel?.maintenanceMode?.maintenanceMessages?.maintenanceMessage?.isEmpty ?? true;

  static bool isMaintenanceBodyEmpty (ConfigModel? configModel) => configModel?.maintenanceMode?.maintenanceMessages?.messageBody?.isEmpty ?? true;

  static bool isShowBusinessNumber (ConfigModel? configModel) => configModel?.maintenanceMode?.maintenanceMessages?.businessNumber ?? false;

  static bool isShowBusinessEmail (ConfigModel? configModel) => configModel?.maintenanceMode?.maintenanceMessages?.businessEmail ?? false;

  static bool isDeliveryMaintenanceEnable (ConfigModel? configModel) => configModel?.maintenanceMode?.selectedMaintenanceSystem?.deliverymanApp ?? false;

}