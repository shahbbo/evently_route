import 'package:event_planning_app/features/home_screen/views/home_view/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/recources/app_colors.dart';
import '../../../../core/reuseable_widgets/custom_text_form_feild.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home_view/widgets/event_widget.dart';


class LikeView extends StatelessWidget {
  const LikeView({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
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
              child: ListView.builder(
                itemCount: homeProvider.favoriteEvents.length,
                itemBuilder: (context, index) {
                  return EventWidget(
                    eventModel: homeProvider.favoriteEvents[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
