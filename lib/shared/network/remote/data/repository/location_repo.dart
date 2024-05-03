// import 'package:shop_app/shared/components/const/app_constants.dart';
// import 'package:shop_app/shared/network/remote/data/api/api_client.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LocationRepo{
//   final ApiClient apiClient;
//   final SharedPreferences sharedPreferences;
//   LocationRepo({required this.apiClient,required this.sharedPreferences});
//
//   Future<Response>getAddressFromGeoCode(LatLng latLng) async {
//     return await apiClient.getData('${AppConstants.GEOCODE_URI}'
//     '?lat=${latLng.latitude}&lng=${latLng.longitude}'
//     );
//   }
//
// }