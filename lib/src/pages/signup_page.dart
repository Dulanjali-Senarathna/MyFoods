import 'package:flutter/material.dart';
import '../pages/signin_page.dart';

class SignUpPage extends StatefulWidget
{
  @override
  _SignUpPageState  createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{

  bool _toggleVisibility = true;
  bool _toggleConfirmVisibility = true;

  Widget _buildEmailTextField()
  {
    return TextField(
      decoration: InputDecoration(
        hintText:"Email",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,

        )
      ),
    );
  }

  Widget _buildUsernameTextField()
  {
    return TextField(
      decoration: InputDecoration(
        hintText:"Username",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,

        )
      ),
    );
  }

  
  Widget _buildPasswordTextField()
  {
    return TextField(
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
    );
  }

  Widget _buildConfirmPasswordTextField()
  {
    return TextField(
      decoration: InputDecoration(
        hintText:"Confirm Password",
        hintStyle: TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: ()
          {
            setState(() {
              _toggleConfirmVisibility = !_toggleConfirmVisibility;
            });
          },
          icon:_toggleConfirmVisibility ? Icon(Icons.visibility_off) : Icon(Icons.visibility) ,
        ),
      ),
      obscureText:_toggleConfirmVisibility,
    );
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      resizeToAvoidBottomPadding:false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:10.0),
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
                         SizedBox(height:20.0),
                          _buildConfirmPasswordTextField(),
                      ]
                    ),
                  ),
                ),
                SizedBox(height:30.0),
                Container(
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
    );
  }
}