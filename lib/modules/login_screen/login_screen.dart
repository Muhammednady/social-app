import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/consonents.dart';
import 'package:social_app/shared/network/local/shared_preferences.dart';

import '../../layout/social_layout/social_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/login_cubit.dart';
import '../../shared/states/loginstates.dart';
import '../register_screen/register_screen.dart';

class LogInSCreen extends StatelessWidget {
  LogInSCreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialLOGINCubit>(
      create: (context) => SocialLOGINCubit(),
      child: BlocConsumer<SocialLOGINCubit, SocialLogInStates>(
        listener: (context, state) {
          if (state is SocialLogInSuccessState) {
            showToast("Login Succeeded", ToastStates.SUCCESS);

            CachHelper.setUserID('uID', state.uid).then((value) {
              if (value) {
                userID = state.uid;
                navigateToAndRemove(SocialLayout(), context);
              }
            });
          } else {
            if (state is SocialLogInErrorState) {
              showToast(state.error, ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          SocialLOGINCubit cubit = SocialLOGINCubit.get(context);
          return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOG IN',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text('Login now to communicate with friends',
                              style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(
                            height: 20.0,
                          ),
                          DefaultTextFormField(
                              label: 'Email Address',
                              type: TextInputType.emailAddress,
                              controll: emailController,
                              prefix: Icons.email_outlined,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please , Enter your email address ';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 20.0,
                          ),
                          DefaultTextFormField(
                              label: 'password',
                              type: TextInputType.visiblePassword,
                              controll: passwordController,
                              isPassword: cubit.isPassword,
                              prefix: cubit.prefixIcon,
                              suffix: cubit.suffixIcon,
                              onSubmit: (value) {
                                cubit.logIn(
                                    email: emailController.text,
                                    password: passwordController.text);
                              },
                              suffixpressed: () {
                                cubit.changePasswordState();
                              },
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'password can\'t be empty ';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 15.0,
                          ),
                          state is SocialLogInLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : defaultButton(
                                  onpressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.logIn(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  isUppercase: true,
                                  text: 'log in'),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              // SizedBox(width: 5.0,),
                              defaultTextButton(context,
                                  text: 'register',
                                  onAction: () {
                                    navigateToAndRemove(
                                        RegisterSCreen(), context);
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
