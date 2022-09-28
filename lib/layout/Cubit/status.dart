import 'package:shop_app/models/login_model.dart';

import '../../models/fav_model.dart';

abstract class ShopStates {
}
class ShopsInitialState extends ShopStates {}
class ShopBottomnav extends ShopStates {}
class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccessHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}
class ShopLoadingCatagoryDataState extends ShopStates {}
class ShopSuccessCatagoryDataState extends ShopStates {}
class ShopErrorCatagoryDataState extends ShopStates {}

class ShoploadingFavouriteDataState extends ShopStates{}
class ShopSuccessFavouriteDataState extends ShopStates{
  final FavoriteGetModel? model;

  ShopSuccessFavouriteDataState(this.model);
}
class ShopchangeFavouriteDataState extends ShopStates {}
class ShopErrorFavouriteDataState extends ShopStates{}

class LoadingGetFavoritesData extends ShopStates{}
class SuccessGetFavoritesData extends ShopStates{}
class ErrorGetFavoritesData extends ShopStates{}