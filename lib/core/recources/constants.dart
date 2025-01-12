import 'package:event_planning_app/core/network/local/cache_helper.dart';



bool? onBoarding = CacheHelper.getData(key: 'OnBoarding');
String? uid = CacheHelper.getData(key: 'uid');
String? email = CacheHelper.getData(key: 'email');
String? name = CacheHelper.getData(key: 'name');
