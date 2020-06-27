import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';
import 'package:MyFoods/src/models/food_model.dart';
import 'package:http/http.dart' as http;

class FoodModel extends Model
{
  List<Food> _foods = [];

   List<Food> get foods
   {
     return List.from(_foods);
   }

  void addFood(Food food)
  {
    _foods.add(food);
  }

  void fetchFoods()
  {
    http.get("http://192.168.8.101/flutter_food_app/api/foods/getFoods.php").then((http.Response response)
    {
     // print("Fetching data: ${response.body}");
     final List<Food> fetchedFoodItems = [];
      final List fetchedData = json.decode(response.body);
      print(fetchedData);
      fetchedData.forEach((data) {
        Food food = Food(
          id: data["id"],
          category: data["category"],
          discount: double.parse(data["discount"]),
          imagePath: data["imagePath"],
          name: data["name"],
          price: double.parse(data["price"]),
        );
        fetchedFoodItems.add(food);
      });
      _foods = fetchedFoodItems;
      print(_foods);
    });
    
  }
}