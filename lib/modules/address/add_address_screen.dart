// import 'package:flutter/material.dart';
// import 'package:shop_app/shared/components/const/dimensions.dart';
// import 'package:shop_app/shared/components/const/styles.dart';
// import 'package:shop_app/shared/network/remote/controllers/auth_controller.dart';
// import 'package:shop_app/shared/network/remote/controllers/location_controller.dart';
// import 'package:shop_app/shared/network/remote/controllers/user_controller.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class AddAddressScreen extends StatefulWidget {
//   const AddAddressScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddAddressScreen> createState() => _AddAddressScreenState();
// }
//
// class _AddAddressScreenState extends State<AddAddressScreen> {
//
//   final TextEditingController _addressController =TextEditingController();
//   final TextEditingController _contactPersonName=TextEditingController();
//   final TextEditingController _contactPersonNumber=TextEditingController();
//   late bool _isLogged;
//   CameraPosition _cameraPosition =const CameraPosition(
//       target: LatLng(
//     45.51563, -122.677433
//   ), zoom: 17);
//   late LatLng _initialPosition =const LatLng(
//       45.51563, -122.677433
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _isLogged =Get.find<AuthController>().userLoggedIn();
//     if(_isLogged&&Get.find<UserController>().userModel==null){
//       Get.find<UserController>().getUserInfo();
//     }
//     if(Get.find<LocationController>().addressList.isNotEmpty){
//       _cameraPosition=CameraPosition(target: LatLng(
//        double.parse(Get.find<LocationController>().getAddress['latitude']),
//        double.parse(Get.find<LocationController>().getAddress['longitude']),
//       ));
//       _initialPosition=LatLng(
//         double.parse(Get.find<LocationController>().getAddress['latitude']),
//         double.parse(Get.find<LocationController>().getAddress['longitude']),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Address page'),
//         backgroundColor: AppColors.mainColor,
//       ),
//       body: GetBuilder<LocationController>(
//         builder: (locationController) {
//           return Column(
//             children: [
//               Container(
//                 height: 140,
//                 width: MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.only(
//                   left: Dimensions.width10/2,
//                   right: Dimensions.width10/2,
//                   top: Dimensions.width10/2
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(Dimensions.radius15/3),
//                   border: Border.all(
//                     width: 2,
//                     color:Theme.of(context).primaryColor
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     GoogleMap(
//                         initialCameraPosition: CameraPosition(
//                             target: _initialPosition,
//                             zoom: 17,
//                         ),
//                        zoomControlsEnabled: false,
//                       compassEnabled: false,
//                       indoorViewEnabled: true,
//                       mapToolbarEnabled: false,
//                       onCameraIdle: (){
//                        locationController.updatePosition(_cameraPosition,true);
//                       },
//                       onCameraMove: ((position)=>_cameraPosition=position),
//                       onMapCreated: (GoogleMapController controller){
//                         locationController.setMapController(controller);
//                       },
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           );
//         }
//       ),
//     );
//   }
// }
