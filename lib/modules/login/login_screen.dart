import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constans.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController =  TextEditingController();
  var passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit() ,
      child: BlocConsumer<LoginCubit,LoginStates>(
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
                        Text('LOGIN',
                          style: Theme.of(context).textTheme.headlineLarge,),
                        Text('login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyLarge,),
                        const SizedBox(
                          height: 30,
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
                            isPassword: LoginCubit.get(context).isPassword,
                            function:() {
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                            suffix: LoginCubit.get(context).suffix,
                            text: 'Password',
                            prefix: Icons.password,
                            context: context
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (BuildContext context) =>defaultButton(
                            function: ()
                            {
                              if(formKey.currentState!.validate()){
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                            text: 'LOGIN',),
                          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t Have an acount?'),
                            TextButton(
                              onPressed: (){
                                navigateTo(context, RegisterScreen());
                              },
                              child: const Text('Register Now'),),
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
          if(state is LoginSuccessState)
            {
              if(state.loginModel.status)
                {
                  CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
                    token = state.loginModel.data!.token;
                    navigateAndFinish(context, const HomeScreen());
                  });
                }
              else
                {
                  showToast(
                    msg: state.loginModel.massage!,
                    state: ToastStates.ERROR
                  );
                }
            }
        },
      ),
    );
  }
}
