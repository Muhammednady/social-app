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

  void register(
      {required String name,
      required String email,
      required String password,
      required String phone,
      required String bio,
      }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print('user credentials are : $value');

      userID = value.user!.uid;

      createUser(name: name, email: email, uid: value.user!.uid, phone: phone,bio: bio)
          .then((value) {
            
        emit(SocialCreateUserSuccessState());
      }).catchError((error) {
        emit(SocialCreateUserErrorState(error.toString()));
      });

      // emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  Future<void> createUser(
      {required String name,
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
        profileImage: personalImageUrl,
        coverImage: backgroundImageUrl,
        isEmailVerified: false);

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userData.toMap());
  }

  String? backgroundImageUrl;
  String? personalImageUrl;

  void showSheet(ImageType imageType,context) {
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
                    await uploadImageFromGallery(imageType,context);
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
                    await uploadImageFromCamera(imageType,context);
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

  uploadImageFromGallery(ImageType imageType,context) async {
    XFile? imagechosen =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagechosen != null) {
      Navigator.of(context).pop();
      emit(SocialuploadImageFromGalleryLoadingState());
      File image = File(imagechosen.path);
      String imagename = basename(image.path);
      int num = Random().nextInt(100000);
      imagename = "$imagename$num";
      UploadTask uploadTask =
          FirebaseStorage.instance.ref(imagename).putFile(image);
      TaskSnapshot taskSnapshot = uploadTask.snapshot;
      taskSnapshot.ref.getDownloadURL().then((value) {
        if(imageType == ImageType.COVER){
          backgroundImageUrl = value;
        }else{
           personalImageUrl = value;
        }
        
        emit(SocialuploadImageFromGallerySuccessState(value));
      }).catchError((error) {
        print('Error is :$error');
        emit(SocialuploadImageFromGalleryErrorState(error.toString()));
      });
    }
  }

  uploadImageFromCamera(ImageType imageType,context) async {
    XFile? imagepicked =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (imagepicked != null) {
      Navigator.of(context).pop();
      emit(SocialuploadImageFromGalleryLoadingState());

      File image = File(imagepicked.path);
      String imagename = basename(image.path);
      int num = Random().nextInt(100000);
      imagename = "$imagename$num";
      UploadTask uploadTask =
          FirebaseStorage.instance.ref(imagename).putFile(image);
      TaskSnapshot taskSnapshot = uploadTask.snapshot;
      taskSnapshot.ref.getDownloadURL().then((value) {
       if(imageType == ImageType.COVER){
          backgroundImageUrl = value;
        }else{
           personalImageUrl = value;
        }
        emit(SocialuploadImageFromGallerySuccessState(value));
      }).catchError((error) {
        emit(SocialuploadImageFromGalleryErrorState(error.toString()));
      });
    }
  }
}


// ignore: constant_identifier_names
enum ImageType{ COVER , PROFILE}

