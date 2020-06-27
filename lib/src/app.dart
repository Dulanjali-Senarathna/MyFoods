import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'screens/main_screen.dart';
import 'package:MyFoods/src/scoped-model/food_model.dart';

class App extends StatelessWidget
{

 final FoodModel foodModel = FoodModel();

  @override
  Widget build(BuildContext context)
  {
    return ScopedModel<FoodModel>(
      model: FoodModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My Foods",
        theme: ThemeData(primaryColor:Colors.blueAccent),
        home: MainScreen(foodModel:foodModel),
      ),

    );
  }
}