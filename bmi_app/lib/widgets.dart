import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';






class CardWidget extends StatelessWidget {
  final Color colour;
  final Widget cardchild;
  final Function callback;
  const CardWidget({this.colour,this.cardchild,this.callback});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: callback,
        child: Container(
          child: cardchild,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color:this.colour,
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}

class IconContent extends StatelessWidget {
  final IconData icon;

  final String label;

  final Color color;

  const IconContent({this.icon, this.label,this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 80,
          color: color,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 22, color: color,)
        )
      ],
    );
  }
}