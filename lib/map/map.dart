
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class name{
  var s="안누름";
  name(this.s);
}



class map extends StatefulWidget {

  const map({Key? key}) : super(key: key);

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {


  Completer<GoogleMapController> _controller = Completer();
var z= name ("안녕");
 List<Marker> makers=[];
 List<int>count=[];
 int cnt=2;
  // 초기 카메라 위치
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.540905, 127.078595),
    zoom: 15,

    //확대
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.4943, 126.8254),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    makers.add(Marker(
      markerId: MarkerId("건국대 신공학관"),
      draggable: true,
      infoWindow: InfoWindow(
        title: '건국대 신공학관',
        snippet: 'hihi'
      ),
      onTap: ()=>print("hihi"),
      position: LatLng(37.540905, 127.078595)
    ));
    count.add(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(


      children: [

        Padding(padding: EdgeInsets.only(top: 11)),
        SizedBox(
          width: double.infinity,
          height: 300,
          child:GoogleMap(
            markers: Set.from(makers),
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex, // 초기 카메라 위치
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ) ,
        ),

SizedBox(
  height: 200
    ,child:
CustomScrollView(
  slivers: [

   SliverFixedExtentList(
    itemExtent: 80.0,
       delegate: SliverChildBuilderDelegate((BuildContext context,int index){
         return Padding(padding: EdgeInsets.only(top: 1),
         child: ListTile(
           leading: Icon(Icons.offline_bolt),
           title: Text(z.s),
           subtitle: Text("bye"),
         ),);
       },childCount: cnt),
      )


  ],) ,)


  ],
)
     ,

      // floatingActionButton을 누르게 되면 _goToTheLake 실행된다.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    setState(() {
      z.s="바윙";
    });
  }
}
