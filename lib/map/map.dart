
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:side_app/chat/chatScreen.dart';
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
  final textcontroller=TextEditingController();
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
            snippet: '하윙'
        ),
        onTap: ()=>setState(() {
          cnt=5;
        }),
        position: LatLng(37.540905, 127.078595)
    ));

    makers.add(Marker(
        markerId: MarkerId("건국대 공학관"),
        draggable: true,
        infoWindow: InfoWindow(
            title: '건국대 공학관',
            snippet: '하윙'
        ),
        onTap: ()=>setState(() {

          z.s="바윙";
          cnt=3;
        }),
        position: LatLng(37.535905, 127.078595)
    ));


    count.add(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:SingleChildScrollView(
          child:Column(

        children: [

          Padding(padding: EdgeInsets.only(top: 8)),








Container(
  color:Color(0xFFE0E0E0) ,
  child:   Row(children: [

    context.watch<maptab>().tab==1?TextButton(onPressed: (){
      context.read<maptab>().altertab0();

    }, child: Text("X"),style: TextButton.styleFrom(

        primary: Colors.black
    ),) :Text(""),

    SizedBox(
      width: context.watch<maptab>().tab==0?410:346,

      child: DecoratedBox(
          decoration:BoxDecoration(

          ),

          child:TextField(
            onTap: (){
              context.read<maptab>().altertab1();
            },
         autofillHints: [AutofillHints.name],
            onEditingComplete: ()=>context.read<maptab>().altertab0(),
            controller: textcontroller,

            decoration: InputDecoration(
              filled: true,

              border: InputBorder.none,
              hintText: '장소 검색',
            ),
          )) ,

    )

  ],),
)
      ,


          context.watch<maptab>().tab==0?firstui(textcontroller:textcontroller)
         :secondui(textcontroller:textcontroller)

          ,
        Padding(padding: EdgeInsets.only(top: 5)),




        ],
      )
      )
      ,

      // floatingActionButton을 누르게 되면 _goToTheLake 실행된다.
      floatingActionButton: FloatingActionButton(
        onPressed: _goToTheLake,
        child:Icon(Icons.edit),
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


class firstui extends StatefulWidget {
  const firstui({Key? key,this.textcontroller}) : super(key: key);
final textcontroller;
  @override
  State<firstui> createState() => _firstuiState();
}

class _firstuiState extends State<firstui> {


  Completer<GoogleMapController> _controller = Completer();
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
    context.read<markerdata>().initmarker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          width: double.infinity,
          height: 250,
          child:GoogleMap(
            buildingsEnabled: false,
            markers: Set.from(context.watch<markerdata>().marker),
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex, // 초기 카메라 위치
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ) ,
        ),
        Padding(padding: EdgeInsets.only(top: 8)),
        Divider(height: 1.0,color: Colors.black,),


        SizedBox(
          height: 150
          ,child:
        CustomScrollView(
          slivers: [

            SliverFixedExtentList(
              itemExtent: 60.0,
              delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                return Padding(padding: EdgeInsets.only(top: 1),
                  child: ListTile(
                    leading: Icon(Icons.meeting_room,color: Colors.blueAccent,),
                    title: Text("제목 ->ㄱㄱ"),
                    subtitle: Text("참여인원 2명"),
                    trailing: TextButton(onPressed: (){},
                      child: Text("참여하기"),),
                  ),);
              },childCount: context.watch<markerdata>().cnt),
            )


          ],) ,
        ),
        Divider()





      ],);
  }
}

class secondui extends StatefulWidget {
  const secondui({Key? key,this.textcontroller}) : super(key: key);
  final textcontroller;
  @override
  State<secondui> createState() => _seconduiState();
}

class _seconduiState extends State<secondui> {

 List<String>name=["한식","중식","양식","분식","카페","야식","피자","기타"];
 List<Icon>icon=[Icon(Icons.dining),Icon(Icons.ramen_dining),Icon(Icons.restaurant),
 Icon(Icons.dinner_dining),Icon(Icons.local_cafe),Icon(Icons.fastfood),Icon(Icons.local_pizza),Icon(Icons.hail)];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
        height: 70,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: name.length,
              itemBuilder: (BuildContext context,int index){
            return Padding(padding: EdgeInsets.only(left:10),
            child: Column(children: [
              IconButton(onPressed: (){

              },

                icon: icon[index],

              ),Text(name[index])
            ],)

            );

          })


        )

, Divider(height: 1.0,color: Colors.black,),
 Padding(padding: EdgeInsets.only(top:10)),

        SizedBox(
          height: 500,
          child: ListView.builder(

              itemCount: 4,
              itemBuilder: (BuildContext context,int index){
                return Padding(padding: EdgeInsets.only(left:10),
                    child:ListTile(
                      title: Text("건대 맛집"),
                      leading: Icon(Icons.location_on),
                    )
                    
                );

              })

          ,
        )


      ],
    );
  }
}

class thirdui extends StatefulWidget {
  const thirdui({Key? key}) : super(key: key);

  @override
  State<thirdui> createState() => _thirduiState();
}

class _thirduiState extends State<thirdui> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
