import 'package:flutter/material.dart';

class RegisterScrren extends StatefulWidget {
  const RegisterScrren({Key? key}) : super(key: key);

  @override
  State<RegisterScrren> createState() => _RegisterScrrenState();
}




class _RegisterScrrenState extends State<RegisterScrren> {
  @override
  // formkey
  final _formkey = GlobalKey<FormState>();
  final NameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController= new TextEditingController();
  final NickNameEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
void _tryValidation() {
 final isValid = _formkey.currentState!.validate();
 if(isValid)
   {
     _formkey.currentState!.save();
   }
}


  Widget build(BuildContext context) {

    //Name
    final NameField= TextFormField(
      autofocus: false,
      controller: NameEditingController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value){
        NameEditingController.text=value!;
      },

      validator: (value){
        RegExp regex =new RegExp(r'^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣a-zA-Z]{2,}$');
        if (value!.isEmpty){
          return("필수 정보입니다.");
        }
        if(!regex.hasMatch(value)){
          return (" 2글자 이상 공백을 제외하고 실명을 입력해 주세요");
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "이름",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),);

    //Name
    final nickNameField= TextFormField(
      autofocus: false,
      controller: NickNameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        RegExp regex =new RegExp(r'^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣a-zA-Z]{2,8}$');
        if (value!.isEmpty){
          return("필수 정보입니다.");
        }
        if(!regex.hasMatch(value)){
          return ("공백 제외 최소 2-8글자이내 입력해 주세요");
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (value){
        NickNameEditingController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "별명",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),);
    //emailID

    final EmailField= TextFormField(
     autofocus: false,
     controller: emailEditingController,
     keyboardType: TextInputType.emailAddress,

      validator: (value){
        RegExp regex =new RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((konkuk+\.)+(ac+\.)+(kr))$');
        if (value!.isEmpty){
          return("필수 정보입니다.");
        }
        if(!regex.hasMatch(value)){
          return ("@konkuk.ac.kr건국대 이메일을 확인해 주세요");
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
     onSaved: (value){
       emailEditingController.text=value!;
     },
     textInputAction: TextInputAction.next,
     decoration: InputDecoration(
       prefixIcon: Icon(Icons.mail),
       contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
       hintText: "@konkuk.ac.kr",
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(10),
       ),
     ),);
  //passWord
   final passWordField= TextFormField(
     autofocus: false,
     controller: passwordEditingController,
     obscureText: true,

     validator: (value){
       RegExp regex =new RegExp (r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');
       if (value!.isEmpty){
         return("필수 정보입니다.");
       }
       if(!regex.hasMatch(value)){
         return ("8~16자 영문자,숫자,툭수문자를 사용하세요.");
       }
       return null;
     },
     autovalidateMode: AutovalidateMode.onUserInteraction,
     onSaved: (value){
       passwordEditingController.text=value!;
     },
     textInputAction: TextInputAction.next,
     decoration: InputDecoration(
       prefixIcon: Icon(Icons.vpn_key),
       contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
       hintText: "Password",
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(10),
       ),
     ),);
  //confirmPassword
   final CpasswordField= TextFormField(
     autofocus: false,
     controller: confirmPasswordEditingController,
     obscureText: true,

     validator: (value)
     {
       if (value!.isEmpty){
         return("필수 정보입니다.");
       }
       if(confirmPasswordEditingController.text !=passwordEditingController.text)
         {
           return ("비밀번호가 일치하지 않습니다.");
         }
       return null;
     },
     autovalidateMode: AutovalidateMode.onUserInteraction,
     onSaved: (value){
       confirmPasswordEditingController.text=value!;
     },
     textInputAction: TextInputAction.done,
     decoration: InputDecoration(
       prefixIcon: Icon(Icons.vpn_key),
       contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
       hintText: "Confirm Password",
       border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(10),
       ),
     ),);

   final signUpButton = Material(
     elevation: 5,
     borderRadius: BorderRadius.circular(30),
     color:Colors.greenAccent,
     child: MaterialButton(
       padding: EdgeInsets.fromLTRB(20,15,20,15),
       minWidth: MediaQuery.of(context).size.width,
       onPressed: (){
         _tryValidation();
       },
       child: Text(
         "가입하기",
             textAlign: TextAlign.center,
         style: TextStyle(
           fontSize: 20,color:Colors.white,fontWeight: FontWeight.bold),
         ),
       ),
     );


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
        icon: Icon(Icons.arrow_back,color:Colors.red),
          onPressed: (){
          Navigator.of(context).pop();
          },
        ),
    ],
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
      child:Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 45,
                       // child:Image.asset(
                       // "",
                       // fit:BoxFit.contain,
                       //        )
              ),
                    SizedBox(height: 20),
                    Text("이름",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )),
                    NameField,
                    SizedBox(height: 20),
                    Text("별명",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                    nickNameField,
                    SizedBox(height: 20),
                    Text("아이디",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                    Row(
                      children:[
                        EmailField,
                      ],
                      ),

                    SizedBox(height: 20),
                    Text("비밀번호",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                    passWordField,
                    SizedBox(height: 20),
                    Text("비밀번호 재확인",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        )),
                    CpasswordField,
                    SizedBox(height: 20),
                    signUpButton,
                    SizedBox(height: 30),

                  ],

                ),
              ),

            )
          ),
        ),
      ),
    ),);
  }

}
