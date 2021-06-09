import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
class ImageInput extends StatefulWidget {
  final Function notifier;

  const ImageInput({Key key, this.notifier}) : super(key: key);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;
  final picker = ImagePicker();

  Future<void> _takeImage() async {
    // get the image from the cameraroll
    final img = await picker.getImage(source: ImageSource.camera, maxWidth: 400);
    // check if the image was got sucessfully
    if(img == null)
      return;//return if no image taken

    _image = File(img.path);                                           // convert to file
    final appDir = await syspath.getApplicationDocumentsDirectory();   // get app dir
    String fname = path.basename(img.path);                            // get filename
    final savedImage =
        await _image.copy("${appDir.path}${path.separator}$fname");    // await img to save in machine

    setState(() {
      print("saving image");
      print(savedImage.toString());
    });
    widget.notifier(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1, color: Theme.of(context).primaryColorLight)),
          child: _image == null
              ? Text("no image",style: TextStyle(color:  Theme.of(context).primaryColorLight),)
              : Image.file(
                  _image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: FlatButton.icon(
              onPressed: () {
                _takeImage();
              },
              icon: Icon(Icons.camera,color:  Theme.of(context).primaryColorDark,),
              label: Text("Pick an Image",style: TextStyle(color:  Theme.of(context).primaryColor),)),
        )
      ],
    );
  }
}
