import 'dart:io';

import 'package:chataplication/commen_widget/platform_sensitive_alertdialog.dart';
import 'package:chataplication/commen_widget/text_field.dart';
import 'package:chataplication/viewmodel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController namefield = TextEditingController();
  final ImagePicker _imagepicker = ImagePicker();
  File _photoProfile;

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    namefield.text = _userModel.user.userName;
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          RaisedButton.icon(
            label: Text("Çıkış"),
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _userModel.signOut();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            child: Container(
              width: 200,
              height: 200,
              child: CircleAvatar(
                backgroundImage: _photoProfile == null
                    ? NetworkImage(
                        "https://ae01.alicdn.com/kf/H42d716f32e4745ecadd6003cdc91df2an/D-v-sanatlar-sopa-kendini-savunma-k-sa-ubuk-d-v-sanatlar-m-cadele-e-itim.jpg_Q90.jpg_.webp",
                      )
                    : FileImage(_photoProfile),
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Colors.grey,
                      height: 200,
                      child: Column(
                        children: [
                          RaisedButton.icon(
                              label: Text("Galery"),
                              icon: Icon(Icons.image),
                              onPressed: () async {
                                PickedFile pickedFile = await _imagepicker
                                    .getImage(source: ImageSource.gallery);
                                if (pickedFile.path != null) {
                                  setState(() {
                                    _photoProfile = File(pickedFile.path);
                                  });
                                  _userModel.uploadImage(_userModel.user.userId,
                                      "profilphoto", _photoProfile);
                                } else {}
                              }),
                          RaisedButton.icon(
                              label: Text("Camera"),
                              icon: Icon(Icons.camera),
                              onPressed: () async {
                                PickedFile pickedFile = await _imagepicker
                                    .getImage(source: ImageSource.camera);
                                setState(() {
                                  _photoProfile = File(pickedFile.path);
                                });
                              }),
                        ],
                      ),
                    );
                  });
            },
          ),
          TextPart(
            labelText: "Name",
            controller: namefield,
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              "Kaydet",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              await _userModel.updateUserName(
                          _userModel.user.userId, namefield.text) ==
                      true
                  ? showDialog(
                      context: context,
                      builder: (context) => PlatfromAlertDialog(
                            title: "Kullanıcı isim Güncelleme",
                            content: "Kullanıcı Adı Başarıyla Güncellendi",
                            context: context,
                            continueText: "Tamam",
                          ))
                  : showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Başarısız"),
                          ));
            },
          ),
        ],
      ),
    );
  }
}
