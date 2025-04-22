import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_delivery_boy/common/widgets/custom_alert_dialog_widget.dart';
import 'package:grocery_delivery_boy/localization/language_constrants.dart';
import 'package:grocery_delivery_boy/utill/images.dart';



class CustomPopScopeWidget extends StatefulWidget {
  final Widget child;
  final Function()? onPopInvoked;
  final bool isExit;

  const CustomPopScopeWidget({Key? key, required this.child, this.onPopInvoked, this.isExit = true}) : super(key: key);

  @override
  State<CustomPopScopeWidget> createState() => _CustomPopScopeWidgetState();
}

class _CustomPopScopeWidgetState extends State<CustomPopScopeWidget> {

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (didPop, result) {

      //   print('--------------(DID POP)------$didPop and $result');
      //   print('--------------${!Navigator.canPop(context)} and ${widget.isExit}');
      //   if (widget.onPopInvoked != null) {
      //     widget.onPopInvoked!();
      //   }

      //   if(didPop) {
      //     return;
      //   }

      //   if(!Navigator.canPop(context) && widget.isExit ) {
      //     print("-HERE I AM-");
      //     showModalBottomSheet(
      //       context: context,
      //       isScrollControlled: true, // Adjusts the height to fit the content
      //       shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.vertical(top: Radius.circular(16)), // Optional: Round the top corners
      //       ),
      //       builder: (context) => Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      //         child: CustomAlertDialogWidget(
      //           title: getTranslated('close_the_app', context),
      //           subTitle: getTranslated('do_you_want_to_close_and', context),
      //           rightButtonText: getTranslated('exit', context),
      //           image: Images.logOut,
      //           onPressRight: () {
      //             Navigator.of(context).pop(); // Close the bottom sheet
      //             SystemNavigator.pop(); // Close the app
      //           },
      //         ),
      //       ),
      //     );
      //   }else {
      //     if(Navigator.canPop(context)) {
      //       Navigator.pop(context);
      //     }
      //   }

      // },
    
    
      child: widget.child,
    );
  }
}
