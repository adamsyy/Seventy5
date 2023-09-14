import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Timetable extends StatefulWidget {
  Timetable({required this.token,required this.section});
  String token;
  String section;
  var yesterday;
  var today;
  var i = 0;
  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  var today;
  String api = "https://production.api.ezygo.app/api/v1/Xcr45_salt";

  late List<dynamic> data = [];
  var days = new Map();
  var sessions = new Map();
  var timeTable = new Map<String, List<String>>();

  int check = 0;
  void initState() {
    super.initState();
    fetch_days();
    fetch_sessions();
    fetchTimeTable();

    DateTime now = DateTime.now();
    widget.yesterday = DateTime(now.year, now.month, now.day - 0);

    widget.today = DateFormat('EEEE').format(widget.yesterday);
    if(widget.today=="Saturday")
      widget.i+=2;
    else if(widget.today=="Sunday")
      widget.i+=1;
    widget.today = DateFormat('EEEE').format(DateTime(now.year, now.month, now.day + widget.i));
  }

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) => _onHorizontalDrag(details),
      onVerticalDragEnd: (DragEndDetails details) => _onVerticalDrag(details),
      child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 15, 20, 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NeumorphicButton(
                          margin: EdgeInsets.only(top: 12),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: const NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.circle(),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            FontAwesomeIcons.arrowLeftLong,
                            size: 27,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height / 9,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: NeumorphicButton(
                          margin: EdgeInsets.only(top: 12),
                          onPressed: () {
                            setState(() {
                              DateTime now = DateTime.now();
                              if(widget.today=="Monday")
                                widget.i-=2;
                              widget.i--;
                              widget.today = DateFormat('EEEE').format(DateTime(
                                  now.year, now.month, now.day + widget.i));
                            });
                          },
                          style: const NeumorphicStyle(
                            shape: NeumorphicShape.concave,
                            boxShape: NeumorphicBoxShape.circle(),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            FontAwesomeIcons.angleLeft,
                            size: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/ 3,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Neumorphic(
                              style: NeumorphicStyle(
                                //color: Colors.transparent,
                                  depth: -3,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(8))),
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width / 32),
                              child: Text(
                                widget.today,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      NeumorphicButton(
                        margin: EdgeInsets.only(top: 12),
                        onPressed: () {
                          setState(() {
                            DateTime now = DateTime.now();
                            if(widget.today=="Friday")
                              widget.i+=2;
                            widget.i++;
                            widget.today = DateFormat('EEEE').format(
                                DateTime(now.year, now.month, now.day + widget.i));
                          });
                        },
                        style: const NeumorphicStyle(
                          shape: NeumorphicShape.concave,
                          boxShape: NeumorphicBoxShape.circle(),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          FontAwesomeIcons.angleRight,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),

                  // SizedBox(height: MediaQuery.of(context).size.height / 20,),

                  SizedBox(
                    height: 60,
                  ),
                  if(check==1)  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sessions.length,
                    itemBuilder: (context, index) {
                      if (fetchTTCell(widget.today,(index+1).toString()).length>0 ) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Neumorphic(
                                      style: NeumorphicStyle(
                                          depth: 3,
                                          shape: NeumorphicShape.flat,
                                          boxShape: NeumorphicBoxShape.roundRect(
                                              BorderRadius.circular(8))),
                                      padding: EdgeInsets.all(20),
                                      child:  Text(
                                        fetchTTCell(widget.today,(index+1).toString())[0] + (fetchTTCell(widget.today,(index+1).toString()).length>1 ?  " / " + fetchTTCell(widget.today,(index+1).toString())[1] : ""),
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ),
                                ),
                                SizedBox(width: 40,)
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            )
                          ],
                        );
                      } else {
                        return SizedBox(
                          height: 10,
                        );
                      }
                    },
                  )
                  else  Column(
                    children : [
                      SizedBox(height : 10),
                      Center(
                        child: SpinKitFadingCircle(
                          color: Colors.black,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );

  }

  void fetchTimeTable() async {
    final url = Uri.parse(api+"/usersubgroup/${widget.section}/courseschedules");
    Map<String, List<String>> typedMap;

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json, text/plain, */*',
    });
    // print(response.body);
    // if (response.statusCode == 200) {
    int j = 0;
    setState(() {
      data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        if(timeTable[data[i]["workday_id"].toString()+data[i]["session_id"].toString()]==null) {
          timeTable[data[i]["workday_id"].toString()+data[i]["session_id"].toString()] = [];
        }
        timeTable[data[i]["workday_id"].toString()+data[i]["session_id"].toString()]?.add(data[i]["course_user"]["course"]["code"].toString());
      }
      check = 1;
    });
    //print(timeTable);
  }


  void fetch_days() async {
    final url = Uri.parse(api+"/workdays");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json, text/plain, */*',
    });
    // print(response.body);
    // if (response.statusCode == 200) {

    setState(() {
      data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        days[data[i]["name"]]= data[i]["id"];
      }
      //print(days);
    });
    //print(day_ids);
    // }
  }

  void fetch_sessions() async {
    final url = Uri.parse(api+"/sessions");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json, text/plain, */*',
    });
    // print(response.body);
    // if (response.statusCode == 200) {

    setState(() {
      data = json.decode(response.body);
      for (int i = 0; i < data.length; i++) {
        sessions[data[i]["view_order"]]= data[i]["id"];
      }
      //print(sessions);
    });
    //print(day_ids);
    // }
  }




  dynamic fetchTTCell(String day, String session) {
    if(timeTable[days[day].toString()+sessions[session].toString()] !=null)
      return timeTable[days[day].toString()+sessions[session].toString()];
    return "";
  }



  void _onHorizontalDrag(DragEndDetails details) {
    if(details.primaryVelocity == null) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity! < 0)
    {
      setState(() {
          DateTime now = DateTime.now();
          if(widget.today=="Friday")
            widget.i+=2;
          widget.i++;
          widget.today = DateFormat('EEEE').format(
            DateTime(now.year, now.month, now.day + widget.i));
      });
    }
    else{
      setState(() {
          DateTime now = DateTime.now();
          if(widget.today=="Monday")
            widget.i-=2;
          widget.i--;
          widget.today = DateFormat('EEEE').format(DateTime(
              now.year, now.month, now.day + widget.i));
      });
    }

  }
  void _onVerticalDrag(DragEndDetails details) {
    if(details.primaryVelocity == null) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity! > 0)
    {
      Navigator.pop(context);
    }

  }
}
