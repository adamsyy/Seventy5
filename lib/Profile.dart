import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:seventy5/username.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onHorizontalDragEnd: (DragEndDetails details) => _onHorizontalDrag(details),
      child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(

              children: [
                Padding(
                  padding:EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 16,
                      MediaQuery.of(context).size.height / 16,
                      MediaQuery.of(context).size.width / 16,
                      0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeumorphicButton(
                        margin: EdgeInsets.only(top: 12),

                        onPressed: () {

                          Navigator.pop(context);

                          NeumorphicTheme.of(context)?.themeMode =

                              ThemeMode.dark;
                        },
                        style: NeumorphicStyle(
                          color:Colors.grey[300],
                          shape: NeumorphicShape.concave,
                          boxShape:
                          NeumorphicBoxShape.circle(),
                        ),
                        padding:  const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        child: Icon(FontAwesomeIcons.arrowLeftLong,size: 27,),),


                      NeumorphicButton(
                        margin: EdgeInsets.only(top: 12),

                        onPressed: () {

                          showAlertDialog(context);


                          NeumorphicTheme.of(context)?.themeMode =

                               ThemeMode.dark;
                        },
                        style: NeumorphicStyle(
                          color:Colors.grey[300],
                          shape: NeumorphicShape.concave,
                          boxShape:
                          NeumorphicBoxShape.circle(),
                        ),
                        padding:  const EdgeInsets.fromLTRB(12, 12, 12, 12),
                        child: Icon(FontAwesomeIcons.doorOpen,size: 27,),),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 16,
                      MediaQuery.of(context).size.height / 4.5,
                      0,
                      0),
                  child: NeumorphicButton(
                      onPressed: () {
                        print("onClick");
                      },
                      style: NeumorphicStyle(color: Colors.transparent,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(8))),
                      padding:
                          EdgeInsets.all(MediaQuery.of(context).size.width / 4.5),
                      child: Icon(
                        Icons.favorite_border,
                      )),
                ),
                SizedBox(height: 60,),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 16,
                  0,
                      0,
                      0),
                  child: Text("ADSMSY",style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding:EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 16,
                     5,
                      0,
                      0),
                  child: Text("CS4A"),
                ),
              ],
            ),
          )),
    );
  }

  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = NeumorphicButton(

      style: NeumorphicStyle(depth: 2,
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(8)),
        color:  Colors.grey[300],
        shape: NeumorphicShape.flat,

      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text("no"),
      ),
      onPressed:  ()async {
        // Try reading data from the 'counter' key. If it doesn't exist, returns null.
        // Obtain shared preferences.

        Navigator.pop(context);
      },
    );;
    Widget continueButton = NeumorphicButton(

      style: NeumorphicStyle(depth: 2,
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(8)),
        color:  Colors.grey[300],
        shape: NeumorphicShape.flat,

      ),
      child: Padding(
        padding:EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: Text("yes"),
      ),
      onPressed:  ()async {
        // Try reading data from the 'counter' key. If it doesn't exist, returns null.
        // Obtain shared preferences.

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Username()),
        );
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.grey[300],
      content: Text("  Are you sure you want to sign out?"),
      actions: [
        SizedBox(width: 10,),
        cancelButton,
        SizedBox(width:  MediaQuery.of(context).size.width / 7,),
        continueButton,
        SizedBox(width: 10,),
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  void _onHorizontalDrag(DragEndDetails details) {
    if(details.primaryVelocity == 0) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity?.compareTo(0) == -1)
    {

    }
    else{
      Navigator.pop(context);
      // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Home()));
    }

  }
}
