import 'package:flutter/material.dart';

AppBar header(context,
    {bool isAppTitle = false,
    String strTitle,
    bool disappearedButton = false}) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black),

    // if theres a button, it wont lead automatically, if no button, it will lead automatically

    automaticallyImplyLeading: disappearedButton ? false : true,
    title: Text(
      isAppTitle ? 'Wildercube' : strTitle,
      style: TextStyle(
        color: Colors.black,
        fontFamily: isAppTitle ? 'Nunito' : '',
        fontSize: isAppTitle ? 45.0 : 22.0,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
    backgroundColor: Colors.white,
  );
}
