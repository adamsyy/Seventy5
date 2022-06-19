import 'dart:convert';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Timetable extends StatefulWidget {
  Timetable({required this.token,required this.section});
  String token;
  var today;
  var yesterday;
  var index_today;
  var i = 0;
  late String dayno;
  var noday = [];
  String section;
  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  var today;
  void initState() {
    super.initState();
    fetch_ids();
    dataFuture = fetchTimeTable();
    DateTime now = DateTime.now();
    widget.yesterday = DateTime(now.year, now.month, now.day - 0);

    widget.today = DateFormat('EEEE').format(widget.yesterday);
    widget.dayno = widget.today;
    widget.index_today = index_of_day(widget.today);
  }

  late List<dynamic> data = [];
  late Future<List<dynamic>?> dataFuture;
  var day1 = <String>[];
  var day2 = <String>[];
  var day3 = <String>[];
  var day4 = <String>[];
  var day5 = <String>[];
  var day = <String>[];
  var day_ids = <int>[];

  int check = 0;
  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      return Scaffold(
          body: Center(
        child: Scaffold(
          backgroundColor: Colors.grey[300],
        ),
      ));
    } else {

      if(widget.today=="Sunday"){
        return GestureDetector(onHorizontalDragEnd: (DragEndDetails details) => _onHorizontalDrag(details),
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
                                shape: NeumorphicShape.concave,
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
                                  widget.i--;
                                  widget.i--;
                                  widget.today = DateFormat('EEEE').format(DateTime(
                                      now.year, now.month, now.day + widget.i));
                                  widget.index_today = index_of_day(widget.today);
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
                          Padding(
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
                                  "Monday",
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          NeumorphicButton(
                            margin: EdgeInsets.only(top: 12),
                            onPressed: () {
                              setState(() {
                                DateTime now = DateTime.now();
                                widget.i++;
                                widget.i++;
                                widget.today = DateFormat('EEEE').format(
                                    DateTime(now.year, now.month, now.day + widget.i));
                                widget.index_today = index_of_day(widget.today);
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
                        height: MediaQuery.of(context).size.height / 30,
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: day1.length,
                        itemBuilder: (context, index) {
                          if (length_of_day(widget.today) > 0) {
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
                                    Neumorphic(
                                        style: NeumorphicStyle(
                                          //color: Colors.transparent,
                                            depth: 3,
                                            shape: NeumorphicShape.flat,
                                            boxShape: NeumorphicBoxShape.roundRect(
                                                BorderRadius.circular(8))),
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width / 32),
                                        child: day1[index].length > 30
                                            ? Text(
                                          day1[index]
                                              .substring(0, 30),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                            : Text(
                                          day1[index],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            );
                          } else {
                            return SizedBox(
                              height: 10,
                            );
                          }
                        },
                      ),

                      // Row(mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     SizedBox(width: 10,),
                      //     Text("1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      //     SizedBox(width: 20,),
                      //     Neumorphic(
                      //
                      //         style: NeumorphicStyle(//color: Colors.transparent,
                      //             depth: 3,
                      //
                      //             shape: NeumorphicShape.flat,
                      //             boxShape: NeumorphicBoxShape.roundRect(
                      //                 BorderRadius.circular(8))),
                      //         padding:
                      //         EdgeInsets.all(MediaQuery.of(context).size.width / 32),
                      //         child: day1[0].length>38?Text(day1[0].substring(0,38),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),):  Text(day1[0],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                      //   ],
                      // ),

                      // Row(mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     NeumorphicButton(
                      //       onPressed: () {
                      //        // showAlertDialog2(context);
                      //       },
                      //       style: NeumorphicStyle(
                      //         depth: -3,
                      //         shape: NeumorphicShape.flat,
                      //         boxShape:
                      //         NeumorphicBoxShape.circle(),
                      //       ),
                      //       padding:  const EdgeInsets.all(12),
                      //       child: Icon(FontAwesomeIcons.peopleGroup,size: 24,color: Theme.of(context).primaryColor,),),
                      //     SizedBox(width: MediaQuery.of(context).size.width / 20,),
                      // NeumorphicButton(
                      //   onPressed: () async{
                      //   //  showAlertDialog3(context);
                      //     //.   openCheckout();
                      //   },
                      //   style: const NeumorphicStyle(
                      //     depth: -3,
                      //     shape: NeumorphicShape.flat,
                      //     boxShape:
                      //     NeumorphicBoxShape.circle(),
                      //   ),
                      //   padding:  const EdgeInsets.all(12),
                      //   child: Icon(FontAwesomeIcons.mugSaucer,size: 24,color : Theme.of(context).primaryColor,),),
                      // SizedBox(width: MediaQuery.of(context).size.width / 20,),
                      // NeumorphicButton(
                      //   onPressed: () {
                      //    // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Timetable(token: widget.token)));
                      //   },
                      //
                      //   style: const NeumorphicStyle(
                      //     depth: -3,
                      //     shape: NeumorphicShape.flat,
                      //     boxShape:
                      //     NeumorphicBoxShape.circle(),
                      //   ),
                      //   padding:  const EdgeInsets.all(12),
                      //   child: Icon(FontAwesomeIcons.calendar,size: 24, color: Theme.of(context).primaryColor,),),
                      //   ],
                      //
                      // )
                    ],
                  ),
                ),
              )),
        );


      }

     else if(widget.today=="Saturday"){
        return GestureDetector(onHorizontalDragEnd: (DragEndDetails details) => _onHorizontalDrag(details),
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
                                shape: NeumorphicShape.concave,
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
                                  widget.i--;
                                  widget.i--;
                                  widget.today = DateFormat('EEEE').format(DateTime(
                                      now.year, now.month, now.day + widget.i));
                                  widget.index_today = index_of_day(widget.today);
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
                          Padding(
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
                                  "Monday",
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          NeumorphicButton(
                            margin: EdgeInsets.only(top: 12),
                            onPressed: () {
                              setState(() {
                                DateTime now = DateTime.now();
                                widget.i++;
                                widget.i++;
                                widget.i++;
                                widget.today = DateFormat('EEEE').format(
                                    DateTime(now.year, now.month, now.day + widget.i));
                                widget.index_today = index_of_day(widget.today);
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
                        height: MediaQuery.of(context).size.height / 30,
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: day1.length,
                        itemBuilder: (context, index) {
                          if (length_of_day(widget.today) > 0) {
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
                                    Neumorphic(
                                        style: NeumorphicStyle(
                                          //color: Colors.transparent,
                                            depth: 3,
                                            shape: NeumorphicShape.flat,
                                            boxShape: NeumorphicBoxShape.roundRect(
                                                BorderRadius.circular(8))),
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width / 32),
                                        child: day1[index].length > 30
                                            ? Text(
                                          day1[index]
                                              .substring(0, 30),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                            : Text(
                                          day1[index],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            );
                          } else {
                            return SizedBox(
                              height: 10,
                            );
                          }
                        },
                      ),

                      // Row(mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     SizedBox(width: 10,),
                      //     Text("1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      //     SizedBox(width: 20,),
                      //     Neumorphic(
                      //
                      //         style: NeumorphicStyle(//color: Colors.transparent,
                      //             depth: 3,
                      //
                      //             shape: NeumorphicShape.flat,
                      //             boxShape: NeumorphicBoxShape.roundRect(
                      //                 BorderRadius.circular(8))),
                      //         padding:
                      //         EdgeInsets.all(MediaQuery.of(context).size.width / 32),
                      //         child: day1[0].length>38?Text(day1[0].substring(0,38),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),):  Text(day1[0],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                      //   ],
                      // ),

                      // Row(mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     NeumorphicButton(
                      //       onPressed: () {
                      //        // showAlertDialog2(context);
                      //       },
                      //       style: NeumorphicStyle(
                      //         depth: -3,
                      //         shape: NeumorphicShape.flat,
                      //         boxShape:
                      //         NeumorphicBoxShape.circle(),
                      //       ),
                      //       padding:  const EdgeInsets.all(12),
                      //       child: Icon(FontAwesomeIcons.peopleGroup,size: 24,color: Theme.of(context).primaryColor,),),
                      //     SizedBox(width: MediaQuery.of(context).size.width / 20,),
                      // NeumorphicButton(
                      //   onPressed: () async{
                      //   //  showAlertDialog3(context);
                      //     //.   openCheckout();
                      //   },
                      //   style: const NeumorphicStyle(
                      //     depth: -3,
                      //     shape: NeumorphicShape.flat,
                      //     boxShape:
                      //     NeumorphicBoxShape.circle(),
                      //   ),
                      //   padding:  const EdgeInsets.all(12),
                      //   child: Icon(FontAwesomeIcons.mugSaucer,size: 24,color : Theme.of(context).primaryColor,),),
                      // SizedBox(width: MediaQuery.of(context).size.width / 20,),
                      // NeumorphicButton(
                      //   onPressed: () {
                      //    // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Timetable(token: widget.token)));
                      //   },
                      //
                      //   style: const NeumorphicStyle(
                      //     depth: -3,
                      //     shape: NeumorphicShape.flat,
                      //     boxShape:
                      //     NeumorphicBoxShape.circle(),
                      //   ),
                      //   padding:  const EdgeInsets.all(12),
                      //   child: Icon(FontAwesomeIcons.calendar,size: 24, color: Theme.of(context).primaryColor,),),
                      //   ],
                      //
                      // )
                    ],
                  ),
                ),
              )),
        );


      }

      else{

        return GestureDetector(onHorizontalDragEnd: (DragEndDetails details) => _onHorizontalDrag(details),
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
                                shape: NeumorphicShape.concave,
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
                                  widget.i--;
                                  widget.today = DateFormat('EEEE').format(DateTime(
                                      now.year, now.month, now.day + widget.i));
                                  widget.index_today = index_of_day(widget.today);
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
                          Padding(
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
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          NeumorphicButton(
                            margin: EdgeInsets.only(top: 12),
                            onPressed: () {
                              setState(() {
                                DateTime now = DateTime.now();
                                widget.i++;
                                widget.today = DateFormat('EEEE').format(
                                    DateTime(now.year, now.month, now.day + widget.i));
                                widget.index_today = index_of_day(widget.today);
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
                        height: MediaQuery.of(context).size.height / 30,
                      ),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.index_today.length>6?7:widget.index_today.length,
                        itemBuilder: (context, index) {
                          if (length_of_day(widget.today) > 0) {
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
                                    Neumorphic(
                                        style: NeumorphicStyle(
                                          //color: Colors.transparent,
                                            depth: 3,
                                            shape: NeumorphicShape.flat,
                                            boxShape: NeumorphicBoxShape.roundRect(
                                                BorderRadius.circular(8))),
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width / 32),
                                        child: widget.index_today[index].length > 38
                                            ? Text(
                                          widget.index_today[index]
                                              .substring(0, 30),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )
                                            : Text(
                                          widget.index_today[index],
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            );
                          } else {
                            return SizedBox(
                              height: 10,
                            );
                          }
                        },
                      ),

                      // Row(mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     SizedBox(width: 10,),
                      //     Text("1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      //     SizedBox(width: 20,),
                      //     Neumorphic(
                      //
                      //         style: NeumorphicStyle(//color: Colors.transparent,
                      //             depth: 3,
                      //
                      //             shape: NeumorphicShape.flat,
                      //             boxShape: NeumorphicBoxShape.roundRect(
                      //                 BorderRadius.circular(8))),
                      //         padding:
                      //         EdgeInsets.all(MediaQuery.of(context).size.width / 32),
                      //         child: day1[0].length>38?Text(day1[0].substring(0,38),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),):  Text(day1[0],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                      //   ],
                      // ),

                      // Row(mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     NeumorphicButton(
                      //       onPressed: () {
                      //        // showAlertDialog2(context);
                      //       },
                      //       style: NeumorphicStyle(
                      //         depth: -3,
                      //         shape: NeumorphicShape.flat,
                      //         boxShape:
                      //         NeumorphicBoxShape.circle(),
                      //       ),
                      //       padding:  const EdgeInsets.all(12),
                      //       child: Icon(FontAwesomeIcons.peopleGroup,size: 24,color: Theme.of(context).primaryColor,),),
                      //     SizedBox(width: MediaQuery.of(context).size.width / 20,),
                      // NeumorphicButton(
                      //   onPressed: () async{
                      //   //  showAlertDialog3(context);
                      //     //.   openCheckout();
                      //   },
                      //   style: const NeumorphicStyle(
                      //     depth: -3,
                      //     shape: NeumorphicShape.flat,
                      //     boxShape:
                      //     NeumorphicBoxShape.circle(),
                      //   ),
                      //   padding:  const EdgeInsets.all(12),
                      //   child: Icon(FontAwesomeIcons.mugSaucer,size: 24,color : Theme.of(context).primaryColor,),),
                      // SizedBox(width: MediaQuery.of(context).size.width / 20,),
                      // NeumorphicButton(
                      //   onPressed: () {
                      //    // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Timetable(token: widget.token)));
                      //   },
                      //
                      //   style: const NeumorphicStyle(
                      //     depth: -3,
                      //     shape: NeumorphicShape.flat,
                      //     boxShape:
                      //     NeumorphicBoxShape.circle(),
                      //   ),
                      //   padding:  const EdgeInsets.all(12),
                      //   child: Icon(FontAwesomeIcons.calendar,size: 24, color: Theme.of(context).primaryColor,),),
                      //   ],
                      //
                      // )
                    ],
                  ),
                ),
              )),
        );


      }

    }

    return Scaffold(
        body: Center(
      child: Text(day1[0]),
    ));
  }

  Future<List<dynamic>?> fetchTimeTable() async {
    final url = Uri.parse(
        "https://production.api.ezygo.app/api/v1/usersubgroup/${widget.section}/courseschedules");

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
        if (data[i]["workday_id"] == day_ids[0]) {
          day1.add(data[i]["course_user"]["course"]["name"]);
        }
        if (data[i]["workday_id"] == day_ids[1]) {
          day2.add(data[i]["course_user"]["course"]["name"]);
        }
        if (data[i]["workday_id"] == day_ids[2]) {
          day3.add(data[i]["course_user"]["course"]["name"]);
        }
        if (data[i]["workday_id"] == day_ids[3]) {
          day4.add(data[i]["course_user"]["course"]["name"]);
        }
        if (data[i]["workday_id"] == day_ids[4]) {
          day5.add(data[i]["course_user"]["course"]["name"]);
        }
      }
      check = 1;
    });
    print("day1");
    print(day1);
    print("day2");
    print(day2);
    print("day3");
    print(day3);
    print('day4');
    print(day4);
    print("day5");
    print(day5);
    //print(day);
    // print(day);
    // for (int i = 0; i < 6; i++) {
    //   print(day[i]);
    // }
    // print("day2");
    // for (int i = 6; i < 12; i++) {
    //   print(day[i]);
    // }
    // print("day3");
    // for (int i = 12; i < 18; i++) {
    //   print(day[i]);
    // }
    // print("day4");
    // for (int i = 18; i < 24; i++) {
    //   print(day[i]);
    // }
    // print("day5");
    // for (int i = 24; i < 30; i++) {
    //   print(day[i]);
    // }
    return data;
    // }
  }

  Future<List<dynamic>?> fetch_ids() async {
    final url = Uri.parse("https://production.api.ezygo.app/api/v1/workdays");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ${widget.token}',
      'Accept': 'application/json, text/plain, */*',
    });
    // print(response.body);
    // if (response.statusCode == 200) {

    setState(() {
      data = json.decode(response.body);
      for (int i = 0; i < 5; i++) {
        day_ids.add(data[i]["id"]);
      }
    });
    print(day_ids);
    // }
  }

  int length_of_day(String day) {
    if (day == 'Monday') {
      return day1.length;
    }
    if (day == 'Tuesday') {
      return day2.length;
    }
    if (day == 'Wednesday') {
      return day3.length;
    }
    if (day == 'Thursday') {
      return day4.length;
    }
    if (day == 'Friday') {
      return day5.length;
    } else {
      return day1.length;
    }
  }

  dynamic index_of_day(String theday) {
    if (theday == 'Monday') {
      return day1;
    }
    if (theday == 'Tuesday') {
      return day2;
    }
    if (theday == 'Wednesday') {
      return day3;
    }
    if (theday == 'Thursday') {
      return day4;
    }
    if (theday == 'Friday') {
      return day5;
    } else {
      return day1;
    }
  }





  void _onHorizontalDrag(DragEndDetails details) {
    if(details.primaryVelocity == 0) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity?.compareTo(0) == -1)
    {

    }
    else{
      Navigator.pop(context);
      // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Home()));
      // Navigator.pop(context);
    }

  }
}
