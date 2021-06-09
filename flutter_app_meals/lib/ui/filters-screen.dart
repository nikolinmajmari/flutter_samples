import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const String ROUTE="/filters-screen";

  final Function callback;

  Map<String,bool> initial;
  FiltersScreen(this.callback,this.initial);
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  bool _gluitenFree ;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  void initState(){
    _gluitenFree=widget.initial['gluten'];
    _lactoseFree = widget.initial['lactose'];
    _vegan= widget.initial['vegan'];
    _vegetarian = widget.initial['vegetarian'];
    super.initState();
  }

  _buildSwitchListTile(String title,String discription, bool currrentValue,Function update){
     return SwitchListTile(
       title: Text(title),
       subtitle: Text(discription),
       value: currrentValue,
       onChanged:(val)=>this.setState(()=>update(val)),
     );
  }

  _updateGluiten(value)=>_gluitenFree=value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Filter Settings"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
              var filters = {
                'gluten':_gluitenFree,
                'lactose':_lactoseFree,
                'vegan':_vegan,
                'vegetarian':_vegetarian
              };
              widget.callback(filters);
              Navigator.pop(context);
            },
          )
        ],
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(" Adjust your meal selection",style: Theme.of(context).textTheme.title,),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile("Gluten-Free", "only include glutin free meals", _gluitenFree,(x)=>_gluitenFree=x),
                _buildSwitchListTile("Vegetarian", "only include glutin free meals", _vegetarian, (x)=>_vegetarian=x),
                _buildSwitchListTile("Vegan-Free", "only include glutin free meals", _vegan,  (x)=>_vegan=x),
                _buildSwitchListTile("Lactose-Free", "only include glutin free meals", _lactoseFree, (x)=>_lactoseFree=x),
              ],
            ),
          )
        ],
      ),
    );
  }
}
