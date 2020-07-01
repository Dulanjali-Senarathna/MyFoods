import 'package:MyFoods/src/admin/pages/add_food_item.dart';
import 'package:MyFoods/src/pages/favourite_page.dart';
import 'package:MyFoods/src/pages/profile_page.dart';
import 'package:MyFoods/src/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/order_page.dart';


class MainScreen extends StatefulWidget
{

final MainModel model;

MainScreen({this.model});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{

int currentTabIndex = 0;

List <Widget> pages;
Widget currentPage;

HomePage homePage;
OrderPage orderPage;
FavouritePage favouritePage;
ProfilePage profilePage;

@override
  void initState() {
    
    //call the fetch method on food
    //widget.foodModel.fetchFoods();
    widget.model.fetchFoods();
    
    homePage = HomePage();
    orderPage = OrderPage();
    favouritePage = FavouritePage();
    profilePage = ProfilePage();

    pages = [homePage, favouritePage,orderPage, profilePage]; //Array of pages

    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.white,
          elevation:0,
          iconTheme: IconThemeData(color:Colors.black),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: ()
                {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => AddFoodItem())
                  );
                },
                leading:Icon(Icons.list),
                title: Text("Add Food Item", style:TextStyle(fontSize: 16.0)),

              )
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            setState(() {
              currentTabIndex = index;
              currentPage = pages[index];
            });
          },
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text("Explore")
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
               title: Text("Orders")
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
               title: Text("Profile")
              ),
          ],
        ),
        body: currentPage,
      ),
    ); 
  }
}