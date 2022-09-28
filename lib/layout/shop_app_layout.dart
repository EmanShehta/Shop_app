import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/Search/Search.dart';
import 'package:shop_app/shared/Components.dart';

import '../Styles/Colors/colors.dart';
import 'Cubit/cubit.dart';
import 'Cubit/status.dart';


class shop_layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<Shopcubit,ShopStates>
    ( listener: (context,state) {},
    builder: (context,state){
    var cubit =Shopcubit.get(context);
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(
          Icons.add_shopping_cart,color: Colors.white,
        ),
        title: Text("El-Eman",style: TextStyle(color: Colors.black,fontSize: 20),textAlign: TextAlign.start,),
        actions: [
          IconButton(icon: Icon(Icons.search,color: defaultcolor,),onPressed: (){
             navigateTo(context, Search());
          },),
        ],
      ),
    body: Shopcubit.get(context).Screens[Shopcubit.get(context).indexBottomNavBar],
    floatingActionButton: FloatingActionButton(onPressed: () {
    //Navigator.push(context, MaterialPageRoute(builder: (context){}));
    },child: Icon(Icons.shopping_cart),backgroundColor: defaultcolor,),
    floatingActionButtonLocation :FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: AnimatedBottomNavigationBar(
    icons: [
    Icons.home,
    Icons.menu,
    Icons.favorite_border,
    Icons.settings,
    ],
    activeIndex: Shopcubit.get(context).indexBottomNavBar,
    onTap: (x){
    Shopcubit.get(context).changeIndexBottom(x);
    },
    activeColor: defaultcolor,
    gapLocation: GapLocation.center,
    notchSmoothness: NotchSmoothness.softEdge,
    leftCornerRadius: 32,
    rightCornerRadius: 32,
    ),
    );
    },
    );
  }
  }
