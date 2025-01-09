import 'package:flutter/material.dart';

import '../../../../core/recources/app_colors.dart';
import '../../../../core/reuseable_widgets/custom_text_form_feild.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LikeView extends StatelessWidget {
  const LikeView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: height * .03,
            ),
            Padding(
              padding: const EdgeInsets.all(7.0),
              child: CustomTextFormField(
                borderColor: AppColors.primaryColorLight,
                prefixIcon: Icon(Icons.search),
                hintText: AppLocalizations.of(context)!.search,
              ),
            ),
            SizedBox(
              height: height * .015,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // EventWidget(
                    //   image: AssetsManager.birthdayBg,
                    //   eventName: AppLocalizations.of(context)!.birthday,
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
