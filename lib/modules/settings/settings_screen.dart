import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUpdateUserDataState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: 'Name',
                    prefix: Icons.person,
                    validate: (String? value) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.name,
                    label: 'Email Address',
                    prefix: Icons.email,
                    validate: (String? value) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.name,
                    label: 'Phone Number',
                    prefix: Icons.phone,
                    validate: (String? value) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'Update',
                    function: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'Logout',
                    function: () {
                      singOut(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
