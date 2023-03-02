  ///
import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File>imgPicker(bool cam) async{
   File image ;
  XFile photo;
  final ImagePicker picker = ImagePicker();
  photo = await picker.pickImage(source: cam ? ImageSource.camera: ImageSource.gallery);
  if(photo!=null) image  = File(photo.path);

  return Future<File>.value(image);

}
