import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:seventy5/Home.dart';
import 'package:url_launcher/url_launcher.dart';

class Username extends StatefulWidget {
  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  late String? username;
  late String? password;
  late String name;
  late String token;
  bool darkMode = false;
  bool arrow=true;

  final fieldText_username = TextEditingController();
  final fieldText_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkMode ? Colors.grey[850] : Colors.grey[300],
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 2),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 9, 0, 0, 0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    lightSource: LightSource.topLeft,
                    depth: -4,
                    color: Colors.grey[300],
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      controller: fieldText_username,
                      keyboardType: TextInputType.name,
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                      onSaved: (String? value) {},
                        textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintText: 'username/email',
                          hintStyle: TextStyle(fontWeight: FontWeight.w300),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Color(0xffd9d9d9))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none)),
                      onChanged: (value) {
                        username = value;
                        // print(username);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              //2nd one
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width / 9, 0, 0, 0),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    lightSource: LightSource.topLeft,
                    depth: -4,
                    color: Colors.grey[300],
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: TextFormField(
                      controller: fieldText_password,
                      onSaved: (value) {
                        password = value;
                      },
                      keyboardType: TextInputType.name,

                      obscureText: true,
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: 'password',

                          hintStyle: TextStyle(fontWeight: FontWeight.w300),

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Color(0xffd9d9d9))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none)),
                      onChanged: (value) {
                        //    print(value);
                        password=value;
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  final Uri _url = Uri.parse("https://edu.ezygo.app/#/");
                  await launchUrl(_url);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 2.9, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Forgot",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      Text(
                        " credentials?",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.4,
                  ),
                  NeumorphicButton(
                    onPressed: () async {
                      setState(() {
                       arrow=false;
                      });
                      print("onClick");

                      FocusManager.instance.primaryFocus?.unfocus();
username=username?.trim();
                      for (int? i = (username?.length)! - 3;
                          i! < (username?.length)!-2;
                          i++) {
                        if (username![i] == 'c' &&
                            username![i+1] == 'o' &&
                            username![i + 2] == 'm') {
                          print("email");
                          lookup_login();

                        } else {
                          print("username");
                          username_login();
                        }
                      }
                    },
                    style: NeumorphicStyle(
                      color: darkMode ? Colors.grey[850] : Colors.grey[300],
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    padding: EdgeInsets.all(12.0),
                    child:arrow? Icon(
                      FontAwesomeIcons.arrowRight,
                      color: Colors.black.withOpacity(0.6),
                    ):CupertinoActivityIndicator()
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Future lookup_login() async {
    Map newUpdate = {
      "password": password,
      "username": username,
    };
    final url = Uri.parse(
        "https://production.api.ezygo.app/api/v1/login/lookup?username=+${username}");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(newUpdate),
    );
    print(json.decode(response.body)["users"].toString());

    name = json.decode(response.body)["users"][0].toString();

    Map newUpdate2 = {
      "password": password,
      "username": name,
    };
    final url2 = Uri.parse("https://production.api.ezygo.app/api/v1/login");

    final response2 = await http.post(
      url2,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(newUpdate2),
    );
    // print("res 2");
    // print(response2.body);
   // message":"The given data was invalid.
    if(json.decode(response2.body)["message"].toString().length==27){
      print("wrong creds");

      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(

            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('oops you entered the wrong credentials'),

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child:  Text('Try again',style: TextStyle(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w400),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      fieldText_password.clear();
      setState(() {
       arrow=true;
      });
    }
    else{
      print("logging in");
      token=json.decode(response2.body)["access_token"];
      String newusername="";
      for (int? i = 0;
      i! < (username?.length)!;
      i++) {

if(username![i]!='@'){
  newusername+=username![i];
}else{
  break;
}

      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Home(name: newusername.toString(),token: token,)),
      );
    }
  }

  Future username_login() async {
    Map newUpdate2 = {
      "password": password,
      "username": username,
    };
    final url2 = Uri.parse("https://production.api.ezygo.app/api/v1/login");

    final response2 = await http.post(
      url2,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(newUpdate2),
    );
    // print("res 2");
    // print(response2.body);
    if(json.decode(response2.body)["message"].toString().length==27){
      print("wrong creds");

      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(

            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('oops you entered the wrong credentials'),

                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child:  Text('Try again',style: TextStyle(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.w400),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      fieldText_password.clear();
      setState(() {
      arrow=true;
      });

    }  else{
      token=json.decode(response2.body)["access_token"];
      print("logging in");


      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Home(name: username.toString(),token: token,)),
      );
    }
  }
}