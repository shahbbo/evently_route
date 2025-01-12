import 'package:event_planning_app/features/create_event_screen/data/event_model.dart';
import 'package:event_planning_app/features/home_screen/views/home_view/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/recources/app_colors.dart';
import '../../../../core/reuseable_widgets/custom_text_form_feild.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home_view/widgets/event_widget.dart';


class LikeView extends StatefulWidget {
  const LikeView({super.key});
  @override
  State<LikeView> createState() => _LikeViewState();
}

class _LikeViewState extends State<LikeView> {

  // void initState() {
  //   super.initState();
  //   HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
  //   homeProvider.getFavoriteEvents();
  //   final List<EventModel> filteredEvents = List.generate(homeProvider.favoriteEvents.length, (index) => homeProvider.favoriteEvents[index]);
  // }

  bool isSearch = false;

  List<EventModel> filteredFavEvents = [];
  void searchEvent(String query) {
    setState(() {
      isSearch = query.isNotEmpty;
      HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
      filteredFavEvents  = homeProvider.favoriteEvents.where((element) => element.title!.contains(query)).toList();
  });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeProvider.getFavoriteEvents();
    });
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
                onChanged: (value) {
                  searchEvent(value!);
                  return null;
                },
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
                itemCount: filteredFavEvents.isEmpty ? homeProvider.favoriteEvents.length : filteredFavEvents.length,
                itemBuilder: (context, index) {
                  return EventWidget(
                    eventModel: filteredFavEvents.isEmpty ? homeProvider.favoriteEvents[index] : filteredFavEvents[index],
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
