import 'package:MyFoods/src/enums/auth_model.dart';
import 'package:MyFoods/src/scoped-model/main_model.dart';
import 'package:MyFoods/src/widgets/button.dart';
import 'package:MyFoods/src/widgets/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../pages/signin_page.dart';

class SignUpPage extends StatefulWidget
{
  @override
  _SignUpPageState  createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{

  bool _toggleVisibility = true;
  //bool _toggleConfirmVisibility = true;

  String _email, _password,_username;

  GlobalKey <FormState> _formKey  = GlobalKey();
   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Widget _buildEmailTextField()
  {
    return TextFormField(
      decoration: InputDecoration(
        hintText:"Email",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,

        )
      ),
      onSaved: (String email)
      {
        _email = email;
      },
      validator: (String email)
      {
        String errorMessage;
        if(!email.contains("@"))
        {
        errorMessage = "Your email is incorrect";
        }
        if(email.isEmpty)
        {
          errorMessage = "Email is required";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildUsernameTextField()
  {
    return TextFormField(
      decoration: InputDecoration(
        hintText:"Username",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,

        )
      ),
      onSaved: (String username)
      {
        _username = username.trim();
      },
      validator: (String username)
      {
        String errorMessage;
        if(username.isEmpty)
        {
          errorMessage = "User name field is required";
        }
        return errorMessage;
      },
    );
  }

  
  Widget _buildPasswordTextField()
  {
    return TextFormField(
      decoration: InputDecoration(
        hintText:"Password",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: ()
          {
            setState(() {
              _toggleVisibility = ! _toggleVisibility;
            });
          },
          icon: _toggleVisibility ? Icon(Icons.visibility_off) : Icon(Icons.visibility) ,
        ),
      ),
      obscureText: _toggleVisibility,
     onSaved: (String password)
     {
       _password = password;
     },
     validator: (String password)
     {
        String errorMessage;
        if(password.isEmpty)
        {
          errorMessage = "Password is required";
        }
        return errorMessage;
     },
    );
  }

  // Widget _buildConfirmPasswordTextField()
  // {
  //   return TextFormField(
  //     decoration: InputDecoration(
  //       hintText:"Confirm Password",
  //       hintStyle: TextStyle(
  //         color: Color(0xFFBDC2CB),
  //         fontSize: 18.0,
  //       ),
  //       suffixIcon: IconButton(
  //         onPressed: ()
  //         {
  //           setState(() {
  //             _toggleConfirmVisibility = !_toggleConfirmVisibility;
  //           });
  //         },
  //         icon:_toggleConfirmVisibility ? Icon(Icons.visibility_off) : Icon(Icons.visibility) ,
  //       ),
  //     ),
  //     obscureText:_toggleConfirmVisibility,
  //      onSaved:( String value)
  //     {

  //     },
  //   );
  // }
  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
          child: Scaffold(
            key: _scaffoldKey,
        resizeToAvoidBottomPadding:false,
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal:10.0),
          child: Form(
            key: _formKey,
                    child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Text(
                  "Sign Up", 
                  style: TextStyle(
                    fontSize: 40.0, 
                    fontWeight: FontWeight.bold,
                    ),
                    ),
                    SizedBox(height:50.0),
                  Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                          child: Column(
                          children: <Widget>[
                             _buildUsernameTextField(),
                              SizedBox(height:20.0),
                            _buildEmailTextField(),
                            SizedBox(height:20.0),
                            _buildPasswordTextField(),
                          ]
                        ),
                      ),
                    ),
                    SizedBox(height:30.0),
                    _buildSignUpButton(),
                    Divider(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children :<Widget>[
                        Text("Allready have an account?",  style: TextStyle(fontSize:18.0, color:Color(0xFFBDC2CB), fontWeight:FontWeight.bold),),
                        SizedBox(width:10.0),
                        GestureDetector( 
                          onTap:(){
                             Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context ) => SignInPage()));
                          },
                          child: Text(
                          "Sign In",  style: TextStyle(fontSize:18.0, color:Colors.blueAccent, fontWeight:FontWeight.bold),
                          ),
                          ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildSignUpButton()
  {
    return ScopedModelDescendant(
      builder: (BuildContext sctx, Widget child, MainModel model)
      {
        return GestureDetector(
      onTap: ()
      {
        showLoadingIndicator(context, "Signin up..");
        onSubmit(model.authenticate);
      },
          child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Center(
                      child:Text("Sign Up",
                      style: TextStyle(
                      color:Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                      ),),
                    ),
                  ),
    );
      }
    );
  }
  void onSubmit(Function authenticate)
  {
    if(_formKey.currentState.validate())
    {
      _formKey.currentState.save();

      print("The email : $_email, The password: $_password");
      authenticate(_email,_password, authMode: AuthMode.SignUp).then((final response){
        Navigator.of(context).pop();
        if(!response['hasError'])
        {
         Navigator.of(context).pop();
          Navigator.of(context).pushNamed('/mainscreen');
        }
        else
        {
          Navigator.of(context).pop();
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              duration: Duration(seconds:2),
              backgroundColor: Colors.red,
              content: Text(response['message']),
            ),
          );
        }
      });
    }
  }
}