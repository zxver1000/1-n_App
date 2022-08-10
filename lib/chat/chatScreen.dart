import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
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

 var states=true;
 @override
  void initState()  {
    // TODO: implement initState
    super.initState();

   // KakaoSdk.init(nativeAppKey: '5141bbdfc690f528828b113f3937b36b');
  }
  void getuser()async{


  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

    SizedBox(
    child: TextButton(
    onPressed: ()async{
      Uri uri=Uri.parse('http://192.168.56.1:8080/login');
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
      var re=await http.post(uri,body: jsonEncode(r),headers: headers);
      if(re.statusCode==200)
      {


        var data=utf8.decode(re.bodyBytes);
        print(data);
        var datas=re.headers;
        print(datas['authorization']);

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
    ),


        TextButton(onPressed: () async{


          var param={
            "email":"asdf@asdf.com",
            "password":"asdf@"
          };
          Map<String,dynamic>r={"email":"asdf@asdf.com",
            "password":"asdf@"};
          var s=User('홍길동123','asdf@asdf.com','asdf@','ADMIN');
          var k=s.toJson();
          print(k['email']);


          final queryParameters={
            'email':'asdf@asdf.com','password':'asdf@'
          };


          Map<String,dynamic> s1={
            'email':'asdf@asdf.com','password':'asdf@'};

          Uri uri=Uri.parse('http://192.168.56.1:8080/user');
          uri.replace(queryParameters: queryParameters);

          Map<String,String> headers = {'Content-Type':'application/json',
          'Authorization':'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiLthqDtgbDsnbTrpoTsnoXri4jri6QuIiwiaWQiOjEsImV4cCI6MTY1ODIxMDgzOSwidXNlcm5hbWUiOiLtmY3quLjrj5kifQ.pQx4QjEynQAD2LW1vDykfM1L3iguRXCdtzG4BcT7I7H-Wc4Dy436qYcsQQUu4mEv2ZShR5t_BbbrMDzywU0ekg'};
          var re=await http.get(uri,headers: headers);

          if(re.statusCode==200)
          {
           var a=re.body.toString().replaceAll("\n", "");
           var data=utf8.decode(re.bodyBytes);
            print(data);

          }
          else
          {
            print(jsonDecode(re.body));
            print("실패스");
          }


        }, child: Text("admin")),


        TextButton(onPressed: () async{


        }, child: Text("hi"))



        ,

SizedBox(width: 200,
child: TextButton(onPressed: ()async{
  if (await AuthApi.instance.hasToken()) {
    try {
      AccessTokenInfo tokenInfo =
      await UserApi.instance.accessTokenInfo();
      print('토큰 유효성 체크 성공 ${tokenInfo.id} ${tokenInfo.expiresIn}');
    } catch (error) {
      if (error is KakaoException && error.isInvalidTokenError()) {
        print('토큰 만료 $error');
      } else {
        print('토큰 정보 조회 실패 $error');
      }

      try {
        // 카카오 계정으로 로그인
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();

        print('로그인 성공 ${token.accessToken}');

      } catch (error) {
        print('로그인 실패 $error');
      }
    }
  } else {
    print('발급된 토큰 없음');
    print("왜안됨?");
    try {
    //  OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
var code=await AuthCodeClient.instance.request();

     var token=await AuthApi.instance.issueAccessToken(authCode: code);


  // print("-----------------------------");
     print(code);
     print("--------");
     print(token);

      print('로그인 성공 ${token.accessToken}');
      print("dddddddddddddd");
     // var s=await UserApi.instance.me();

     // print('로그인 성공 ${token.accessToken}');
     // print(s.id);
    } catch (error) {
      print('로그인 실패 $error');
    }
  }



},



child: Text("카카오로그인"),),



)
,
TextButton(onPressed: ()async{
  await UserApi.instance.logout();
  print("-----------------------------");
  print('로그아웃 성공, SDK에서 토큰 삭제');
  print("로그아웃");

}, child: Text("로그아웃")),

        TextButton(onPressed: ()async{
          final FirebaseAuth _auth = FirebaseAuth.instance;

          final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
          final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
          print(googleUser);

          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          // Once signed in, return the UserCredential
          var users=await FirebaseAuth.instance.signInWithCredential(credential);
          var real_user=users.user;
          print("dddddddddddddddddd");
          print(real_user);

        }, child: Text("구글로그인")),


        TextButton(onPressed: ()async{

          try {
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
            print("로그아웃");
          } catch(e)
          {
            print(e);
            print("에러");
          }
        },
        child: Text("구글로그아웃"),)

,


        TextButton(onPressed: ()async{



          String username = 'wlwhs3154@gmail.com';
          String password = 'dkdpdldhdn12@';
          var s=gmail(username,password);
          var k=s.xoauth2Token;
         var hoo=yahoo("ik2509@yahoo.com", "dkdpdldhdn12@");

          var smtpServer=hoo;
          print(smtpServer.allowInsecure);

          final message = Message()
            ..from = Address("ik2509@yahoo.com",'ik2509')
            ..recipients.add('ik2509@naver.com')
            ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
            ..text = 'This is the plain text.\nThis is line 2 of the text part.'
            ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

          try {
            final sendReport = await send(message, smtpServer);
            print('Message sent: ' + sendReport.toString());
          } on MailerException catch (e) {
            print('Message not sent.');
            print(e);

            for (var p in e.problems) {
              print('Problem: ${p.code}: ${p.msg}');
            }
          }







          /*
          final Email send_email = Email(
            body: '집마려웡',
            subject: 'hihi',
            recipients: ['ik2509@naver.com'],

            isHTML: false,
          );
          try{
            await FlutterEmailSender.send(send_email);
          }
catch(e){
  print(e);
          }

           */

        }, child: Text("네이버로그인"))
      ],
    );


  }
}
