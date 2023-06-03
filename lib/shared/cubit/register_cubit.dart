import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/usercredential_model.dart';
import '../consonents.dart';
import '../states/loginstates.dart';
import '../states/registerstates.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  bool isPassword = true;
  IconData prefixIcon = Icons.lock_outlined;
  IconData suffixIcon = Icons.visibility_outlined;

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void changePasswordState() {
    isPassword = !isPassword;
    prefixIcon = isPassword ? Icons.lock_outlined : Icons.lock_open;
    suffixIcon = isPassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(PasswordChangeRegisterState());
  }

  void register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String bio,
  }) {
    String uID;
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      uID = value.user!.uid;
      print('user credentials are : $value');

      //userID = value.user!.uid;
      uploadImage(ImageType.COVER).then((value) {
        backgroundImageUrl = value;
        uploadImage(ImageType.PROFILE).then((value) {
          profileImageUrl = value;
          createUser(name: name, email: email, uid: uID, phone: phone, bio: bio)
              .then((value) {
          //  emit(SocialRegisterSuccessState());
            emit(SocialCreateUserSuccessState());
          }).catchError((error) {
            emit(SocialCreateUserErrorState(error.toString()));
          });
        }).catchError((error) {
          print('error uploading a profile image');
        });
      }).catchError((error) {
        print('error uploading a cover image');
      });

      // emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  Future<void> createUser({
    required String name,
    required String email,
    required String uid,
    required String phone,
    required String bio,
  }) async {
    UserCredentialModel userData = UserCredentialModel(
        name: name,
        email: email,
        uID: uid,
        phone: phone,
        bio: bio,
        deviceToken: deviceToken,
        profileImage: profileImageUrl,
        coverImage: backgroundImageUrl,
        isEmailVerified: false);

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userData.toMap());
  }

  File? backgroundImage;
  File? profileImage;
  String? backgroundImageUrl;
  String? profileImageUrl;

  void showSheet(ImageType imageType, context) {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Container(
            margin: EdgeInsets.all(20),
            height: 200,
            // width: MediaQuery.of(context).size.width-200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please Choose Image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () async {
                    await chooseImageFromGallery(imageType, context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.browse_gallery,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "From Gallery",
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await chooseImageFromCamera(imageType, context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("From Camera",
                              style: TextStyle(fontSize: 20))),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }

  chooseImageFromGallery(ImageType imageType, context) async {
    XFile? imagechosen =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagechosen != null) {
      Navigator.of(context).pop();
      if (imageType == ImageType.COVER) {
        backgroundImage = File(imagechosen.path);
      } else {
        profileImage = File(imagechosen.path);
      }

      emit(SocialChooseImageFromGallerySuccessState());
    } else {
      emit(SocialChooseImageFromGalleryErrorState('Please,choose an image'));
    }
  }

  chooseImageFromCamera(ImageType imageType, context) async {
    XFile? imagepicked =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (imagepicked != null) {
      Navigator.of(context).pop();

      if (imageType == ImageType.COVER) {
        backgroundImage = File(imagepicked.path);
      } else {
        profileImage = File(imagepicked.path);
      }

      emit(SocialChooseImageFromCameraSuccessState());
    } else {
      emit(SocialChooseImageFromCameraErrorState('Please,choose an image'));
    }
  }

  Future<String> uploadImage(ImageType image) async {
    //String imagename = basename(image!.path);
    String imagename;
    int num;
    if (image == ImageType.COVER) {
      imagename = Uri.file(backgroundImage!.path).pathSegments.last;
      num = Random().nextInt(100000);
      imagename = "$imagename$num";

      var value = await FirebaseStorage.instance
          .ref().child('users/' + imagename)
          .putFile(backgroundImage!);

      return await value.ref.getDownloadURL();
      
    } else {
      imagename = Uri.file(profileImage!.path).pathSegments.last;
      num = Random().nextInt(100000);
      imagename = "$imagename$num";

      FirebaseStorage.instance.ref('users/' + imagename).putFile(profileImage!);
      var value = await FirebaseStorage.instance
          .ref('users/' + imagename)
          .putFile(profileImage!);

      return await value.ref.getDownloadURL();
    }
  }
}

enum ImageType { COVER, PROFILE }
