


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
import 'map.dart';
import 'package:flutter/painting.dart';
import 'locationSearch.dart';


import 'package:flutter/material.dart';

class deliverysearch extends StatefulWidget {
  const deliverysearch({Key? key}) : super(key: key);

  @override
  State<deliverysearch> createState() => _deliverysearchState();
}

class _deliverysearchState extends State<deliverysearch> {
  final textcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("장소 검색하기",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white70,),
      body: SingleChildScrollView(
        child:  Column(

          children: [

            Padding(padding: EdgeInsets.only(top: 8)),








            Container(
              color:Color(0xFFE0E0E0) ,
              child:   Row(children: [



                SizedBox(
                  width: context.watch<maptab>().tab==0?410:346,

                  child: DecoratedBox(
                      decoration:BoxDecoration(

                      ),

                      child:TextField(
                        onTap: (){

                        },
                        autofillHints: [AutofillHints.name],

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



            secondui(textcontroller:textcontroller)

            ,
            Padding(padding: EdgeInsets.only(top: 5)),




          ],
        ) ,
      )

    );
  }
}
