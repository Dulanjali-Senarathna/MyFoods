import 'package:MyFoods/src/enums/auth_model.dart';
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

  bool get isLoading
  {
    return _isLoading;
  }

  Future<Map<String,dynamic>> authenticate(String email, String password, {AuthMode authMode = AuthMode.SignIn}) async
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
       http.Response response;
      if(authMode == AuthMode.SignUp)
      {
        response = await http.post(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDbYos1t5GwqPkXWn57UR5RRFVsqLQ0-bo", 
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
      );

      }else if(authMode == AuthMode.SignIn)
      {
         response = await http.post(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDbYos1t5GwqPkXWn57UR5RRFVsqLQ0-bo", 
      body: json.encode(authData),
      headers: {'Content-Type': 'application/json'},
      );
      }
     
      Map <String,dynamic> responseBody = json.decode(response.body);

     if(responseBody.containsKey('idToken'))
     {
        _authenticatedUser = User(
        id: responseBody['localId'],
        email: responseBody['email'],
        token: responseBody['idToken'],
        userType: 'customer',
         );

         if(authMode == AuthMode.SignUp)
         {
            message = "Sign up successfully";
         }
         else
         {
            message = "Sign in successfully";
         }
         
     }
     else
     {
       hasError = true;
       if(responseBody['error']['message'] == 'EMAIL_EXISTS')
       {
         message = "Email is already exists";
         //print("The email already exists");
       }
       else if(responseBody['error']['message'] == "EMAIL_NOT_FOUND")
         {
           message = "Email does not exist";
         }
         else if(responseBody['error']['message'] == "INVALID_PASSWORD")
         {
           message = "Password is incorrect";
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