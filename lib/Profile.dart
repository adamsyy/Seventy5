import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:seventy5/Ttimetable.dart';
import 'package:seventy5/username.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  Profile({required this.username,required this.token,required this.class_name,required this.idlink});
  late String username;
  late String token;
  late String class_name;
  late String idlink;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onHorizontalDragEnd: (DragEndDetails details) => _onHorizontalDrag(details),
      child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 15, 20, 50),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            padding:  const EdgeInsets.all(12),
                            child: Icon(FontAwesomeIcons.arrowLeftLong,size: 27,color: Theme.of(context).primaryColor,),),
                          NeumorphicButton(
                            margin: EdgeInsets.only(top: 12),
                            onPressed: () {
                              showAlertDialog(context);
                            },
                            style: const NeumorphicStyle(
                              shape: NeumorphicShape.concave,
                              boxShape:
                              NeumorphicBoxShape.circle(),
                            ),
                            padding:  const EdgeInsets.all(12),
                            child: Icon(FontAwesomeIcons.doorOpen,size: 27, color: Theme.of(context).primaryColor,),),
                        ],
                      ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 9,),
                  NeumorphicButton(
                        onPressed: () {
                          print("onClick");
                        },
                        style: NeumorphicStyle(//color: Colors.transparent,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(8))),
                        padding:
                            EdgeInsets.all(MediaQuery.of(context).size.width / 4.5),
                        child: const Icon(Icons.favorite_border,)),

                  SizedBox(height: MediaQuery.of(context).size.height / 20,),
                  Text(widget.username.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(widget.class_name),
                  SizedBox(height: MediaQuery.of(context).size.height / 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NeumorphicButton(
                        onPressed: () {
                          showAlertDialog2(context);
                        },
                        style: const NeumorphicStyle(
                          depth: -3,
                          shape: NeumorphicShape.concave,
                          boxShape:
                          NeumorphicBoxShape.circle(),
                        ),
                        padding:  const EdgeInsets.all(12),
                        child: Icon(FontAwesomeIcons.peopleGroup,size: 24,color: Theme.of(context).primaryColor,),),
                      SizedBox(width: MediaQuery.of(context).size.width / 20,),
                      NeumorphicButton(
                        onPressed: () async{
                          showAlertDialog3(context);
                       //.   openCheckout();
                        },
                        style: const NeumorphicStyle(
                          depth: -3,
                          shape: NeumorphicShape.flat,
                          boxShape:
                          NeumorphicBoxShape.circle(),
                        ),
                        padding:  const EdgeInsets.all(12),
                        child: Icon(FontAwesomeIcons.mugSaucer,size: 24,color : Theme.of(context).primaryColor,),),
                      SizedBox(width: MediaQuery.of(context).size.width / 25,),
                      NeumorphicButton(
                        onPressed: () {
                          NeumorphicTheme.of(context)?.themeMode = ThemeMode.dark;
                          },
                        style: const NeumorphicStyle(
                          depth: -3,
                          shape: NeumorphicShape.flat,
                          boxShape:
                          NeumorphicBoxShape.circle(),
                        ),
                        padding:  const EdgeInsets.all(12),
                        child: Icon(FontAwesomeIcons.solidMoon,size: 24, color: Theme.of(context).primaryColor,),),
                    ],

                  )
                ],
              ),
            ),
          )),
    );
  }

  showAlertDialog(BuildContext context) {
    // No Button
    Widget cancelButton = NeumorphicButton(
      style: NeumorphicStyle(depth: -5,
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(34)),
        shape: NeumorphicShape.flat,
      ),
      child: Container(
        child: Text("No", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        padding: EdgeInsets.fromLTRB(25, 4, 25, 4),
      ),
      onPressed:  ()async {
        Navigator.pop(context);
      },
    );
    // Yes Button
    Widget continueButton = NeumorphicButton(
      style: NeumorphicStyle(depth: 4,
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(34)),
        shape: NeumorphicShape.flat,
      ),
      child: Container(
        child: Text("Yes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        padding: const EdgeInsets.fromLTRB(25, 4, 25, 4),
      ),
      onPressed:  ()async {
        final prefs = await SharedPreferences.getInstance();
        final success1 = await prefs.remove('username');
        final success2 = await prefs.remove('password');
        final success3 = await prefs.remove('token');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  Username()),
        );
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
          Text("Confirm logout", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actions: [
        cancelButton,
        SizedBox(width:  MediaQuery.of(context).size.width / 30,),
        continueButton,
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



  showAlertDialog2(BuildContext context) {
    // set up the buttons
    Widget closeButton = NeumorphicButton(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(34)),
        shape: NeumorphicShape.flat,
      ),
      child: Container(
        child: Text("Close", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        padding: EdgeInsets.fromLTRB(25, 4, 25, 4),
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
      title: Center(child: Text("Meet our team",style: TextStyle(fontWeight: FontWeight.bold),)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(height: MediaQuery.of(context).size.height / 5.5,
        child: Column(
          children: [
            const Text("Adamsy",style: TextStyle(fontWeight: FontWeight.w400),),
            const SizedBox(height: 20,),
            const Text("AthulReji",style: TextStyle(fontWeight: FontWeight.w400),),
            const SizedBox(height: 20,),
            const Text("JeZwin",style: TextStyle(fontWeight: FontWeight.w400),),
            const SizedBox(height: 20,),
            GestureDetector(onTap: ()async{
              final Uri _url = Uri.parse("https://github.com/adamsyy/Seventy5");
              await launchUrl(_url);
            },child: const Text("'★' Our repository",style: TextStyle(fontWeight: FontWeight.w400),)),
          ],
        ),
      ),
      actions: [

        Center(child: closeButton),
        SizedBox(height: 20,)

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

  showAlertDialog3(BuildContext context) {

    // set up the buttons
    Widget closeButton = NeumorphicButton(
      style: NeumorphicStyle(depth: -5,
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(34)),
        shape: NeumorphicShape.flat,
      ),
      child: Container(
        child: Text("Close", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
      ),
      onPressed:  ()async {
        // Try reading data from the 'counter' key. If it doesn't exist, returns null.
        // Obtain shared preferences.

        Navigator.pop(context);
      },
    );;
    Widget DonateButton = NeumorphicButton(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(34)),
        shape: NeumorphicShape.flat,
      ),
      child: Container(
        child: Text("Donate", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        padding: EdgeInsets.fromLTRB(15, 4, 15, 4),
      ),
      onPressed:  ()async {
        // Try reading data from the 'counter' key. If it doesn't exist, returns null.
        // Obtain shared preferences.

        final url = Uri.parse("https://paytm.business/link/1655497265229/LL_511324784");
        await launchUrl(url);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: const Center(child: Text("Buy us coffee :)",style: TextStyle(fontWeight: FontWeight.bold),)),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      content: const Text(" A huge amount of time and resources goes into building these projects, supporting us will help us to develop further versions of the application with even more features along with suporrt for IOS."),
      actions: [
        closeButton,
        SizedBox(width:  MediaQuery.of(context).size.width / 18,),
        DonateButton,
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

  Future Pay_using_upi() async {
    final url = Uri.parse("https://upi-openkerala.herokuapp.com/adamrubiks@okaxis/"+(50).toString());
    print(url);
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyOTRmMjE3N2Y2ODkxMjkzMWVhNzRjOSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNjU1MTI3MDg0LCJleHAiOjE2NTU5OTEwODR9.o-hznIYVpeoVd7qbg5U__e8ys-qOSqbj-mBJv4-wUUs",
      },

    );
    print(response.body);
  }

}
