
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Cubit/cubit.dart';
import 'package:shop_app/layout/Cubit/status.dart';
import 'package:shop_app/models/home_model.dart';

import '../../Styles/Colors/colors.dart';
import '../../models/categories_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessFavouriteDataState){
          if(!state.model!.status)
            {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.model!.message.toString()),backgroundColor: Colors.green,duration: Duration(milliseconds: 450),));

            }
         // Shopcubit.get(context).;
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: Shopcubit.get(context).homeModel != null &&Shopcubit.get(context).categoriesModel!=null,
            builder: (context) =>
                bannersView(Shopcubit.get(context).homeModel!,Shopcubit.get(context).categoriesModel! , context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  /* Widget ProductBuilder(HomeModel model){
    return Column(
      children: [
        CarouselSlider(
      items: model.data?.banners.map((e) => Expanded(
        child:Container(height: 300,width: double.infinity,
            child: ClipRRect(child: Image.network(element.image,fit: BoxFit.cover,width: double.infinity,),
          borderRadius: BorderRadius.circular(25),)),

    ),
      ),).toList(),
    options: CarouselOptions(
    height: 250,
    initialPage: 0,
    enableInfiniteScroll: true,
    reverse: false,
    autoPlay: true,
    autoPlayInterval: Duration(seconds: 2),
    autoPlayAnimationDuration: Duration(seconds: 1),
    autoPlayCurve: Curves.fastOutSlowIn,
    scrollDirection: Axis.horizontal,
      viewportFraction: 1.0,
    ),

    ),
    ],
    );
  }
}*/
  Widget bannersView(HomeModel model , CategoriesModel modelCat , context) {
    List<Widget> bannersList = [];
    model.data!.banners.forEach((element) {
      bannersList.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
            height: 300,
            width: double.infinity,
            child: ClipRRect(
              child: Image.network(
                element.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              borderRadius: BorderRadius.circular(25),
            )),
      ));
    });
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
            width: 350,
            child: CarouselSlider(
                items: bannersList,
                options: CarouselOptions(
                  autoPlay: true,
                )),
          ),
          SizedBox(
            height: 15,
          ),
          Text("Categories",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          SizedBox(height: 15,),
          Container(
            height: 100,
            child: ListView.separated(
              shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index)=> GestureDetector(child: categoriesInHomeView(modelCat,index),onTap: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryDetails(id: modelCat!.dataAll.dataList[index].id)));
                },), separatorBuilder: (context,index)=>const SizedBox(width: 5,), itemCount: modelCat!.dataAll.dataList.length),
          ),
          SizedBox(height: 15,),
          Text("Products",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          SizedBox(height: 15,),
          Container(
            child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1.2 / 1.6,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(
                  model.data!.products.length,
                  (index) => buildproduct(model.data!.products[index],context),
                )),
          ),
        ],
      ),
    );
  }
  Widget buildproduct(Products model, context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.5, vertical: 0.5),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image.network(model.image),
                    if (model.discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.0),
                        color: Colors.red,
                        child: Text(
                          "DISCOUNT",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      )
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 7),
                  child: Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:12),
                      child: Text(
                        "${model.price.toString()} EGP",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: defaultcolor ,fontSize: 12 ),
                      ),
                    ),
                    model.discount != 0
                        ? Text(
                            model.oldPrice.toString(),
                            style: TextStyle(
                                color: Colors.grey[400],
                                decoration: TextDecoration.lineThrough),
                          )
                        : Text(""),
                    Spacer(),
                    CircleAvatar(
                      backgroundColor:Shopcubit.get(context).isFavorite[model.id]!?defaultcolor:Colors.grey[300],
                      child: IconButton(
                        icon:Icon(Icons.favorite_border,color: Colors.white,), onPressed: () {
                       Shopcubit.get(context).changeFavorite(id: model.id);
                        print(model.id);
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
      );
  Widget categoriesInHomeView(CategoriesModel? model,index){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image.network(model!.dataAll.dataList[index].image,height: 100,width: 120,),
        Container(child: Text(model.dataAll.dataList[index].name,style: TextStyle(color: Colors.white,),textAlign: TextAlign.center,),color: Colors.black38,width: 120,),
      ],);
  }
}
