import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout/social_layout.dart';
import 'package:social_app/modules/settings_screen/settings_screen.dart';
import 'package:social_app/shared/consonents.dart';
import 'package:social_app/shared/network/local/shared_preferences.dart';
import 'package:social_app/shared/styles/themes.dart';

import 'layout/social_layout/cubit/social_cubit.dart';
import 'modules/login_screen/login_screen.dart';
import 'modules/register_screen/register_screen.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CachHelper.init();
  userID = CachHelper.getUserID('uID');
  print('====================================');
  print('userID is :$userID');
  Widget startWidget;
  if(userID == null){
    startWidget = LogInSCreen();
  }else{
    startWidget = SocialLayout();
  }
  runApp( MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  Widget startWidget;
   MyApp(this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'social app',
        theme: lightTheme,
    
        home: startWidget,
      ),
    );
  }
}
