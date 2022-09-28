

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Cubit/status.dart';

import '../../Screens/Categories/Categories.dart';
import '../../Screens/Favourite/Favourite.dart';
import '../../Screens/Home/home.dart';
import '../../Screens/Settings/Settings.dart';
import '../../models/categories_model.dart';
import '../../models/fav_model.dart';
import '../../models/home_model.dart';
import '../../models/login_model.dart';
import '../../network/endpoints/endpoint.dart';
import '../../network/remote/dio_helper.dart';
import '../../shared/Constants.dart';

class Shopcubit extends Cubit<ShopStates> {
  Shopcubit() : super(ShopsInitialState());

  static Shopcubit get(context) => BlocProvider.of(context);
  List<Widget> Screens = [
    Home(),
    Categories(),
    Favorites(),
    Settings(),
  ];
  int indexBottomNavBar = 0;
  void changeIndexBottom(int x) {
    indexBottomNavBar = x;
    emit(ShopBottomnav());
  }
  Map<int,bool> isFavorite ={};
  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getdata(url: HOME
        ,
      token: token,
    ).then((value) {
      homeModel=HomeModel.fromJson(value!.data);
       print(homeModel!.data!.banners[0].image);
      print(homeModel!.status);
      homeModel!.data!.products.forEach((element) {
        isFavorite!.addAll({element.id:element.inFavorites});
      });
      print(isFavorite.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  CategoriesModel? categoriesModel;
  void getCategories(){
    emit(ShopLoadingCatagoryDataState());
    DioHelper.getdata(url: CATEGORIES, token: token).then((value){
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCatagoryDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopLoadingCatagoryDataState());
    });
  }

  FavoriteGetModel? favoriteData;
  void changeFavorite({required int id}){
    if(isFavorite[id] == true) {
      isFavorite[id] = false ;
    }else{
      isFavorite[id] = true ;
    }
    emit(ShopchangeFavouriteDataState());
    DioHelper.postData(url: FAVORITE, data: {
      'product_id':id
    },token: token).then((value) {
    //  isFavorite[id]= !(isFavorite[id]??false);
      favoriteData = FavoriteGetModel.fromJson(value.data);
      print(value.data);
      if(!favoriteData!.status)
        {
          if(isFavorite[id] == true) {
            isFavorite[id] = false ;
          }else{
            isFavorite[id] = true ;
          }
        }
      emit(ShopSuccessFavouriteDataState(favoriteData));
    }).catchError((error){
      emit(ShopErrorFavouriteDataState());
      print(error.toString());
    });
  }
  FavoriteGetModel? getFavoritesModel;
  void getFavorite(){
    emit(LoadingGetFavoritesData());
    DioHelper.getdata(url: FAVORITE, token: token).then((value){
      getFavoritesModel = FavoriteGetModel.fromJson(value.data);
      emit(SuccessGetFavoritesData());
    }).catchError((error){
      print(error.toString());
      emit(ErrorGetFavoritesData());
    });
  }
}
