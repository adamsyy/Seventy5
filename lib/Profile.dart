import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:seventy5/username.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  Profile({required this.username,required this.token,required this.class_name});
  late String username;
 late String token;
  late String class_name;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // late Razorpay razorpay;
  //
  // @override
  // void initState() {
  //
  //   super.initState();
  //   razorpay=Razorpay();
  //   razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
  //   razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerPaymentError);
  //   razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  // }
  // @override
  // void dispose() {
  //
  //   super.dispose();
  //   razorpay.clear();
  // }
  // void openCheckout(){
  //   var options={
  //     "key":"rzp_test_KRIbh5kOB96e8q",
  //     "amount":"100",
  //     "name":"The Hanger",
  //     "description":"Fastest Payment Method",
  //     "prefill":{
  //       "contact":"7559076475",
  //       "email": "adamrubiks@gmail.com",
  //     },
  //     "external":{
  //       "wallets":["paytm"],
  //
  //     }
  //   };
  //   try{
  //     razorpay.open(options);
  //   }
  //   catch(e){
  //     print(e.toString());
  //   }
  //
  // }
  //
  //
  // void handlerPaymentSuccess(){
  //   print('success aayye');
  // }
  //
  // void handlerPaymentError(){
  //   print('error aai');
  // }
  //
  // void handlerExternalWallet(){
  //   print('external aaye');
  // }

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
                      MediaQuery.of(context).size.width / 3000,
                      MediaQuery.of(context).size.height / 6,
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
                  child: Text(widget.username.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding:EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width / 16,
                     5,
                      0,
                      0),
                  child: Text(widget.class_name),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                      margin: EdgeInsets.only(top: 15),

                      onPressed: () {

                        showAlertDialog2(context);


                        NeumorphicTheme.of(context)?.themeMode =

                            ThemeMode.dark;
                      },
                      style: NeumorphicStyle(
                        depth: -3,
                        color:Colors.grey[300],
                        shape: NeumorphicShape.concave,
                        boxShape:
                        NeumorphicBoxShape.circle(),
                      ),
                      padding:  const EdgeInsets.fromLTRB(14, 12, 12, 12),
                      child: Icon(FontAwesomeIcons.peopleGroup,size: 24,),),
SizedBox(width: 20,),
                    NeumorphicButton(
                      margin: EdgeInsets.only(top: 15),

                      onPressed: () async{

                        showAlertDialog3(context);
                     //.   openCheckout();

                        NeumorphicTheme.of(context)?.themeMode =

                            ThemeMode.dark;
                      },
                      style: NeumorphicStyle(
                        depth: -3,
                        color:Colors.grey[300],
                        shape: NeumorphicShape.concave,
                        boxShape:
                        NeumorphicBoxShape.circle(),
                      ),
                      padding:  const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Icon(FontAwesomeIcons.coffee,size: 24,),),
                    SizedBox(width: 20,),
                    NeumorphicButton(
                      margin: EdgeInsets.only(top: 15),

                      onPressed: () {

                        showAlertDialog(context);


                        NeumorphicTheme.of(context)?.themeMode =

                            ThemeMode.dark;
                      },
                      style: NeumorphicStyle(
                        depth: -3,
                        color:Colors.grey[300],
                        shape: NeumorphicShape.concave,
                        boxShape:
                        NeumorphicBoxShape.circle(),
                      ),
                      padding:  const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Icon(FontAwesomeIcons.calendar,size: 24,),),
                  ],

                )
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
        child: Text("cancel"),
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
        child: Text("sign out"),
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



  showAlertDialog2(BuildContext context) {

    // set up the buttons
    Widget cancelButton = NeumorphicButton(

      style: NeumorphicStyle(depth: 2,
        boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(15)),
        color:  Colors.grey[300],
        shape: NeumorphicShape.flat,

      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text("cancel",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      onPressed:  ()async {
        // Try reading data from the 'counter' key. If it doesn't exist, returns null.
        // Obtain shared preferences.

        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Center(child: Text("Meet our team",style: TextStyle(fontWeight: FontWeight.bold),)),
      backgroundColor: Colors.grey[300],
      content: Container(height: MediaQuery.of(context).size.height / 5.5,
        child: Column(
          children: [
            Text("  Adamsy",style: TextStyle(fontWeight: FontWeight.w400),),
            SizedBox(height: 20,),
            Text("  AthulReji",style: TextStyle(fontWeight: FontWeight.w400),),
            SizedBox(height: 20,),
            Text("  JeZwin",style: TextStyle(fontWeight: FontWeight.w400),),
            SizedBox(height: 20,),
            GestureDetector(onTap: ()async{
              final Uri _url = Uri.parse("https://github.com/adamsyy/Seventy5");
              await launchUrl(_url);
            },child: Text("'★' Our repository",style: TextStyle(fontWeight: FontWeight.w400),)),
          ],
        ),
      ),
      actions: [

        Center(child: cancelButton),
        SizedBox(height: 20,)

      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Neumorphic(child: alert,
          style: NeumorphicStyle(
            color:Colors.grey[300],
            shape: NeumorphicShape.concave,
              boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(30))
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



  showAlertDialog3(BuildContext context) {

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
        child: Text("cancel"),
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
        child: Text("Donate"),
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
      backgroundColor: Colors.grey[300],
      content: Text(" A huge amount of time and resources goes into building these projects, supporting us will help us to develop further versions of the application with even more features along with suporrt for IOS."),
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



}
