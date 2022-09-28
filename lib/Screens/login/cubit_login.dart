import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/login/states_login.dart';
import '../../models/login_model.dart';

import '../../network/endpoints/endpoint.dart';
import '../../network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopingLoginIntialStates());
  ShoploginModel? loginmodel ;
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userlogin({
    required String? email,
    required String? Password,
  }) {
    emit(ShopingLoginLoadingStates());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': Password,
    }).then((value) {
    loginmodel=ShoploginModel.fromjson(value.data);
      emit(ShopingLoginSuccessStates(loginmodel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopingLoginErrorStates(error.toString()));
    });
  }
}
