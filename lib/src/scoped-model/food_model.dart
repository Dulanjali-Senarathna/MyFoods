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

  void addFood(Food food) async
  {
    final Map<String,dynamic> foodData = 
    {
      "title" : food.name,
      "description" : food.description,
      "category" : food.category,
      "price" : food.price,
      "discount" : food.discount,
    };
    //_foods.add(food);
    final http.Response response = await http.post("https://myfoods-796ad.firebaseio.com/foods.json", body:json.encode(foodData));

    final Map<String, dynamic> responseData = json.decode(response.body);

    //print(responseData ["name"]);
    Food foodWithID = Food(
      id: responseData["name"],
      name: food.name,
      description: food.description,
      category: food.category,
      discount: food.discount,
      price: food.price,
    );
    
  }

  void fetchFoods()
  {
    http.get("https://myfoods-796ad.firebaseio.com/foods.json").then((http.Response response)
    {
     // print("Fetching data: ${response.body}");
     
      final Map<String,dynamic> fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((String id, dynamic foodData) {
        Food foodItem = Food(
          id: id,
          name: foodData["title"],
          description: foodData ["description"],
          category: foodData ["category"],
          price: foodData ["price"],
          discount: foodData ["discount"],
        );
        foodItems.add(foodItem);
       });
     _foods = foodItems;
     print(_foods);
    });
    
  }
}