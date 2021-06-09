import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ResultPage extends StatelessWidget{
  final double result ;
  final String label ;
  ResultPage({this.result,this.label});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffffe8bf),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(top: 15,bottom: 0,left: 15,right: 15),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('$result',style: TextStyle(
                      color: Colors.deepOrange,fontSize: 26,fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrange,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: MaterialButton(
                    child: Text("Recalculate"),
                    onPressed: ()=>Navigator.of(context).pop(),
                  ),
                ),
              )
            ],
          )
        ],
      )
    );

  }
}
