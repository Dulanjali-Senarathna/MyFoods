import 'package:MyFoods/src/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserModel extends Model
{
  User _authenticatedUser;
  bool _isLoading= false;

  User get authenticatedUser
  {
    return _authenticatedUser;
  }

  bool isLoading()
  {
    return _isLoading;
  }

  Future<Map<String,dynamic>> authenticate(String email, String password) async
  {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> authData = 
    {
      "email": email,
      "password" : password,
      "returnSecureToken" : true,
    };
    String message;
    bool hasError= false;
    try
    {
      http.Response response = await http.post(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDbYos1t5GwqPkXWn57UR5RRFVsqLQ0-bo", 
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
      );

      Map <String,dynamic> responseBody = json.decode(response.body);

      print("The response body again: $responseBody");

     if(responseBody.containsKey('idToken'))
     {
        _authenticatedUser = User(
        id: responseBody['localId'],
        email: responseBody['email'],
        token: responseBody['idToken'],
        userType: 'customer',
         );
         message = "Sign in successfully";

     }
     else
     {
       if(responseBody['error']['message'] == 'EMAIL_EXISTS')
       {
         hasError = true;
         message = "Email is already exists";
         //print("The email already exists");
       }
     }
      _isLoading = false;
      return {
        'message' : message,
        'hasError' : hasError,
      };
      
     

    }catch(error)
    {
       _isLoading = false;
      notifyListeners();
      
      return 
      {
        'message' : 'Failed to sign up successfully',
        'hasError' : !hasError,
      };
    }
  }
  
}