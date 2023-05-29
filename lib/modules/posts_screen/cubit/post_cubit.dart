import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/modules/posts_screen/cubit/post_states.dart';

import '../../../models/post_model.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(SocialPostInitialState());

  static PostCubit get(context) => BlocProvider.of(context);

}
