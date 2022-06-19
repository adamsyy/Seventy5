import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Allmaveli extends StatefulWidget {
  @override
  State<Allmaveli> createState() => _AllmaveliState();
}

class _AllmaveliState extends State<Allmaveli> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 100,
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
                            Image.asset("animation/50below.png",
                                height: 150, width: 150),
                          ],
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Maaveli",
                  style: TextStyle(fontWeight: FontWeight.w200),
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
                        Image.asset("animation/else.png",
                            height: 100, width: 100),
                        Text(
                          "nee pass aavum",
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
            SizedBox(height: 100,),




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
                          "nissarm",
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
                    Image.asset("animation/7580.png", height: 100, width: 100),
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
    );
  }
}
