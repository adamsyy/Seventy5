import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Allmaveli extends StatefulWidget {
  Allmaveli({required this.main_badge, required this.main_badge_name});
  String main_badge;
  String main_badge_name;

  @override
  State<Allmaveli> createState() => _AllmaveliState();
}

class _AllmaveliState extends State<Allmaveli> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector( onHorizontalDragEnd: (DragEndDetails details) => _onHorizontalDrag(details),
        child: Scaffold(
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                SizedBox(
                  height: 65,
                ),
                Text(
                  "Earn your badge!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Neumorphic(
                            style: NeumorphicStyle(
                                //color: Colors.transparent,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(8))),
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width / 12),
                            child: Column(
                              children: [
                                Image.asset(widget.main_badge,
                                    height: 150, width: 150),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.main_badge_name,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset("animation/50.png",
                                height: 100, width: 100),
                            Text(
                              "just miss",
                              style: TextStyle(fontWeight: FontWeight.w200),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Image.asset("animation/full100.png",
                            height: 100, width: 100),
                        Text(
                          "legendary",
                          style: TextStyle(fontWeight: FontWeight.w200),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset("animation/50below.png",
                                height: 100, width: 100),
                            Text(
                              "maaveli",
                              style: TextStyle(fontWeight: FontWeight.w200),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Image.asset("animation/75.png", height: 100, width: 100),
                        Text(
                          "Veteran",
                          style: TextStyle(fontWeight: FontWeight.w200),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset("animation/90.png",
                                height: 100, width: 100),
                            Text(
                              "champion",
                              style: TextStyle(fontWeight: FontWeight.w200),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Image.asset("animation/7580.png",
                            height: 100, width: 100),
                        Text(
                          "Regular",
                          style: TextStyle(fontWeight: FontWeight.w200),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _onHorizontalDrag(DragEndDetails details) {
    if(details.primaryVelocity == 0) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity?.compareTo(0) == -1)
    { print('dragged from left');


    }
    else
      print('dragged from right');
    Navigator.pop(context);
  }


}
