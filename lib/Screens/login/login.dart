import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/Screens/login/cubit_login.dart';
import 'package:shop_app/Screens/login/states_login.dart';
import 'package:shop_app/layout/shop_app_layout.dart';
import 'package:shop_app/network/local/cachehelper.dart';
import 'package:shop_app/shared/Components.dart';

import '../logup/logup.dart';

class Shoplogin_screen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailcontroller = TextEditingController();
  var passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
          listener: (context, state) {
            if (state is ShopingLoginSuccessStates) {
              if (state.loginmodel!.status!.toString()=="true") {
                print(state.loginmodel!.Message);
                print(state.loginmodel!.data!.token);
                showtoast(text: state!.loginmodel!.Message!,
                    state:ToastStates.SUCCESS);

                CahceHelper.saveData(Key: 'token', Value: state.loginmodel!.data!.token).then((value){
                  navigateAndFinish(context, shop_layout());
                });
              }
              else if (state.loginmodel!.status!.toString()=="false") {
                print("Wrong""${state.loginmodel!.Message}");
                print("انا هنا اهوا ");
                showtoast(text: state!.loginmodel!.Message!,
                state:ToastStates.ERROR);

              }
            }

  },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 80),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Login now to browse our hot offers ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: emailcontroller,
                          validator: (String? input) {
                            if (input!.isEmpty) {
                              return 'Please Enter Your email address';
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onSaved: (email) {},
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: HexColor('F38E8E'), //this has no effect
                              ),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passcontroller,
                          validator: (String? input) {
                            if (input!.isEmpty) {
                              return 'Please Enter Your password correctly';
                            }
                          },

                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onSaved: (email) {},
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userlogin(
                                email: emailcontroller.text,
                                Password: passcontroller.text,
                              );
                            }
                          },
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.lock_outlined),
                            suffixIcon: Icon(Icons.remove_red_eye_outlined),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: HexColor('F38E8E'), //this has no effect
                              ),
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopingLoginLoadingStates,
                          builder: (context) => defaultButton(
                              text: 'login',
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  print("1111111111111111");
                                  ShopLoginCubit.get(context).userlogin(
                                    email: emailcontroller.text,
                                    Password: passcontroller.text,
                                  );
                                }
                              },
                              isUpperCase: true),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, signup());
                              },
                              child: Text(
                                'REGISTER?',
                                style: TextStyle(
                                  color: HexColor('F38E8E'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
