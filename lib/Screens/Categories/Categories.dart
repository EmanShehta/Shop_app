import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Styles/Colors/colors.dart';
import 'package:shop_app/layout/Cubit/cubit.dart';
import 'package:shop_app/layout/Cubit/status.dart';
import '../../models/categories_model.dart';
class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Shopcubit, ShopStates>(
        builder: (context, state) =>
        Shopcubit.get(context).homeModel == null ||
            Shopcubit.get(context).categoriesModel == null
            ? Center(
            child: CircularProgressIndicator(
              color: defaultcolor,
            ))
            : ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => categoriesView(
                Shopcubit.get(context).categoriesModel,
                index,
                context),
            separatorBuilder: (context, index) => Divider(
              height: 2,
              color: defaultcolor,
              indent: 25,
              endIndent: 25,
            ),
            itemCount: Shopcubit.get(context)
                .categoriesModel!
                .dataAll
                .dataList
                .length),
        listener: (context, state) {});
  }
}

Widget categoriesView(CategoriesModel? model, index, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Image.network(
          model!.dataAll.dataList[index].image,
          height: 100,
          width: 120,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(model.dataAll.dataList[index].name,
              style: TextStyle(
                  color: defaultcolor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
        ),
        Spacer(),
        IconButton(
            onPressed: () {
              print(model.dataAll.dataList[index].id);
          /*    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoryDetails(
                          id: model.dataAll.dataList[index].id)));*/
            },
            icon: Icon(
              Icons.arrow_forward_ios,
              color: defaultcolor,
            )),
      ],
    ),
  );
}
