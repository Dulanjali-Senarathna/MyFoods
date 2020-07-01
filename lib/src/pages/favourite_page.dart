import 'package:MyFoods/src/models/food_model.dart';
import 'package:MyFoods/src/scoped-model/main_model.dart';
import 'package:MyFoods/src/widgets/food_item_card.dart';
import 'package:MyFoods/src/widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class FavouritePage extends StatefulWidget
{
  final MainModel model;

  FavouritePage({this.model});
  @override
  _FavouritePageState  createState() => _FavouritePageState();
}

class _FavouritePageState extends State< FavouritePage>{

@override
  void initState() {
   
    super.initState();
    widget.model.fetchFoods();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: ScopedModelDescendant <MainModel>(
          builder: (BuildContext context, Widget child, MainModel model)
          {
            model.fetchFoods();//this will fetch and notifylisteners()
            List<Food> foods = model.foods;
            return Container(
              padding: EdgeInsets.symmetric(horizontal:20.0),
          child: RefreshIndicator(
            onRefresh: model.fetchFoods,
          child: ListView(
          children: foods.map((Food food)
          {
              return FoodItemCard(
                food.name,
                food.description,
                food.price.toString(),
              );
          }).toList(),
    ),
                          ),
            );
          },
        )
    );
  }
}

// Container(
//         color: Colors.white,
//         padding: EdgeInsets.symmetric(horizontal:16.0),
//         child: ScopedModelDescendant <MainModel>(
//           builder: (BuildContext context, Widget child, MainModel model)
//           {
//             model.fetchFoods();
//             List<Food> foods = model.foods;
//             return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: foods.map((Food food)
//           {
//             return FoodItemCard(
//               food.name,
//               food.description,
//               food.price.toString(),
//             );
//           }).toList(),
//     );
//           },
//         ),
//       ),