import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:seventy5/Profile.dart';
import 'package:seventy5/subject.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:seventy5/username.dart';

import 'Ttimetable.dart';

class Home extends StatefulWidget {
  Home({required this.name,required this.token});
  late String idLink;

  String name;
  String token;
  late String section;


  late List<dynamic> ids = [];
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String api = "https://production.api.ezygo.app/api/v1/Xcr45_salt";

  @override
  void initState() {
    super.initState();
    dataFuture = fetchClass();
    onPass();
  }

  late List<dynamic> data = [];
  late Future<List<dynamic>?> dataFuture;
  var subjectId = <String>[];
  var subjectName = <String>[];
  var subjectDetails = <Subject>[];
  late Future<Subject> dataFuture2;
  late String class_name;
  bool darkMode = false;
  late String image;
  late String image_name;
  var tempData;
  int check = 0;

  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      return  const Scaffold(
        body: Center(
          child: SpinKitWave(
            color: Colors.black,
            size: 40.0,
          ),
        ),
      );
    } 
    else {
      return GestureDetector( onHorizontalDragEnd: (DragEndDetails details) => _onHorizontalDrag(details),
          child: AnnotatedRegion<SystemUiOverlayStyle>( value: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          ),
            child: Scaffold(
              body: SafeArea(child :SingleChildScrollView(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Container(
                     margin: const EdgeInsets.fromLTRB(20, 15, 20, 50),
                     child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Expanded(
                           child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(widget.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                               Text( class_name,style: TextStyle(fontWeight: FontWeight.w400),)
                             ],
                           ),
                         ),
                         NeumorphicButton(
                           onPressed: () {
                             Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, duration: Duration(milliseconds: 400), reverseDuration: Duration(milliseconds: 350), child: Timetable(section: widget.idLink,token: widget.token)));
                           },
                           style: const NeumorphicStyle(
                             shape: NeumorphicShape.flat,
                             boxShape: NeumorphicBoxShape.circle(),
                           ),
                           padding:  const EdgeInsets.all(12),
                           child: Icon(FontAwesomeIcons.calendar,size: 27, color: Theme.of(context).primaryColor,),),
                         SizedBox(width: MediaQuery.of(context).size.width / 22,),
                         NeumorphicButton(
                           onPressed: () {
                             Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400), reverseDuration: Duration(milliseconds: 350), child: Profile(badeg_name: image_name, badge:image,idlink: widget.idLink,token: widget.token,username: widget.name,class_name: class_name)));
                             //Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Timetable(section: widget.idlink,token: widget.token)));
                           },
                           style: const NeumorphicStyle(
                             shape: NeumorphicShape.flat,
                             boxShape: NeumorphicBoxShape.circle(),
                           ),
                           padding:  const EdgeInsets.all(12),
                           child: Icon(FontAwesomeIcons.person,size: 27, color: Theme.of(context).primaryColor,),),
                       ],
                     ),
                   ),

                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: subjectDetails.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(34)),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(18),
                                    width: MediaQuery.of(context).size.width / 1,
                                    height: 145,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(child: Text(subjectDetails[index].name.length<50 ? subjectDetails[index].name : subjectDetails[index].name.substring(0,50),
                                                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500))),
                                              const SizedBox(height: 10),
                                              Text(subjectDetails[index].present+"/"+subjectDetails[index].total),
                                              const SizedBox(height: 5),
                                              int.parse(subjectDetails[index].total)>0 ?
                                              Text(
                                                  double.parse(subjectDetails[index].percentage)>=75 ?
                                                  "Can cut " + ((int.parse(subjectDetails[index].present)/0.75).floor()-int.parse(subjectDetails[index].total)).toString() + " classes" :
                                                  "Need to attend " + (3 * int.parse(subjectDetails[index].total) - 4 * int.parse(subjectDetails[index].present)).toString() + " classes"
                                              )
                                              :
                                              Text(
                                                  "Attendance not entered"
                                              ),
                                            ],
                                          ),
                                        ),
                                        CircularPercentIndicator(
                                          radius: 40,
                                          backgroundColor: Colors.grey[500]!,
                                          lineWidth: 3.0,
                                          percent: double.parse(subjectDetails[index].percentage)/100,
                                          center: double.parse(subjectDetails[index].percentage)<100 ?
                                            Text(double.parse(subjectDetails[index].percentage).toStringAsFixed(1) + "%", style: const TextStyle(fontSize: 16)) :
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("100% ", style: const TextStyle(fontSize: 16)),
                                                Icon(FontAwesomeIcons.gripfire, size: 15, color: Theme.of(context).primaryColor,),
                                              ],
                                            ),
                                          progressColor: Theme.of(context).primaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              )
                            ],
                          );
                        },
                    ),
                  ],
                ),
              ),
              )
            ),
          ),
        );
    }
  }

  Future<List<dynamic>?> fetchClass() async {
    final url =
        Uri.parse(api+"/usersubgroups");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json, text/plain, */*',
    });

    if(response.statusCode!=200){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Username(),
          ),
              (route) => false);
    }
    // print(response.body);

    setState(() {
      data = json.decode(response.body);
    });

    return data;
  }

  Future<List<dynamic>?> fetchLists() async {
    final url = Uri.parse(
        api+"/institutionuser/courses/withusers");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json, text/plain, */*',
    });
    // print(response.body);

    setState(() {
      data = json.decode(response.body);
    });
    // print(data);
    for (int i = 0; i < data.length; i++) {
      if(data[i]["usersubgroup"]["name"]==class_name) {
        subjectId.add(data[i]["id"].toString());
        subjectName.add(data[i]["name"].toString().toUpperCase());
      }
    }

    // print(subject_id);
    // print(subject_name);
    for (int i = 0; i < subjectId.length; i++) {
      var l = subjectName[i].split(" ");
      if(l.length>2) {
        if(int.tryParse(l[1])!=null) {
          subjectName[i] = l.sublist(2).join(" ");
        }
      }
      var tempdata = await fetchAttendance(subjectId[i].toString());
      Subject temp = Subject(
          present: tempdata["present"].toString(),
          name: subjectName[i],
          percentage: tempdata["persantage"].toString(),
          total: tempdata["totel"].toString());
      setState(() {
        subjectDetails.add(temp);
      });
    }
    var subjectPercentage = <double>[];
    for (int i = 0; i < subjectDetails.length; i++) {
      if(int.parse(subjectDetails[i].total)==0) {
        Subject sub = subjectDetails[i];
        subjectDetails.remove(sub);
        subjectDetails.add(sub);
      }
    }
    for (int i = 0; i < subjectDetails.length; i++) {
      if(int.parse(subjectDetails[i].total)>0)
        subjectPercentage.add(double.parse(subjectDetails[i].percentage));
    }
    subjectPercentage.sort();
    if(subjectPercentage[0]==100){
      image="animation/full100.png";
      image_name="legendary";
    }
    else if(subjectPercentage[0]>=90){
      image="animation/90.png";
      image_name="champion";
    }
    else if(subjectPercentage[0]>=75&&subjectPercentage[subjectPercentage.length-1]<=85)
    {
      image="animation/7580.png";
      image_name="Regular";
    }

    else if(subjectPercentage[0]>=75)
    {
      image="animation/75.png";
      image_name="Veteran";
    }
    else if(subjectPercentage[0]>=50){
      image="animation/50.png";
      image_name="just miss";
    }
    else{
      image="animation/50below.png";
      image_name="Maaveli";
    }
    setState(() {
      check = 1;
    });
    // print(subjectDetails[0].total);
    return data;
  }

  Future<Map<String, dynamic>> fetchAttendance(String id) async {
    final url = Uri.parse(
        api+"/attendancereports/institutionuser/courses/$id/summery");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json, text/plain, */*',
    });
    // print(response.body);

    setState(() {
      tempData = json.decode(response.body);
    });
    //print(response.body);
    return tempData;
  }

  void onPass() async {
    if (data.isNotEmpty) {
      widget.idLink = (data[0]["id"].toString());
      class_name= (data[0]["name"].toString());
    } else {
      await fetchClass();
      widget.idLink = (data[0]["id"].toString());
      class_name= (data[0]["name"].toString());
    }
    await fetchLists();
  }

  void _onHorizontalDrag(DragEndDetails details) {
    if(details.primaryVelocity == 0) return; // user have just tapped on screen (no dragging)
    //
    if (details.primaryVelocity?.compareTo(0) == -1) {
      Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,duration: Duration(milliseconds: 400), reverseDuration: Duration(milliseconds: 350), child: Profile(badeg_name: image_name,badge:image,idlink: widget.idLink,token: widget.token,username: widget.name,class_name: class_name)));
    }
  }
}
