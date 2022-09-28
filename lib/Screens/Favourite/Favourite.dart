import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Styles/Colors/colors.dart';
import 'package:shop_app/layout/Cubit/cubit.dart';
import 'package:shop_app/layout/Cubit/status.dart';

import '../../models/fav_model.dart';

class Favorites extends StatelessWidget {
Widget favoriteLoad = Icon(
  Icons.favorite_border,
  color: Colors.white,
);

@override
Widget build(BuildContext context) {
  return BlocProvider.value(
    value: BlocProvider.of<Shopcubit>(context)..getFavorite(),
    child: BlocConsumer<Shopcubit, ShopStates>(
        builder: (context, state) =>
        Shopcubit.get(context).getFavoritesModel == null
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        )
            : Shopcubit.get(context)
            .getFavoritesModel!
            .data
            .data
            .isEmpty
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "There is no product in your favourite try add some",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: defaultcolor,
                    fontSize: 20),
              ),
            ),
          ],
        )
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Container(
            color: Colors.grey[200],
            child: GridView.count(
              crossAxisCount: 1,
              children: List.generate(
                  Shopcubit.get(context)
                      .getFavoritesModel!
                      .data
                      .data
                      .length,
                      (index) => productsFavView(
                      Shopcubit.get(context)
                          .getFavoritesModel,
                      index,
                      Shopcubit.get(context).isFavorite,
                      context)),
            ),
          ),
        ),
        listener: (context, state) {
          if (state is ShopSuccessFavouriteDataState) {
            Shopcubit.get(context).getFavorite();
          /*  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state!.model!.message),
              backgroundColor: Colors.green,
              duration: Duration(milliseconds: 450),
            ));*/
          }
        }),
  );
}
}
  Widget productsFavView(FavoriteGetModel? model, index, Map<int, bool> fav,
      context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.5),
      child: GestureDetector(
        onTap: () {
          /* Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(
              model!
                  .data
                  .data[index].product.id)));*/
        },
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Expanded(
                    child:
                    Image.network(model!.data.data[index].product.image)),
                Text(model.data.data[index].product.name),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "${model.data.data[index].product.price
                            .toString()} EGP",
                        style: TextStyle(color: defaultcolor),
                      ),
                    ),
                    model.data.data[index].product.discount != 0
                        ? Text(
                      model.data.data[index].product.oldPrice.toString(),
                      style: TextStyle(
                          color: Colors.grey[400],
                          decoration: TextDecoration.lineThrough),
                    )
                        : Text(""),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor:
                      fav[model.data.data[index].product.id] ?? false
                          ? Colors.purple
                          : Colors.grey[300],
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Shopcubit.get(context).changeFavorite(id:model.data.data[index].product.id);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
