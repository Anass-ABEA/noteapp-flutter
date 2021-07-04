// @dart=2.9
import 'package:flutter/material.dart';


class Settings extends StatelessWidget  {

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Go back to previous page',
            ),
            FlatButton(
              child: Text("OK"),
              onPressed: (){
              },
            )
          ],
        ),
      ),
    );
  }
}
