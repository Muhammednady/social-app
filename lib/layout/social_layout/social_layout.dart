import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout/cubit/social_cubit.dart';
import 'package:social_app/layout/social_layout/cubit/social_states.dart';
import 'package:social_app/models/usercredential_model.dart';
import 'package:social_app/shared/components/components.dart';

import '../../modules/posts_screen/post_screen.dart';
import '../../shared/consonents.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(listener: (context, state) {
      if (state is SocialPostsScreenChangeState) {
        navigateToAndSave(NewPostScreen(), context);
      }
      if (state is SocialGetUserDataSucessState) {}
      if (state is SocialGetUserDataErrorState) {
        print('=========================================');
        print(state.error);
      }
    }, builder: (context, state) {
      var cubit = SocialCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          title: Text('${cubit.labels[cubit.currentIndex]}'),
          actions: [
            IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.notifications_none)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: cubit.screens[cubit.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavItem(index, context);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.ios_share_rounded), label: 'Posts'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ]),
      );
    });
  }
}
