import 'package:MyFoods/src/widgets/custome_list_tile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget
{
  @override
  _ProfilePageState  createState() => _ProfilePageState();
}

class _ProfilePageState extends State< ProfilePage>{

  bool turnOnNotification = false;
  bool turnOnLocation = false;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold (
      body:SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.symmetric(vertical:50.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
            Text("Profile", style: TextStyle(
              fontSize:32.0,
              fontWeight:FontWeight.bold
            ),),
            SizedBox(height:20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 120.0,
                  width: 120.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.0),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        offset: Offset(0,4.0),
                        color: Colors.black38
                      ),
                    ],
                    image: DecorationImage(
                      image: AssetImage("assets/images/breakfast.jpeg",),
                      fit: BoxFit.cover,
                      ),
                  ),
                  //child: Image.asset("assets/images/breakfast.jpeg",fit: BoxFit.cover,),
                ),
                SizedBox(width:20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [
                    Text("Dulanjali Senarathna", style: TextStyle(fontSize:16.0),),
                    SizedBox(height:10.0),
                    Text("0713725452", style: TextStyle(color:Colors.grey),),
                    SizedBox(height:20.0),
                    Container(
                      height: 25.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:Colors.blue
                        ),
                        
                        borderRadius:BorderRadius.circular(20.0)
                      ),
                      child: Center(child:Text("Edit" , style:TextStyle(color:Colors.blue, fontSize:16.0),),),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height:30.0),
            Text(
            "Account",style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(height:20.0),
            Card(
              elevation: 3.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children:<Widget>[
                    CustomerListTile(
                      icon: Icons.location_on,
                      text: "Location",
                    ),
                    Divider(height: 10.0, color: Colors.grey,),
                    CustomerListTile(
                      icon: Icons.visibility,
                      text: "Change Password",
                    ),
                    Divider(height: 10.0, color: Colors.grey,),
                    CustomerListTile(
                      icon: Icons.shopping_cart,
                      text: "Shipping",
                    ),
                    Divider(height: 10.0, color: Colors.grey,),
                     CustomerListTile(
                      icon: Icons.payment,
                      text: "Payment",
                    ),
                    Divider(height: 10.0, color: Colors.grey,),
                  ],
                ),
                ),
            ),
             SizedBox(height:30.0),
            Text(
            "Notifications",style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(height:20.0),
            Card(
              elevation: 3.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children:<Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                      Text(
                        "App Notifications",
                        style: TextStyle(
                          fontSize:16.0
                        ),
                      ),
                      Switch(
                       value: turnOnNotification,
                       onChanged: (bool value){
                        // print("The value : $value");
                        setState(() {
                          turnOnNotification = value;
                        });
                      },
                       ),
                    ],
                    ),
                    Divider(height: 10.0, color: Colors.grey,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                      Text(
                        "Location Tracking",
                        style: TextStyle(
                          fontSize:16.0
                        ),
                      ),
                      Switch(
                       value: turnOnLocation,
                       onChanged: (bool value){
                        // print("The value : $value");
                        setState(() {
                          turnOnLocation = value;
                        });
                      },
                       ),
                    ],
                    ),
                    Divider(height: 10.0, color: Colors.grey,),
                  ],
                ),
              ),
            ),
             SizedBox(height:30.0),
            Text(
            "Other",style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
            ),
            ),
            SizedBox(height:20.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                    Text("Language", style:TextStyle(fontSize: 16.0),),
                    //SizedBox(height:10.0),
                     Divider(height: 30.0, color: Colors.grey,),
                     Text("Currency", style:TextStyle(fontSize: 16.0),),
                     //SizedBox(height:10.0),
                     Divider(height: 30.0, color: Colors.grey,),
                  ],
                ),
                ),
                 ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}