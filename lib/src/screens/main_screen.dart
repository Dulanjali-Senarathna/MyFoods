import 'package:MyFoods/src/pages/favourite_page.dart';
import 'package:MyFoods/src/pages/profile_page.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/order_page.dart';

class MainScreen extends StatefulWidget
{
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
    
    super.initState();
    homePage = HomePage();
    orderPage = OrderPage();
    favouritePage = FavouritePage();
    profilePage = ProfilePage();

    pages = [HomePage(),OrderPage(), FavouritePage(), ProfilePage()]; //Array of pages

    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
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
            icon: Icon(Icons.shopping_cart),
             title: Text("Orders")
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text("Favourites")
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
             title: Text("Profile")
            ),
        ],
      ),
      body: currentPage,
    );
  }
}