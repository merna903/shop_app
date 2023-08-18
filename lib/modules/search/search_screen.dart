import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/search_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_state.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../cubits/shop_cubit.dart';
import '../../models/search_model.dart';
import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        builder: (BuildContext context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultFormField(
                        controller: textController,
                        type: TextInputType.text,
                        validate: (String v)
                        {
                          if(v.isEmpty)
                            {
                              return 'enter text to search';
                            }
                          return null;
                        },
                        onSubmit: (String text){
                          SearchCubit.get(context).searchData(text);
                        },
                        text: 'Search',
                        prefix: Icons.search,
                        context: context
                    ),
                    if(state is LoadingSearchState) const LinearProgressIndicator(),
                    Expanded(
                      child: ConditionalBuilder(
                        condition: SearchCubit.get(context).searchModel!=null,
                        builder: (BuildContext context) =>ListView.separated(
                          itemBuilder: (BuildContext context, int index) => buildFavItem(SearchCubit.get(context).searchModel!.data!.data[index] ,context),
                          separatorBuilder: (BuildContext context, int index) => const Divider(),
                          itemCount:SearchCubit.get(context).searchModel!.data!.data.length,
                        ),
                        fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        },
        listener: (BuildContext context, Object? state)
        {

        },
      ),
    );
  }

  Widget buildFavItem(SearchData model, context) => Padding(
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
