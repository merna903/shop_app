import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/shop_cubit.dart';
import 'package:shop_app/cubits/shopstates.dart';
import 'package:shop_app/shared/components/constans.dart';

import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (BuildContext context, state)
      {
        var userModel = ShopCubit.get(context).userModel;
        nameController.text = userModel!.data!.name;
        emailController.text = userModel.data!.email;
        phoneController.text = userModel.data!.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (BuildContext context) =>SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String v){
                      if(v.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    isClickable: ShopCubit.get(context).isReadOnly,
                    prefix: Icons.person,
                    context: context,
                    text: 'Name',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    isClickable: ShopCubit.get(context).isReadOnly,
                    validate: (String v){
                      if(v.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.email,
                    context: context,
                    text: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    isClickable: ShopCubit.get(context).isReadOnly,
                    validate: (String v){
                      if(v.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.phone,
                    context: context,
                    text: 'Phone Number',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultButton(
                        width: 180,
                          function: (){
                            ShopCubit.get(context).updateDataProfile(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);
                          },
                          text: 'Save'
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      defaultButton(
                          width: 180,
                          function: (){
                            ShopCubit.get(context).enableUpdateProfile();
                          },
                          text: 'Update'
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: (){
                        signOut(context);
                      },
                      text: 'LOGOUT'
                  ),
                ],
              ),
            ),
          ),
          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, Object? state)
      {

      },
    );
  }
}