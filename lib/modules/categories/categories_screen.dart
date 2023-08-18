import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/shop_cubit.dart';
import 'package:shop_app/cubits/shopstates.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (BuildContext context, state)
      {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) => buildCatItem(ShopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount:ShopCubit.get(context).categoriesModel!.data.data.length ,
        );
      },
      listener: (BuildContext context, Object? state) {  }
    );
  }

  Widget buildCatItem(CurrentPageData currentPageData) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(currentPageData.image),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          currentPageData.name,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward),
      ],
    ),
  );
}
