import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout/cubit/social_states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/consonents.dart';

import '../../layout/social_layout/cubit/social_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ImageProvider profileImageProvider;
        ImageProvider coverImageProvider;
        var cubit = SocialCubit.get(context);
        var userData = SocialCubit.get(context).userData;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;

        if (coverImage == null) {
          coverImageProvider = NetworkImage(
            userData!.coverImage!,
          );
        } else {
          coverImageProvider = FileImage(coverImage!);
        }
        if (profileImage == null) {
          profileImageProvider = NetworkImage(
            userData!.profileImage!,
          );
        } else {
          profileImageProvider = FileImage(profileImage!);
        }
        nameController.text = userData!.name!;
        phoneController.text = userData!.phone!;
        bioController.text = userData!.bio!;

        return Scaffold(
          appBar: AppBar(
            title: Text('Edit a Profile'),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back_ios_new)),
            actions: [
              defaultTextButton(context,
                  text: 'Update',
                  onAction: () {
                    if (formKey.currentState!.validate()) {
                      cubit.updateUserData1(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    } else {
                      showToast('Fill Forms', ToastStates.WARNING);
                    }
                  }),
              const SizedBox(
                width: 15.0,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(children: [
                if (state is SocialUpdateUserDataLoadingState)
                  SizedBox(
                    height: 5.0,
                  ),
                if (state is SocialUpdateUserDataLoadingState)
                  LinearProgressIndicator(),
                const SizedBox(
                  height: 10.0,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    //Widget 'Align'can be used here
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 150.0,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(5.0)),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverImageProvider)),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 20.0,
                            child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).changeCoverImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                            radius: 60,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                                radius: 55,
                                backgroundImage: profileImageProvider)),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 20.0,
                          child: IconButton(
                              onPressed: () {
                                SocialCubit.get(context).changeProfileImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
                if (profileImage != null || coverImage != null)
                  const SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    if (profileImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                onpressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  } else {
                                    showToast(
                                        'Fill Forms', ToastStates.WARNING);
                                  }
                                },
                                isUppercase: true,
                                text: 'Upload Profile'),
                            if (state
                                is SocialUpdateUserDataProfileLoadingState)
                              const SizedBox(
                                height: 5.0,
                              ),
                            if (state
                                is SocialUpdateUserDataProfileLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (coverImage != null)
                      Expanded(
                        child: Column(
                          children: [
                            defaultButton(
                                onpressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  } else {
                                    showToast(
                                        'Fill Forms', ToastStates.WARNING);
                                  }
                                },
                                isUppercase: true,
                                text: 'Upload Cover'),
                            if (state is SocialUpdateUserDataCoverLoadingState)
                              const SizedBox(
                                height: 5.0,
                              ),
                            if (state is SocialUpdateUserDataCoverLoadingState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        DefaultTextFormField(
                            label: 'Name',
                            type: TextInputType.name,
                            controll: nameController,
                            prefix: Icons.person_2_outlined,
                            validate: (String? name) {
                              if (name!.isEmpty) {
                                return 'Name cant be empty';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                            label: 'phone',
                            type: TextInputType.phone,
                            controll: phoneController,
                            prefix: Icons.phone_android,
                            validate: (String? phone) {
                              if (phone!.isEmpty) {
                                return 'phone cant be empty';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: 10.0,
                        ),
                        DefaultTextFormField(
                            label: 'Bio',
                            type: TextInputType.text,
                            controll: bioController,
                            prefix: Icons.info_outline,
                            validate: (String? bio) {
                              if (bio!.isEmpty) {
                                return 'Name cant be empty';
                              }
                              return null;
                            }),
                      ],
                    ))
              ]),
            ),
          ),
        );
      },
    );
  }
}
