import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layout/social_layout/cubit/social_states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/usercredential_model.dart';
import 'package:social_app/modules/home_screen/home_screen.dart';
import 'package:social_app/shared/states/loginstates.dart';

import '../../../models/post_model.dart';
import '../../../modules/chat_screen/chat_screen.dart';
import '../../../modules/posts_screen/post_screen.dart';
import '../../../modules/settings_screen/settings_screen.dart';
import '../../../modules/users_screen/users_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/consonents.dart';
import '../../../shared/cubit/register_cubit.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<String> labels = ['Home', 'Chats', 'Add new Post', 'Users', 'Settings'];
  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen()
  ];

  void changeBottomNavItem(int index, context) {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialPostsScreenChangeState());
    } else {
      currentIndex = index;

      emit(SocialBottomNavItemChangeState());
    }
  }

  UserCredentialModel? userData;

  void getUserData([ImageType? imageType]) {
    emit(SocialGetUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userID!)
        .get()
        .then((value) {
      userData = UserCredentialModel.fromJson(value.data()!);
      if (imageType == ImageType.PROFILE) {
        profileImage = null;
      } else if (imageType == ImageType.COVER) {
        coverImage = null;
      } else if (imageType == null) {
        coverImage = null;
        profileImage = null;
      }
      emit(SocialGetUserDataSucessState());
    }).catchError((error) {
      emit(SocialGetUserDataErrorState(error.toString()));
    });
  }

  File? profileImage;
  File? coverImage;
  String? profileImageUrl;
  String? coverImageUrl;
  ImagePicker picker = ImagePicker();

  void changeProfileImage() async {
    var image = await picker!.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = File(image.path);
      emit(SocialChangeProfileImageSuccessState());
    } else {
      emit(SocialChangeProfileImageErrorState('Image not yet picked'));
    }
  }

  void changeCoverImage() async {
    var image = await picker!.pickImage(source: ImageSource.gallery);
    if (image != null) {
      coverImage = File(image.path);
      emit(SocialChangeCoverImageSuccessState());
    } else {
      emit(SocialChangeCoverImageErrorState('Image not yet picked'));
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserDataProfileLoadingState());
    //emit(SocialUploadProfileImageLoadingState());
    //String imageName = basename(profileImage!.path);
    String imageName = Uri.file(profileImage!.path).pathSegments.last;
    imageName = imageName + '${Random().nextInt(100000)}';
    FirebaseStorage.instance
        .ref()
        .child('users/' + imageName)
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('==============================');
        print(value);
        // profileImageUrl = value;
        // emit(SocialUploadProfileImageSuccessState());
        updateUserData(
          ImageType.PROFILE,
          name: name,
          phone: phone,
          bio: bio,
          profileImage: value,
        );
      }).catchError((error) {
        print('profile error is : $error');
        emit(SocialUploadProfileImageErrorState(error.toString()));
      });
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUpdateUserDataCoverLoadingState());
    //emit(SocialUploadCoverImageLoadingState());
    //String imageName = basename(profileImage!.path);
    String imageName = Uri.file(coverImage!.path).pathSegments.last;
    imageName = imageName + '${Random().nextInt(100000)}';
    FirebaseStorage.instance
        .ref()
        .child('users/' + imageName)
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print('==============================');
        print(value);
        //coverImageUrl = value;
        // emit(SocialUploadCoverImageSuccessState());
        updateUserData(ImageType.COVER,
            name: name, phone: phone, bio: bio, coverImage: value);
      }).catchError((error) {
        print('error is : $error');
        emit(SocialUploadCoverImageErrorState(error.toString()));
      });
    });
  }

  void updateUserData(
    ImageType imageType, {
    required String name,
    required String phone,
    required String bio,
    String? profileImage,
    String? coverImage,
  }) {
    // emit(SocialUpdateUserDataLoadingState());

    UserCredentialModel userModel = UserCredentialModel(
        name: name,
        email: userData!.email,
        phone: phone,
        uID: userData!.uID,
        profileImage: profileImage ?? userData!.profileImage,
        coverImage: coverImage ?? userData!.coverImage,
        bio: bio,
        isEmailVerified: userData!.isEmailVerified);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uID)
        .update(userModel.toMap())
        .then((value) {
      // emit(SocialUpdateUserDataSuccessState());
      getUserData(imageType);
    }).catchError((error) {
      emit(SocialUpdateUserDataErrorState(error.toString()));
    });
  }

  ///////////////////////////////////////////////////

  Future<String> uploadProfileImage1() async {
    //emit(SocialUploadProfileImageLoadingState());
    //String imageName = basename(profileImage!.path);
    String imageName = Uri.file(profileImage!.path).pathSegments.last;
    imageName = imageName + '${Random().nextInt(100000)}';
    var value = await FirebaseStorage.instance
        .ref()
        .child('users/' + imageName)
        .putFile(profileImage!);
    profileImageUrl = await value.ref.getDownloadURL();
    print('profile image url is :$profileImageUrl');
    return await value.ref.getDownloadURL();
  }

  Future<String> uploadCoverImage1() async {
    //emit(SocialUploadProfileImageLoadingState());
    //String imageName = basename(profileImage!.path);
    String imageName = Uri.file(coverImage!.path).pathSegments.last;
    imageName = imageName + '${Random().nextInt(100000)}';
    var value = await FirebaseStorage.instance
        .ref()
        .child('users/' + imageName)
        .putFile(coverImage!);
    coverImageUrl = await value.ref.getDownloadURL();
    print('Cover image url is :$coverImageUrl');
    return await value.ref.getDownloadURL();
  }

  void updateUserData1(
      {required String name, required String phone, required String bio}) {
    emit(SocialUpdateUserDataLoadingState());

    UserCredentialModel? userModel;

    if (profileImage != null && coverImage != null) {
      uploadProfileImage1().then((value) {
        uploadCoverImage1().then((value) {
          userModel = UserCredentialModel(
              name: name,
              email: userData!.email,
              phone: phone,
              uID: userData!.uID,
              profileImage: profileImageUrl,
              coverImage: coverImageUrl,
              bio: bio,
              isEmailVerified: userData!.isEmailVerified);

          FirebaseFirestore.instance
              .collection('users')
              .doc(userData!.uID)
              .update(userModel!.toMap())
              .then((value) {
            getUserData();
          });
        });
      });
    } else if (profileImage != null) {
      uploadProfileImage1().then((value) {
        userModel = UserCredentialModel(
            name: name,
            email: userData!.email,
            phone: phone,
            uID: userData!.uID,
            profileImage: profileImageUrl,
            coverImage: userData!.coverImage,
            bio: bio,
            isEmailVerified: userData!.isEmailVerified);
        FirebaseFirestore.instance
            .collection('users')
            .doc(userData!.uID)
            .update(userModel!.toMap())
            .then((value) {
          getUserData(ImageType.PROFILE);
        });
      }).catchError((error) {});
    } else if (coverImage != null) {
      uploadCoverImage1().then((value) {
        userModel = UserCredentialModel(
            name: name,
            email: userData!.email,
            phone: phone,
            uID: userData!.uID,
            profileImage: userData!.profileImage,
            coverImage: coverImageUrl,
            bio: bio,
            isEmailVerified: userData!.isEmailVerified);
        FirebaseFirestore.instance
            .collection('users')
            .doc(userData!.uID)
            .update(userModel!.toMap())
            .then((value) {
          getUserData(ImageType.COVER);
        });
      }).catchError((error) {});
    } else {
      userModel = UserCredentialModel(
          name: name,
          email: userData!.email,
          phone: phone,
          uID: userData!.uID,
          profileImage: userData!.profileImage,
          coverImage: userData!.coverImage,
          bio: bio,
          isEmailVerified: userData!.isEmailVerified);

      FirebaseFirestore.instance
          .collection('users')
          .doc(userData!.uID)
          .update(userModel!.toMap())
          .then((value) {
        getUserData();
      });
    }
  }

  void nullProfileANDCover() {
    profileImage = null;
    coverImage = null;
  }

///////////////////////////////////////////////////////////////////////////

  File? postImage;

  void pickPostImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      postImage = File(image.path);
      emit(SocialPickPostImageSuccessState());
    } else {
      emit(SocialPickPostImageErrorState('Image not yet picked'));
    }
  }

  void deletePostImage() {
    postImage = null;
    emit(SocialPickPostImageDeleteState());
  }

  void uploadPostImage({
    required String post,
  }) {
    emit(SocialUploadPostLoadingState());

    String imageName = Uri.file(postImage!.path).pathSegments.last;
    imageName = imageName + '${Random().nextInt(100000)}';
    FirebaseStorage.instance
        .ref()
        .child('posts/' + imageName)
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(post: post, postImage: value);
      }).catchError((error) {
        print('post Image error is : $error');
        emit(SocialUploadPostImageErrorState(error.toString()));
      });
    });
  }

  void createPost({required String post, String? postImage}) {
    emit(SocialUploadPostLoadingState());

    PostModel postModel = PostModel(
        name: userData!.name,
        image: userData!.profileImage,
        uID: userData!.uID,
        date: DateFormat.yMMMMEEEEd().format(DateTime.now()),
        post: post,
        postImage: postImage ?? '');

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      value.collection('likes').add({'like': true});
      value.collection('comments').add({'comment': true});
      deletePostImage();
      emit(SocialUploadPostSuccessState());

      // getPosts();
    }).catchError((error) {
      emit(SocialUploadPostErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uID)
        .collection('POSTS')
        .add(postModel.toMap());
  }

  List<PostModel> posts = [];
  List<String> postIDs = [];
  List<int> likes = [];
  List<int> comments = [];

  void getPosts() {
    // posts = [];
    //postIDs = [];
    //likes = [];
    //comments = [];

    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length - 1);
          postIDs.add(element.reference.id);
          posts.add(PostModel.fromJson(element.data()));
        });
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length - 1);
          emit(SocialGetPostsSuccessState());
        });
        print('££££££££££££££££££££££');
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void giveLike(int index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postIDs[index])
        .collection('likes')
        .add({'like': true}).then((value) {
      emit(SocialGiveLikeSuccessState());
    }).catchError((error) {
      emit(SocialGiveLikeErrorState(error.toString()));
    });
  }

  void wrietComment(int index) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postIDs[index])
        .collection('comments')
        .add({'comment': true}).then((value) {
      emit(SocialWriteCommentSuccessState());
    }).catchError((error) {
      emit(SocialWriteCommentErrorState(error.toString()));
    });
  }

  /**/
  void changePostLikeState(
      {required String postId, required int index, required bool isLiked}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update({'likes': !isLiked}).then((value) {
      posts[index].likes = !isLiked;
      emit(SocialChangePostLikeStateSuccessState());
    }).catchError((error) {
      emit(SocialChangePostLikeStateErrorState(error.toString()));
    });
  }

  List<UserCredentialModel> users = [];

  void getUsers() {
    ///users = [];

    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uid'] != userData!.uID)
            users.add(UserCredentialModel.fromJson(element.data()));
        });
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  List<MessageModel> messages = [];
  void getMessages(String receiverId) {
    messages = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uID!)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((value) {
      messages = [];
      value.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  void deleteMessagesAtMe(String receiverID) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uID!)
        .collection('chats')
        .doc(receiverID)
        .delete()
        .then((value) {
      print('--------deleteMessagesAtMe---------');

      emit(SocialDeleteMessagesAtMeSuccessState());
    }).catchError((error) {
      emit(SocialDeleteMessagesAtMeErrorState(error.toString()));
    });
  }

  void deleteMessagesAtHim(String receiverID) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(userData!.uID)
        .delete()
        .then((value) {
      emit(SocialDeleteMessagesAtHimSuccessState());
    }).catchError((error) {
      emit(SocialDeleteMessagesAtHimErrorState(error.toString()));
    });
  }

  /////////////////////////////////////////////////////////
  File? messageImage;
  void pickMessageImageFromGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      messageImage = File(image.path);
      emit(SocialPickPostImageSuccessState());
    } else {
      emit(SocialPickPostImageErrorState('Image not yet picked'));
    }
  }

  void pickMessageImageFromCamera() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      messageImage = File(image.path);
      emit(SocialPickPostImageSuccessState());
    } else {
      emit(SocialPickPostImageErrorState('Image not yet picked'));
    }
  }

  void _sendMessageToPartner(String text, String receiverID,
      {String? imageUrl}) {
    MessageModel messageModel = MessageModel(
        text: text,
        receiverID: receiverID,
        senderID: userData!.uID,
        dateTime: DateTime.now().toString(),
        imageUrl: imageUrl ?? '');

    FirebaseFirestore.instance
        .collection('users')
        .doc(userData!.uID!)
        .collection('chats')
        .doc(receiverID)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(userData!.uID)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  void uploadMessageImage({
    required String messageText,
    required String receiverID,
  }) {
    //emit(SocialUploadPostLoadingState());

    String imageName = Uri.file(messageImage!.path).pathSegments.last;
    imageName = imageName + '${Random().nextInt(100000)}';
    FirebaseStorage.instance
        .ref()
        .child('chats/' + imageName)
        .putFile(messageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialUploadMessageImageSuccessState());
        messageImage = null;
        _sendMessageToPartner(messageText, receiverID, imageUrl: value);
      }).catchError((error) {
        print('message Image error is : $error');
        emit(SocialUploadMessageImageErrorState(error.toString()));
      });
    });
  }

  void sendMessage({required String text, required String receiverID}) {
    if (messageImage == null) {
      _sendMessageToPartner(text, receiverID);
    } else {
      uploadMessageImage(messageText: text, receiverID: receiverID);
    }
  }
}
