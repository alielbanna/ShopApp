import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (BuildContext context, Object? state) {
          if (state is ShopRegisterSuccessState) {
            if (state.registerModel.status) {
              print(state.registerModel.message);
              print(state.registerModel.data?.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data?.token,
              ).then((value) {
                token = state.registerModel.data?.token;
                navigateAndFinish(
                  context,
                  const ShopLayout(),
                );
              });
              showToast(
                  text: state.registerModel.message, state: ToastState.success);
            } else {
              print(state.registerModel.message);
              showToast(
                  text: state.registerModel.message, state: ToastState.error);
            }
          }
        },
        builder: (BuildContext context, state) => Scaffold(
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
                      Text(
                        'REGISTER',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        'Register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'User name',
                        prefix: Icons.person,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your name';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email Address',
                        prefix: Icons.email,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: ShopRegisterCubit.get(context).suffix,
                        suffixPressed: () {
                          ShopRegisterCubit.get(context)
                              .changePasswordVisibility();
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline,
                        isPassword: ShopRegisterCubit.get(context).isPassword,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your password';
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'Phone number',
                        prefix: Icons.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone number';
                          }
                        },
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            ShopRegisterCubit.get(context).userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        fallback: (BuildContext context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        builder: (BuildContext context) => defaultButton(
                          text: 'register',
                          function: () {
                            if (formKey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
