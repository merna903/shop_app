
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/shop_cubit.dart';
import 'package:shop_app/cubits/shopstates.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/components/constans.dart';
import '../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (BuildContext context, state)
      {
        return ConditionalBuilder(
          // ignore: unnecessary_null_comparison
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
          builder: (BuildContext context) => homeBuilder(ShopCubit.get(context).homeModel!,ShopCubit.get(context).categoriesModel!, context),
        );
      },
      listener: (BuildContext context, Object? state) {
        if(state is ShopSuccessFavoritesDataState)
          {
            if(!state.model.status)
              {
                showToast(msg: state.model.message, state: ToastStates.ERROR);
              }
            else
              {
                showToast(msg: state.model.message, state: ToastStates.SUCCESS);
              }
          }
      },
    );
  }

  Widget homeBuilder(HomeModel model, CategoriesModel categoriesModel, context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items: model.data!.banners.map((e) => Image(
              image: NetworkImage(e.image),
              width: double.infinity,
              fit: BoxFit.cover,
            )).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            )
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100.0,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index)=> buildCategoryItem(categoriesModel.data.data[index]),
                  separatorBuilder: (context, index)=> const SizedBox(width: 10,),
                  itemCount: categoriesModel.data.data.length,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.grey[300],
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics() ,
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1/1.6,
                  children:
                  List.generate(
                      model.data!.products.length,
                      (index) => buildGridProduct(model.data!.products[index], context)
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildCategoryItem(CurrentPageData currentPageData) =>Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(
      image: NetworkImage(currentPageData.image),
      height: 100.0,
      width: 100.0,
      fit: BoxFit.cover,
    ),
    Container(
      color: Colors.black.withOpacity(0.8),
      width: 100.0,
      child: Text(
        currentPageData.name,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ],
);

Widget buildGridProduct(Product model, context) => Container(
  color: Colors.white,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(model.image),
            width: double.infinity,
            height: 200,
          ),
          if(model.discount!=0)
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            color: Colors.red,
            child: const Text(
              'DISCOUNT',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                height: 1.2,
              ),
            ),
            Row(
              children: [
                Text(
                  '${model.price.round()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryColor
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                if(model.discount!=0)
                  Text(
                  '${model.oldprice.round()}',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: ()
                    {
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: (ShopCubit.get(context).favorites[ model.id ]??false) ? primaryColor : Colors.grey,
                      child: const Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
);