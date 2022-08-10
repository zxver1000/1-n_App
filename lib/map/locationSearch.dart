
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:provider/provider.dart';
import 'package:side_app/constants.dart';
import '../main.dart';
import 'package:side_app/chat/chatScreen.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:location/location.dart';
import 'package:flutter/painting.dart';
import 'package:kpostal/kpostal.dart';


class locationSearch extends StatefulWidget {
  const locationSearch({Key? key}) : super(key: key);

  @override
  State<locationSearch> createState() => _locationSearchState();
}

class _locationSearchState extends State<locationSearch> {
  Completer<GoogleMapController> _controller = Completer();
  var click;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.540905, 127.078595),
    zoom: 15,

    //확대
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("장소 입력",style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.white70,),

      body:SizedBox(
        width: double.infinity,
        height: 250,
        child:GoogleMap(
          buildingsEnabled: false,
          onTap: (idx) async{
            context.read<markerdata>().addmarker(idx);
          //context.read<markerdata>().setlang(idx);

            setState(() {
              click=idx;
            });

          },
          markers: Set.from(context.watch<markerdata>().marker),
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex, // 초기 카메라 위치
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ) ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          //plusbutton
          showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text("장소 입력"),
              content: Text("장소를 확정하시겠습니까?"),
              actions: [
                TextButton(onPressed: ()async{
                  context.read<markerdata>().searchname(click);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                }, child: Text("OK")),
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                },child: Text("Cancel"),)
              ],
            );

          });
        },
        child:Text("V"),
      ),
    );
  }
}
