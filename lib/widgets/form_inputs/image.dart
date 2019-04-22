import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  void _getImage(ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400.0).then((File image) {
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker() {
    final textColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an Image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                FlatButton(
                  textColor: textColor,
                  child: Text('Use Camera'),
                  onPressed: () {
                    _getImage(ImageSource.camera);
                  },
                ),
                FlatButton(
                  textColor: textColor,
                  child: Text('Use Gallery'),
                  onPressed: () {
                    _getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).primaryColor;
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(color: buttonColor, width: 2.0),
          onPressed: _openImagePicker,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.camera_alt, color: buttonColor),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Add image',
                style: TextStyle(color: buttonColor),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _imageFile == null
            ? Text('Please pick an image.')
            : Image.file(
                _imageFile,
                fit: BoxFit.cover,
                height: 300.0,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
              ),
      ],
    );
  }
}
