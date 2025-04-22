
import 'package:flutter/material.dart';
import 'package:grocery_delivery_boy/common/models/config_model.dart';
import 'package:grocery_delivery_boy/features/splash/providers/splash_provider.dart';
import 'package:grocery_delivery_boy/features/splash/screens/splash_screen.dart';
import 'package:grocery_delivery_boy/helper/maintenance_helper.dart';
import 'package:grocery_delivery_boy/localization/language_constrants.dart';
import 'package:grocery_delivery_boy/main.dart';
import 'package:grocery_delivery_boy/utill/dimensions.dart';
import 'package:grocery_delivery_boy/utill/images.dart';
import 'package:grocery_delivery_boy/utill/styles.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final SplashProvider splashProvider = Provider.of<SplashProvider>(context, listen: false);
      splashProvider.initConfig().then((bool isSuccess) {
        if(isSuccess){
          final ConfigModel? config = splashProvider.configModel;
          if(!MaintenanceHelper.isMaintenanceModeEnable(config)) {
            Navigator.pushAndRemoveUntil(Get.context!, MaterialPageRoute(builder: (_) => const SplashScreen()), (route) => false);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ConfigModel? configModel = Provider.of<SplashProvider>(context).configModel;


    print("--------(MESSAGE)---------${MaintenanceHelper.isMaintenanceMessageEmpty(configModel)}");
    print("--------(BODY)---------${MaintenanceHelper.isMaintenanceBodyEmpty(configModel)}");

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

            Image.asset(Images.maintenance, width: 200, height: 200),
            SizedBox(height: size.height * 0.07),

            if(configModel != null)...[

              if(!MaintenanceHelper.isMaintenanceMessageEmpty(configModel))...[
                Text(configModel.maintenanceMode?.maintenanceMessages?.maintenanceMessage ?? "",
                  textAlign: TextAlign.center,
                  style: rubikSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
              ]else...[
                Text(getTranslated('we_are_cooking_something_special', context),
                  textAlign: TextAlign.center,
                  style: rubikSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
              ],

              if(!MaintenanceHelper.isMaintenanceBodyEmpty(configModel))...[
                Text(configModel.maintenanceMode?.maintenanceMessages?.messageBody ?? "",
                  textAlign: TextAlign.center,
                  style: rubikRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              ]else...[
                Text(getTranslated('our_system_currently_undergoing_maintenance', context),
                  textAlign: TextAlign.center,
                  style: rubikRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              ],

              if(MaintenanceHelper.isShowBusinessEmail(configModel) || MaintenanceHelper.isShowBusinessNumber(configModel)) ...[

                if( !MaintenanceHelper.isMaintenanceMessageEmpty(configModel) || !MaintenanceHelper.isMaintenanceBodyEmpty(configModel) ) ...[

                  Row(children: List.generate(size.width ~/10, (index) => Expanded(
                    child: Container(
                      color: index%2==0?Colors.transparent :Theme.of(context).hintColor.withOpacity(0.2),
                      height: 2,
                    ),
                  ))),
                  const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                ],

                Text(getTranslated('any_query_feel_free_to_call', context),
                  style: rubikRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                if(MaintenanceHelper.isShowBusinessNumber(configModel))...[
                  InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(
                        'tel:${Provider.of<SplashProvider>(context, listen: false).configModel!.ecommercePhone}',
                      ), mode: LaunchMode.externalApplication);
                    },
                    child: Text(configModel.ecommercePhone ?? "",
                      style: rubikRegular.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeDefault,
                        decoration: TextDecoration.underline,
                        decorationColor:  Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                ],

                if(MaintenanceHelper.isShowBusinessEmail(configModel))...[
                  InkWell(
                    onTap: (){
                      launchUrl(Uri.parse(
                        'mailto:${Provider.of<SplashProvider>(context, listen: false).configModel!.ecommerceEmail}',
                      ), mode: LaunchMode.externalApplication);
                    },

                    child: Text(configModel.ecommerceEmail ?? "",
                      style: rubikRegular.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeDefault,
                        decoration: TextDecoration.underline,
                        decorationColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],

              ]
            ],

          ]),
        ),
      ),
    );
  }
}
