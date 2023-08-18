import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constans.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController =  TextEditingController();
  var passwordController = TextEditingController();
  var nameController =  TextEditingController();
  var phoneController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit() ,
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        builder: (BuildContext context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REGISTER',
                          style: Theme.of(context).textTheme.headlineLarge,),
                        Text('Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyLarge,),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String value){
                              if(value.isEmpty)
                              {
                                return "please enter your name";
                              }
                              return null;
                            },
                            text: 'Name',
                            prefix: Icons.person,
                            context: context
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value){
                              if(value.isEmpty)
                              {
                                return "please enter your email address";
                              }
                              return null;
                            },
                            text: 'Email Address',
                            prefix: Icons.email,
                            context: context
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            validate: (String value){
                              if(value.isEmpty)
                              {
                                return "please enter your Password";
                              }
                              return null;
                            },
                            isPassword: RegisterCubit.get(context).isPassword,
                            function:() {
                              RegisterCubit.get(context).changePasswordVisibility();
                            },
                            suffix: RegisterCubit.get(context).suffix,
                            text: 'Password',
                            prefix: Icons.password,
                            context: context
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value){
                              if(value.isEmpty)
                              {
                                return "please enter your phone number";
                              }
                              return null;
                            },
                            text: 'Phone',
                            prefix: Icons.phone,
                            context: context
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (BuildContext context) =>defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate()){
                                RegisterCubit.get(context).postRegisterData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                );
                              }
                            },
                            text: 'REGISTER',),
                          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already Have an account?'),
                            TextButton(
                              onPressed: (){
                                navigateTo(context, LoginScreen());
                              },
                              child: const Text('Login'),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ) ,
          );
        },
        listener: (BuildContext context, Object? state)
        {
          if(state is RegisterSuccessState)
            {
              if(state.model.status)
                {
                  CacheHelper.saveData(key: 'token', value: state.model.data?.token).then((value) {
                    token = state.model.data!.token;
                    navigateAndFinish(context, const HomeScreen());
                  });
                }
              else
                {
                  showToast(
                    msg: state.model.message,
                    state: ToastStates.ERROR
                  );
                }
            }
        },
      ),
    );
  }
}
