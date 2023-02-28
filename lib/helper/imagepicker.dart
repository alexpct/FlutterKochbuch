import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File>imgPicker(bool cam) async{
   File _image ;
  XFile photo;
  final ImagePicker _picker = ImagePicker();
  photo = await _picker.pickImage(source: cam ? ImageSource.camera: ImageSource.gallery);
  if(photo!=null) _image  = File(photo.path);

  return Future<File>.value(_image);

}
