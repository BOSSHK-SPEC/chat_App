import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class newDashBoard extends StatefulWidget {


  @override
  State<newDashBoard> createState() => _newDashBoard();
}
class _newDashBoard extends State<newDashBoard> {
  // ···
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(

          padding: const EdgeInsets.all(0),
          child:Text("Hii"),
        ),
        SizedBox(

          width: 18,
          child: SizedBox(
            child: Text('Hii'),
          ),
        ),
      ],
    );
  }
}