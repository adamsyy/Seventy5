import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seventy5/subject.dart';

class Home extends StatefulWidget {
  late String id_link;
  var check=0;
  late List<dynamic> ids = [];
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataFuture = fetchclass();
    onpass();
  }

  late List<dynamic> data = [];
  late Future<List<dynamic>?> dataFuture;
  var subject_id = <String>[];
  var subject_name = <String>[];
  var subject_details = <Subject>[];
  late Future<Subject> dataFuture2;
  var tempdata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: subject_details.length,
          itemBuilder: (context, index) {
            if (widget.check == 2) {
              print(subject_details[0].total);
              return Text(subject_details[index].percentage);
            }
              else if(widget.check==0){
                widget.check=1;
                return CupertinoActivityIndicator();
              }
              return SizedBox(height: 1,);

          }),
      backgroundColor: Colors.pink,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

        },
      ),
    );
  }

  Future<List<dynamic>?> fetchclass() async {
    final url =
        Uri.parse("https://production.api.ezygo.app/api/v1/usersubgroups");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ml3j24Sf2LdIoOewSbQmhuvVYtCxeb6FbXlMIODQ',
      'Accept': 'application/json, text/plain, */*',
    });
    // print(response.body);

    setState(() {
      data = json.decode(response.body);
    });

    return data;
  }

  Future<List<dynamic>?> fetchlists() async {
    final url = Uri.parse(
        "https://production.api.ezygo.app/api/v1/institutionuser/courses/withusers");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ml3j24Sf2LdIoOewSbQmhuvVYtCxeb6FbXlMIODQ',
      'Accept': 'application/json, text/plain, */*',
    });
    // print(response.body);

    setState(() {
      data = json.decode(response.body);
    });
// print(data);
    for (int i = 0; i < data.length; i++) {
      if (data[i]["usersubgroup"]["id"] == int.parse(widget.id_link)) {
        subject_id.add(data[i]["id"].toString());
        subject_name.add(data[i]["name"]);
      }
    }
    // print(subject_id);
    // print(subject_name);
    for (int i = 0; i < subject_id.length; i++) {
      var tempdata = await fetch_attendance(subject_id[i].toString());
      Subject temp = new Subject(
          present: tempdata["present"].toString(),
          name: subject_name[i],
          percentage: tempdata["persantage"].toString(),
          total: tempdata["totel"].toString());
   setState(() {

     subject_details.add(temp);
   });
    }
    setState(() {
      widget.check = 2;
    });
    print(subject_details[0].total);

    return data;
  }

  Future<Map<String, dynamic>> fetch_attendance(String id) async {
    final url = Uri.parse(
        "https://production.api.ezygo.app/api/v1/attendancereports/institutionuser/courses/+${id}+/summery");

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer ml3j24Sf2LdIoOewSbQmhuvVYtCxeb6FbXlMIODQ',
      'Accept': 'application/json, text/plain, */*',
    });
    // print(response.body);

    setState(() {
      tempdata = json.decode(response.body);
    });
// // print(data);

//print(response.body);
    return tempdata;
  }

 void onpass()async{
   if (data.length != 0) {
     widget.id_link = (data[1]["id"].toString());
   } else {
     await fetchclass();
     widget.id_link = (data[data.length - 1]["id"].toString());
   }

//https://production.api.ezygo.app/api/v1/institutionuser/courses/withusers
   await fetchlists();

 }

}
