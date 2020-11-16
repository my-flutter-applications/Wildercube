import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/HomePage.dart';
import 'package:buddiesgram/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

class EditProfilePage extends StatefulWidget {
  final String currentOnlineUserId;
  EditProfilePage({this.currentOnlineUserId});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController profileNameTextEditingController =
      TextEditingController();
  TextEditingController bioTextEditingController = TextEditingController();
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  User user;
  bool _bioValid = true;
  bool _profileNameValid = true;

  void initState() {
    super.initState();

    getAndDisplayUserInformation();
  }

  getAndDisplayUserInformation() async {
    setState(() {
      loading = true;
    });

    DocumentSnapshot documentSnapshot =
        await usersReference.document(widget.currentOnlineUserId).get();
    user = User.fromDocument(documentSnapshot);
    profileNameTextEditingController.text = user.profileName;
    bioTextEditingController.text = user.bio;
    setState(() {
      loading = false;
    });
  }

  updateUserData() {
    setState(() {
      profileNameTextEditingController.text.trim().length < 3 ||
              profileNameTextEditingController.text.isEmpty
          ? _profileNameValid = false
          : _profileNameValid = true;

      bioTextEditingController.text.trim().length > 110
          ? _bioValid = false
          : _bioValid = true;

      if (_bioValid && _profileNameValid) {
        usersReference.document(widget.currentOnlineUserId).updateData({
          "profileName": profileNameTextEditingController.text,
          "bio": bioTextEditingController.text,
        });

        SnackBar successSnackBar =
            SnackBar(content: Text('Profile has been updated successfully'));
        _scaffoldGlobalKey.currentState.showSnackBar(successSnackBar);
      }
    });
  }

  logoutUser() async {
    await gSignIn.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.done,
                color: Colors.black,
                size: 30.0,
              ),
              onPressed: () => Navigator.pop(context))
        ],
      ),
      body: loading
          ? circularProgress()
          : ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 7.0),
                        child: CircleAvatar(
                          radius: 52.0,
                          backgroundImage: CachedNetworkImageProvider(user.url),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            createProfileNameTextFormField(),
                            createBioTextFormField()
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 29.0, left: 50.0, right: 50.0),
                        child: RaisedButton(
                          onPressed: updateUserData,
                          child: Text(
                            'Update',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16.0),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 29.0, left: 50.0, right: 50.0),
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          onPressed: logoutUser,
                          child: Text(
                            'Logout',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Column createProfileNameTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Profile Name",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.black),
          controller: profileNameTextEditingController,
          decoration: InputDecoration(
              hintText: "Add profile name here...",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintStyle: TextStyle(color: Colors.grey),
              errorText:
                  _profileNameValid ? null : "Profile name is too short"),
        )
      ],
    );
  }

  Column createBioTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Bio",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.black),
          controller: bioTextEditingController,
          decoration: InputDecoration(
              hintText: "Add bio here...",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              hintStyle: TextStyle(color: Colors.grey),
              errorText: _bioValid ? null : "Bio is too long"),
        )
      ],
    );
  }
}
