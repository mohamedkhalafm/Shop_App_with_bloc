import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/shop_layout/home_layout.dart';
import 'package:flutter_application_1/modules/shop_app/login/cubit/cubit.dart';
import 'package:flutter_application_1/modules/shop_app/login/cubit/states.dart';
import 'package:flutter_application_1/modules/shop_app/register/register_screen.dart';
import 'package:flutter_application_1/shared/component/components.dart';
import 'package:flutter_application_1/shared/component/constant.dart';
import 'package:flutter_application_1/shared/network/local/cash_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;

                navigateToAndBurn(
                  context,
                  ShopLayout(),
                );
              });
            } else {
              print(state.loginModel.message);

              /*showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );*/
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            //appBar: AppBar(),
            body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.blue[900],
                Colors.blue[800],
                Colors.blue[700]
              ])),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style:
                                Theme.of(context).textTheme.headline4.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(
                            'Login now to browse our hot offers',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'please enter your email address';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Container(
                            color: Colors.white,
                            child: defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              suffix: ShopLoginCubit.get(context).suffix,
                              onSubmit: (value) {
                                if (formKey.currentState.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              isPassword:
                                  ShopLoginCubit.get(context).isPassword,
                              suffixPressed: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'password is too short';
                                }
                              },
                              label: 'Password',
                              prefix: Icons.lock_outline,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            builder: (context) => defaultButton(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'login',
                              isUpperCase: true,
                            ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                              ),
                              Container(
                                color: Colors.blue[800],
                                child: defaultTextButton(
                                  function: () {
                                    navigateTo(
                                      context,
                                      RegisterScreen(),
                                    );
                                  },
                                  text: 'Register Now',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
