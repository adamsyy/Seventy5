import 'package:flutter/material.dart';

class second extends StatelessWidget {
  const second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Image(
          image: AssetImage('assets/second.jpg'),
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context,);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}