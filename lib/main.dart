import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import './map/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import './splash/splash.dart';
import 'firebase_options.dart';
import 'routes.dart';
import 'main_screens.dart';
import 'package:provider/provider.dart';
import './login/loginScreen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
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
    openAppSettings();//domdom.tistory.com/entry/flutter-%ED%94%8C%EB%9F%AC%ED%84%B0-%EC%B9%B4%EC%B9%B4%EC%98%A4-%EB%A1%9C%EA%B7%B8%EC%9D%B8-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0
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

class commentdata{
 String name="";
 var content="";


  commentdata(this.name,this.content);

}

class comments extends ChangeNotifier{

List<commentdata>datas=[commentdata("김건국","맛집어디?")];
var k=1;



void addcomment(String name,var content){
  var newone=commentdata(name,content);
  datas=[...datas,newone];
  notifyListeners();

}




}


class markerdata extends ChangeNotifier {
  var cnt = 2;
  var lat;
  var long;

  void altercnt(int num) {
    cnt = num;
    notifyListeners();
  }

  void setlang(idx)
  {
    lat=idx.latitude;
  long=idx.longtitude;
    notifyListeners();
  }

  void searchname(LatLng idx) async{


   var lats=idx.latitude;
   var longs=idx.longitude;
    final url='https://maps.googleapis.com/maps/api/geocode/json?latlng=$lats,$longs&key=AIzaSyCFZeBuFQYqg9qt7Yd4xwWC6UBNOwzDSi8&language=ko';
    final reponse=await http.get(Uri.parse(url));
    print(jsonDecode(reponse.body)['results'][0]['formatted_address']);

   String name=jsonDecode(reponse.body)['results'][0]['formatted_address'];
    name.toString().substring(11);


    print(name);
    altermoem(name);
    notifyListeners();


  }

  var moem=TextEditingController();
void altermoem(name){

  moem.text=name;
  notifyListeners();

}

  void addmarker(location){

    marker.add(Marker(position: location,markerId: MarkerId("현재위치"),
   draggable: true));
    notifyListeners();
  }

  List<Marker>marker = [Marker(
      markerId: MarkerId("건국대 공학관"),
      draggable: true,
      infoWindow: InfoWindow(
          title: '건국대 공학관',
          snippet: '하윙'
      ),

      position: LatLng(37.535905, 127.088795)
  )];


  void initmarker() {
    marker.add(Marker(
        markerId: MarkerId("건국대 신공학관"),
        draggable: true,
        infoWindow: InfoWindow(
            title: '건국대 신공학관',
            snippet: '하윙'
        ),
        onTap: () =>
        {
          altercnt(5)
        },
        position: LatLng(37.540905, 127.078595)));

    marker.add(Marker(
        markerId: MarkerId("건국대 공학관"),
        draggable: true,
        infoWindow: InfoWindow(
            title: '건국대 공학관',
            snippet: '하윙'
        ),
        onTap: () =>
        {
          altercnt(3)
        }
        ,
        position: LatLng(37.535905, 127.078595)
    ));
  }
}

class maptab extends ChangeNotifier{
  var tab=0;

  void altertab1(){
      tab=1;
  notifyListeners();
}

  void altertab0(){
    tab=0;
    notifyListeners();
  }
  void altertab2(){
    tab=2;
    notifyListeners();
  }

}

void main()async {
 // KakaoContext.clientId="5141bbdfc690f528828b113f3937b36b";
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  KakaoSdk.init(nativeAppKey: '5141bbdfc690f528828b113f3937b36b');



  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (c)=>loginindex()),
      ChangeNotifierProvider(create: (c)=>maptab()),
      ChangeNotifierProvider(create: (c)=>markerdata()),
      ChangeNotifierProvider(create: (c)=>comments()),
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
  StreamController<String> streamController2 = StreamController<String>();

  var index=0;

  void aterindex(){
    index=1;
    notifyListeners();


}void logout(){
    streamController2.add("로그아웃");
    notifyListeners();
  }
  void login(){
    streamController2.add("로그인");
    notifyListeners();
  }
  void init(){
    streamController2.add("init");
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
  Widget build(BuildContext context) {
    return MaterialApp(

    home:StreamBuilder(
      stream: context.watch<loginindex>().streamController2.stream,
      builder: (BuildContext context,snapshot){
         if(snapshot.data.toString()=="로그인") {
           return main_screen();
         } else{
           return LoginSignupScreen();
         }

      },
    )

    );
  }
}
