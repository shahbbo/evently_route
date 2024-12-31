import 'package:flutter/material.dart';

import '../recources/app_styles.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final String buttonName;
  final String? icon;
  final Function onTap;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.buttonColor,
    required this.buttonName,
    required this.textColor,
    required this.borderColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return  ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          side: BorderSide(color:borderColor ),
            borderRadius: BorderRadius.circular(16))),
        padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
        // shape: WidgetStatePropertyAll(),
        backgroundColor: WidgetStatePropertyAll(buttonColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!=null?
          Image(image: AssetImage(icon!))
          :Text(''),
          SizedBox(width: width*.02,),
          Text(
            buttonName,
            style: AppStyle.white20medium.copyWith(
              color: textColor,
              fontSize: 18
            ),
          )
        ],
      ),
    );
  }
}
