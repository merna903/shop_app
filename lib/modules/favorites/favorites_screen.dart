import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';

import '../../cubits/shop_cubit.dart';
import '../../cubits/shopstates.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
        builder: (BuildContext context, state)
        {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).favoritesModel!=null,
            builder: (BuildContext context) =>ListView.separated(
              itemBuilder: (BuildContext context, int index) => buildFavItem(ShopCubit.get(context).favoritesModel!.data.data[index].product,context),
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemCount:ShopCubit.get(context).favoritesModel!.data.data.length,
            ),
            fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
          );
        },
        listener: (BuildContext context, Object? state) {  }
    );
  }

  Widget buildFavItem(Product model, context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
               Image(
                image: NetworkImage(model.image),
                width: 120.0,
                height: 120.0,
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
          const SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
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
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
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
                        model.oldPrice.toString(),
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
    ),
  ) ;
}
