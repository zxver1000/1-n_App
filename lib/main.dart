import 'dart:async';
import './map/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './splash/splash.dart';
import 'routes.dart';
import 'main_screens.dart';
import 'package:provider/provider.dart';
import './login/loginScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';


void _permission() async {
  var requestStatus = await Permission.location.request();
  var status = await Permission.location.status;
  if (requestStatus.isGranted && status.isLimited) {
    // isLimited - 제한적 동의 (ios 14 < )
    // 요청 동의됨
    print("isGranted");
    if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
      // 요청 동의 + gps 켜짐


    } else {
      // 요청 동의 + gps 꺼짐
      print("serviceStatusIsDisabled");
    }
  } else if (requestStatus.isPermanentlyDenied ||
      status.isPermanentlyDenied) {
    // 권한 요청 거부, 해당 권한에 대한 요청에 대해 다시 묻지 않음 선택하여 설정화면에서 변경해야함. android
    print("isPermanentlyDenied");
    openAppSettings();
  } else if (status.isRestricted) {
    // 권한 요청 거부, 해당 권한에 대한 요청을 표시하지 않도록 선택하여 설정화면에서 변경해야함. ios
    print("isRestricted");
    openAppSettings();
  } else if (status.isDenied) {
    // 권한 요청 거절
    print("isDenied");
  }
  print("requestStatus ${requestStatus.name}");
  print("status ${status.name}");
}


Future<bool>checkPermission()async{
  bool status=await Permission.location.isGranted;

  if(status==true){
    return true;
  }
  else
    {
      return false;
    }

}

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (c)=>loginindex()),
    ],
    child: MyApp(),)
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class loginindex extends ChangeNotifier{

  var index=0;
  void aterindex(){
    index=1;
    notifyListeners();
}

}




class _MyAppState extends State<MyApp> {
  StreamController<String> streamController = StreamController<String>();

  Future<void> requestLocationPermission() async {


    var s = await Permission.locationWhenInUse.request();

    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted ;

    bool isLocation = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }



  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    streamController.add("확인");

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

    home:context.watch<loginindex>().index==1?main_screen():
      LoginSignupScreen()

    );
  }
}
