
import 'package:shop_app/models/login_model.dart';

abstract  class ShopLoginStates {}
class ShopingLoginIntialStates extends ShopLoginStates{}
class ShopingLoginLoadingStates extends ShopLoginStates{}
class ShopingLoginSuccessStates extends ShopLoginStates{
  final ShoploginModel? loginmodel ;

  ShopingLoginSuccessStates(this.loginmodel);
}
class ShopingLoginErrorStates extends ShopLoginStates{
  final String error ;
  ShopingLoginErrorStates(this.error);
}
