import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:seventy5/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  void initState() {
    // TODO: implement initState

  fieldText_password.clear();
  fieldText_username.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height /15),
                  Image.asset("animation/pic2.png",height: 275,width: 275,),
                  SizedBox(height: MediaQuery.of(context).size.height /10),
                  Neumorphic(
                      padding: EdgeInsets.all(5),
                      style: NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                          depth: -5,
                          lightSource: LightSource.topLeft,
                      ),
                      child: TextFormField(
                        cursorColor: Theme.of(context).primaryColor,
                        controller: fieldText_username,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontSize: 16.0),
                        textAlign: TextAlign.center,
                        onSaved: (String? value) {},
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                            hintText: 'username or email',
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            border: InputBorder.none,),
                        onChanged: (value) {
                          username = value;
                          // print(username);
                        },
                      ),
                  ),
                  SizedBox(height: 25),
                  Neumorphic(
                    padding: EdgeInsets.all(5),
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                        depth: -5,
                        lightSource: LightSource.topLeft,
                    ),
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      controller: fieldText_password,
                      onSaved: (value) {
                        password = value;
                      },
                      keyboardType: TextInputType.name,
                      obscureText: true,
                      style: const TextStyle(fontSize: 16.0),
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'password',
                        hintStyle: TextStyle(fontWeight: FontWeight.w300),
                        border: InputBorder.none,),
                      onChanged: (value) {
                        //    print(value);
                        password=value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final Uri _url = Uri.parse("https://edu.ezygo.app/#/");
                      await launchUrl(_url);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
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
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NeumorphicButton(
                        onPressed: () async {
                          if(username?.length==0||password?.length==0)
                          {
                            showAlertDialog(context);
                          }
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
                        child:arrow? Icon(
                          FontAwesomeIcons.arrowRight,
                          color: Colors.black.withOpacity(0.6),
                        ):CupertinoActivityIndicator()
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future lookup_login() async {

    Map newUpdate = {
      "password": password,
      "username": username,
    };
    final url = Uri.parse(
        "https://production.api.ezygo.app/api/v1/Xcr45_salt/login/lookup?username=+${username}");

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
    final url2 = Uri.parse("https://production.api.ezygo.app/api/v1/Xcr45_salt/login");

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
      showAlertDialog(context);

      fieldText_password.clear();
      setState(() {
       arrow=true;
      });
    }
    else{
      print("logging in");
      token=json.decode(response2.body)["access_token"];
      String newusername="";
      for (int? i = 0;i! < (username?.length)!;i++) {
        if(username![i]!='@'){
          newusername+=username![i];
        }else{
          break;
        }
      }
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username',name);
      await prefs.setString('password',password!);
      await prefs.setString('token',token);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Home(name: name.toString(),token: token,)),
      );
    }
  }

  Future username_login() async {

  Map newUpdate2 = {
      "password": password,
      "username": username,
    };
    final url2 = Uri.parse("https://production.api.ezygo.app/api/v1/Xcr45_salt/login");

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

      showAlertDialog(context);

      fieldText_password.clear();
      setState(() {
        arrow=true;
      });

    } else{
      token=json.decode(response2.body)["access_token"];
      print("logging in");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username',username!);
      await prefs.setString('password',password!);
      await prefs.setString('token',token);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Home(name: username.toString(),token: token,)),
      );
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget retryButton = NeumorphicButton(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(34)),
        shape: NeumorphicShape.flat,
      ),
      child: Container(
        child: const Text("Retry", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        padding: const EdgeInsets.fromLTRB(25, 4, 25, 4),
      ),
      onPressed:  ()async {
        // Try reading data from the 'counter' key. If it doesn't exist, returns null.
        // Obtain shared preferences.

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actionsAlignment: MainAxisAlignment.center,
      //contentPadding: EdgeInsets.fromLTRB(100, 10, 100, 10),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Invalid credentials", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        retryButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Neumorphic(child: alert,
          style: NeumorphicStyle(
              depth: 0,
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(0))
          ),
        );
      },
    );
  }
}
