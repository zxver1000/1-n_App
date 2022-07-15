

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import './map/map.dart';
import 'constants.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:side_app/chat/chatScreen.dart';

void _permission() async {
  var requestStatus = await Permission.locationWhenInUse.request();
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






Future<void> requestLocationPermission() async {


  var s = await Permission.locationWhenInUse.request();

  final serviceStatusLocation = await Permission.location.isGranted ;

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




class main_screen extends StatefulWidget {
  const main_screen({Key? key}) : super(key: key);
  static String routeName = "/main_screen";
  @override
  State<main_screen> createState() => _main_screenState();
}

class _main_screenState extends State<main_screen> {
  int _selectedIndex = 0;
  var tab=0;
  void onTaped(index) {
    setState((){
      _selectedIndex = index;

    }
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  requestLocationPermission();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(
automaticallyImplyLeading: false,
        title: Text('1/N',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white70,
        actions: [IconButton(icon:Icon(Icons.exit_to_app_sharp,
        color: Colors.black,),

          onPressed: () {
          //로그아웃!!
          context.read<loginindex>().logout();

          },
          iconSize: 30,),
        ],
      ) ,
      body: [Text("home"),chatscreen(),map()][tab]
      ,
      bottomNavigationBar:  BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex:tab,
        backgroundColor: Colors.white70,
        onTap: (i){
          setState(() {
            tab=i;
          });
        },
        items: [
          BottomNavigationBarItem(
            label : 'Home',
            icon: Icon(Icons.home_outlined),


          ),
          BottomNavigationBarItem(
              label : '채팅방',
              icon: Icon(Icons.chat),

          )
        ,
          BottomNavigationBarItem(
            label : 'Map',
            icon: Icon(Icons.map_outlined),

          )
        ],
      ),
    );
  }
}
