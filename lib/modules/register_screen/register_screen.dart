import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/social_layout/cubit/social_cubit.dart';
import '../../layout/social_layout/social_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/register_cubit.dart';
import '../../shared/states/registerstates.dart';
import '../login_screen/login_screen.dart';
import '../register_screen/register_screen.dart';

class RegisterSCreen extends StatelessWidget {
  RegisterSCreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  String? image;
  String? backgroundImage;
  File? file;
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialRegisterCubit>(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateToAndRemove(SocialLayout(), context);
          }
          if (state is SocialRegisterErrorState) {
            showToast(state.error, ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          SocialRegisterCubit cubit = SocialRegisterCubit.get(context);
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
                            'register'.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('Register now to communicate with friends',
                              style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(
                            height: 20.0,
                          ),
                          DefaultTextFormField(
                              label: 'Name',
                              type: TextInputType.name,
                              controll: nameController,
                              prefix: Icons.person_2_outlined,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please , Enter your name ';
                                }
                                return null;
                              }),
                          const SizedBox(
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
                                cubit.register(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    bio: bioController.text,
                                    );
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
                          DefaultTextFormField(
                              label: 'Phone',
                              type: TextInputType.phone,
                              controll: phoneController,
                              prefix: Icons.phone,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please , Enter your phone ';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 15.0,
                          ),
                          DefaultTextFormField(
                              label: 'Write your Bio',
                              type: TextInputType.text,
                              controll: bioController,
                              prefix: Icons.biotech,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'please , Write your Bio ';
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 5.0,
                          ),
                          if (state
                                  is SocialuploadImageFromGalleryLoadingState ||
                              state is SocialuploadImageFromCameraLoadingState)
                              LinearProgressIndicator(),
                              SizedBox(height: 5.0,),
                            Center(
                                child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                InkWell(
                                  onTap: () {
                                    cubit.showSheet(ImageType.COVER,context);
                                  },
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.amber,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 25),
                                      child: Text(
                                        'Background Image',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12.0, bottom: 12.0),
                                  child: CircleAvatar(
                                    radius: 22.0,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: IconButton(
                                        onPressed: () {
                                          cubit.showSheet(ImageType.PROFILE, context);
                                        },
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 30.0,
                                          color: Colors.blue,
                                        )),
                                  ),
                                )
                              ],
                            )),
                          const SizedBox(
                            height: 5.0,
                          ),
                          state is SocialRegisterLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : defaultButton(
                                  onpressed: () {
                                    if (formKey.currentState!.validate()) {
                                      if(cubit.backgroundImageUrl == null ||cubit.personalImageUrl == null ){
                                         showToast('Please, Choose both images', ToastStates.WARNING);
                                      }else{
                                         cubit.register(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                          bio: bioController.text,
                                          );
                                      }
                                      
                                    }
                                  },
                                  isUppercase: true,
                                  text: 'Register'),
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
