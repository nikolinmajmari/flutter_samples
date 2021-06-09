import 'package:bmi_app/result.dart';

import 'widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'constants.dart';

class InputPageViewModel {
  bool male=false;
  bool female=false;
  double height=160;
  int weight = 79;
  int age = 18;
  InputPageViewModel();
  void setHeight(v){
    height=v;
  }
  void _incrWeight(){
      weight++;
  }
  void _incrAge(){
      age++;
  }
  void setGender(gender){
      if(gender==Gender.MALE){
        male=!male;
        female=false;
      }else{
        male=false;
        female=!female;
      }
  }
  double calculateBMI(){
    return weight/((height/100)*(height/100));
  }
}




class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}
enum Gender{MALE,FEMALE}
class _InputPageState extends State<InputPage> {

   InputPageViewModel vm = InputPageViewModel();
   void setheight(double v){
     setState(() {
       vm.height = v.round().ceilToDouble() ;
     });
   }
   void _addWeight(v){
     setState(() {
       vm.weight+=v;
     });
   }
   void _addAge(v){
     setState(() {
       vm.age+=v;
     });
   }
  void setGender(gender){
    setState(() {
      if(gender==Gender.MALE){
        vm.male=!vm.male;
        vm.female=false;
      }else{
        vm.male=false;
        vm.female=!vm.female;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) {

          if(Orientation.landscape == orientation){
            return Scaffold(
              appBar: AppBar(
                title: Text("BMI Calculator"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.bookReader),
                    onPressed: ()=>Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context)=>ResultPage(result: vm.calculateBMI().roundToDouble(),
                              label: "This is a lable",)
                        )
                    ),
                  )
                ],
              ),
              body: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  CardWidget(
                                    colour: vm.male ? kactiveColor:kinactiveColor,
                                    cardchild: IconContent(
                                        icon: FontAwesomeIcons.mars,
                                        label: "Male ",
                                        color: vm.male? ktextActiveColor:ktextPassiveColor
                                    ),
                                    callback: ()=>this.setGender(Gender.MALE),
                                  ),
                                  CardWidget(
                                    colour: vm.female ? kactiveColor:kinactiveColor,
                                    cardchild: IconContent(
                                      icon: FontAwesomeIcons.venus,
                                      label: "Female",
                                      color: vm.female? ktextActiveColor:ktextPassiveColor,
                                    ),
                                    callback: ()=>this.setGender(Gender.FEMALE),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  CardWidget(
                                    colour: kinactiveColor,
                                    cardchild: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text("HEIGHT",style: klabelTextStyle,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: <Widget>[
                                            Text(vm.height.toString(), style: TextStyle(
                                                fontSize: 40,fontWeight: FontWeight.bold,color: ktextPassiveColor
                                            ),),
                                            Text("cm",style: TextStyle(color: ktextPassiveColor),),
                                          ],
                                        ),
                                        SliderTheme(
                                          data: SliderTheme.of(context).copyWith(
                                            overlayColor: Color(0xaaffe8bf),
                                            activeTrackColor:kactiveColor,
                                            inactiveTrackColor: Colors.white,
                                            thumbColor: kactiveColor,
                                          ),
                                          child: Slider(
                                            min: 0,max: 235,
                                            value: vm.height,
                                            onChanged: setheight,

                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            CardWidget(
                                colour: kinactiveColor,
                                cardchild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("AGE",style: klabelTextStyle,),
                                    Text(vm.age.toString(),style: TextStyle(
                                        fontWeight: FontWeight.bold,fontSize: 28,color: ktextPassiveColor
                                    ),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RundIconButton( icon: FontAwesomeIcons.plus,
                                          onPressed: ()=>this._addAge(1),),
                                        RundIconButton( icon: FontAwesomeIcons.minus,
                                          onPressed: ()=>this._addAge(-1),),
                                      ],
                                    )
                                  ],
                                )
                            ),
                            CardWidget(
                                colour: kinactiveColor,
                                cardchild: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Weight",style: klabelTextStyle,),
                                    Text(vm.weight.toString(),style: TextStyle(
                                        fontWeight: FontWeight.bold,fontSize: 28,color: ktextPassiveColor
                                    ),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RundIconButton( icon: FontAwesomeIcons.plus,onPressed: ()=>this._addWeight(1)),
                                        RundIconButton( icon: FontAwesomeIcons.minus,onPressed: ()=>this._addWeight(-1)),
                                      ],
                                    )
                                  ],
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
            ));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("BMI CALCER"),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CardWidget(
                        colour: vm.male ? kactiveColor:kinactiveColor,
                        cardchild: IconContent(
                            icon: FontAwesomeIcons.mars,
                            label: "Male ",
                            color: vm.male? ktextActiveColor:ktextPassiveColor
                        ),
                        callback: ()=>this.setGender(Gender.MALE),
                      ),
                      CardWidget(
                        colour: vm.female ? kactiveColor:kinactiveColor,
                        cardchild: IconContent(
                          icon: FontAwesomeIcons.venus,
                          label: "Female",
                          color: vm.female? ktextActiveColor:ktextPassiveColor,
                        ),
                        callback: ()=>this.setGender(Gender.FEMALE),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CardWidget(
                        colour: kinactiveColor,
                        cardchild: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("HEIGHT",style: klabelTextStyle,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: <Widget>[
                                Text(vm.height.toString(), style: TextStyle(
                                    fontSize: 40,fontWeight: FontWeight.bold,color: ktextPassiveColor
                                ),),
                                Text("cm",style: TextStyle(color: ktextPassiveColor),),
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                overlayColor: Color(0xaaffe8bf),
                                activeTrackColor:kactiveColor,
                                inactiveTrackColor: Colors.white,
                                thumbColor: kactiveColor,
                              ),
                              child: Slider(
                                min: 0,max: 235,
                                value: vm.height,
                                onChanged: setheight,

                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      CardWidget(
                          colour: kinactiveColor,
                          cardchild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("AGE",style: klabelTextStyle,),
                              Text(vm.age.toString(),style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 28,color: ktextPassiveColor
                              ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RundIconButton( icon: FontAwesomeIcons.plus,
                                    onPressed: ()=>this._addAge(1),),
                                  RundIconButton( icon: FontAwesomeIcons.minus,
                                    onPressed: ()=>this._addAge(-1),),
                                ],
                              )
                            ],
                          )
                      ),
                      CardWidget(
                          colour: kinactiveColor,
                          cardchild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Weight",style: klabelTextStyle,),
                              Text(vm.weight.toString(),style: TextStyle(
                                  fontWeight: FontWeight.bold,fontSize: 28,color: ktextPassiveColor
                              ),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RundIconButton( icon: FontAwesomeIcons.plus,onPressed: ()=>this._addWeight(1)),
                                  RundIconButton( icon: FontAwesomeIcons.minus,onPressed: ()=>this._addWeight(-1)),
                                ],
                              )
                            ],
                          )
                      ),
                    ],
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
                          child: Text("press me"),
                          onPressed: ()=>Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context)=>ResultPage(
                                    result: vm.calculateBMI().round().toDouble(),
                                    label: " Result Calculated ",
                                  )
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          );
          },
    );

  }
}


class RundIconButton extends StatelessWidget{
  final IconData icon;

  final Function onPressed;
  RundIconButton({@required this.icon,this.onPressed});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RawMaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      constraints: BoxConstraints.tightFor(
        height: 56,
        width: 56,
      ),
      onPressed:onPressed,
      child: Icon(icon,color: Colors.white,),
      elevation: 6,
      shape: CircleBorder(
      ),
      fillColor: kactiveColor,
    );
  }

}
