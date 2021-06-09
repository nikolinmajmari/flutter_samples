import 'package:flutter/material.dart';
import 'package:flutter_shop_app/form/form_product.dart';
import 'package:flutter_shop_app/providers/product.dart';
import 'package:flutter_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const ROUTE = "/edit-product";
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  int _viewState;
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var product = FormProduct(
    id: null,
    price: 1,
    title: "aaaaaaaaaaaaaa",
    description: "aaaaaaaaaaaaaaaa",
    imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/What_Is_URL.jpg/800px-What_Is_URL.jpg",
    isFavorite: false
  );
  var isInit = false;
  // -- helper functions --//
  void _saveForm(BuildContext context){
    bool isValid = _form.currentState.validate();
    if(isValid) {
      setState(() {
        _viewState = 1;
        print(_viewState);
      });
      _form.currentState.save();
      print(product.toString());
      if (product.id != null) {
        Provider.of<ProductsProvider>(context, listen: false).updateProduct(
            product.id, product.getProduct()).catchError(
                (error){
              showDialog(
                  context: context,
                  builder: (ctx)=>
                      AlertDialog(
                        title: Text("Shop App"),
                        content: Text("Error on waiting for firebase response"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("okay"),
                            onPressed: ()=>Navigator.of(context).pop(),
                          )
                        ],
                      )
              );
            }
        ).whenComplete((){
          Navigator.of(context).pop();
          setState(() {
            _viewState = 0;
          });
        });
      }
      else
        {Provider.of<ProductsProvider>(context, listen: false).addProduct(
            this.product.getProduct()).catchError((error){
              showDialog(
                context: context,
                builder: (ctx)=>
                    AlertDialog(
                      title: Text("Shop App"),
                      content: Text("Error on waiting for firebase response"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("okay"),
                          onPressed: ()=>Navigator.of(context).pop(),
                        )
                      ],
                    )
              );
        }
        ).whenComplete(() {
          print("Complete");
          Navigator.of(context).pop();
          setState(() {
            _viewState = 0;
          });
        });
        }
    }
    else {
      print("not valid");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("building stack from $_viewState");
    return Scaffold(
      appBar: AppBar(
        title: Text('Edtit product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save,color: Colors.white,),
            onPressed: (){
              _saveForm(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
        child: IndexedStack(
          index: _viewState,
          children: <Widget>[
            Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    initialValue: product.title,
                    decoration: InputDecoration(
                      labelText: "Title",
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_){
                      print(_);
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value){
                      product.title= value;
                    },
                    validator: (value){
                      if(value.isEmpty)
                        return "Please enter a Title";
                      else if(value.length<5)
                        return "title must be at least 10 characters";
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: product.price.toString(),
                    decoration: InputDecoration(
                      labelText: "Price",
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value)=>product.price = double.parse(value) ,
                    validator: (value){
                      if(value.isEmpty)
                        return "Please enter a price";
                      else if(double.tryParse(value)==null)
                        return "Please enter a valid number";
                      else if(double.parse(value)<0)
                        return "Please enter a price >= than 0";
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: product.description,
                    decoration: InputDecoration(
                      labelText: "Description",
                    ),
                    maxLines: 3,
                    focusNode: this._descriptionFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value)=>product.description = value,
                    validator: (value){
                      if(value.isEmpty)
                        return "Please enter a Title";
                      else if(value.length<10)
                        return "description must be at least 10 characters";
                      return null;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.pink,width: 1)
                          ),
                          child: _imageUrlController.text.isNotEmpty?
                          FittedBox(
                              child: Image.network(_imageUrlController.text,fit: BoxFit.cover,)
                          ):Container(
                            color: Colors.pinkAccent.withOpacity(0.5),
                          )
                      ),
                      Expanded(
                        child: TextFormField(
                          focusNode: _imageUrlFocusNode,
                          controller: _imageUrlController,
                          decoration: InputDecoration(labelText: "Image Url"),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (val)=>_saveForm(context),
                          onSaved: (value)=>product.imageUrl = value,
                          validator: (value){
                            if(value.isEmpty) return "Please enter an image";
                            if((!value.startsWith("http"))&&(!value.startsWith("https")))
                              return "Please enter a valid url ";
                            if((!value.endsWith(".png"))&&(!value.endsWith(".jpg"))&&(!value.endsWith(".jpeg"))&&(!value.endsWith(".gif")))
                              return "Error";
                            return null;
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Center(
              child: CircularProgressIndicator(backgroundColor: Theme.of(context).primaryColorLight,),
            )
          ],
        ),
      ),
    );
  }

  //------------------Listeners--
  void _updateImageUrl(){
    if(!_imageUrlFocusNode.hasFocus){
      final value = _imageUrlController.text;
      if((!value.startsWith("http"))&&(!value.startsWith("https")))
        return;
      if((!value.endsWith(".png"))&&(!value.endsWith(".jpg"))&&(!value.endsWith(".jpeg"))&&(!value.endsWith(".gif")))
        return;
      setState(() {
      });
    }
  }
  //---------------------------

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(!isInit){
      final pid = ModalRoute.of(context).settings.arguments as String;
      if(pid==null)
        {
          print("no id");
          return;
        }
      final p = Provider.of<ProductsProvider>(context,listen: false).findById(pid);
      if(p!=null){
        product = FormProduct(
          id: p.id,
          price: p.price,
          title: p.title,
          description: p.description,
          imageUrl: p.imageUrl,
          isFavorite: p.isFavorite
        );
        _imageUrlController.text = product.imageUrl;
      }
      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    // TODO: implement initState
    _viewState = 0;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    this._imageUrlController.dispose();
    this._descriptionFocusNode.dispose();
    this._priceFocusNode.dispose();
    super.dispose();
  }
}
