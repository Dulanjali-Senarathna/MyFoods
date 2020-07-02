import 'package:MyFoods/src/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserModel extends Model
{
  User _authenticatedUser;

  void authenticate(String email, String password) async
  {
    Map<String, dynamic> authData = 
    {
      "email": email,
      "password" : password,
      "returnsecureToken" : true,
    };
    try
    {
      http.Response response = await http.post("https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyDbYos1t5GwqPkXWn57UR5RRFVsqLQ0-bo", body: json.encode(authData),
      headers: {'Content-Type':'application/json'},
      );

      print("Printing the response body : ${response.body}");
    }catch(error)
    {
      print("The error in signin up: $error");
    }
  }
  
}