import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
   String name;
   String email;
   String password;
   String role;
  User(this.name, this.email,this.password,this.role);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
         password=json['password'],
        role=json['role'];


  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email,
        'password':password,
        'role':role
      };
}

class chatscreen extends StatefulWidget {
  const chatscreen({Key? key}) : super(key: key);

  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        onPressed: ()async{
        Uri uri=Uri.parse('http://192.168.56.1:8080/signup');
        var param={
          "email":"asdf@asdf.com",
          "password":"asdf@"
        };
        Map<String,dynamic>r={"email":"asdf@asdf.com",
          "password":"asdf@"};
        var s=User('홍길동123','asdf@asdf.com','asdf@','ADMIN');
        var k=s.toJson();
        print(k['email']);


        Map<String,dynamic> s1={'name':'홍길동123',
          'email':'asdf@asdf.com','password':'asdf@','role':'ADMIN'};
        Map<String,String> headers = {'Content-Type':'application/json'};
          var re=await http.post(uri,body: jsonEncode(s1),headers: headers);
     if(re.statusCode==200)
       {
         print(jsonDecode(re.body));
       }
     else
       {
         print(jsonDecode(re.body));
         print("실패스");
       }


/*
        var result = await http.get( Uri.parse('https://codingapple1.github.io/app/data.json'));
        print( jsonDecode(result.body));
 */
      },


      child: Text("http"),),
    );
  }
}
