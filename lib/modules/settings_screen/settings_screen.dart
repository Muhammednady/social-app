import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_layout/cubit/social_cubit.dart';
import 'package:social_app/layout/social_layout/cubit/social_states.dart';
import 'package:social_app/modules/edit_profile/edit_profile.dart';
import 'package:social_app/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        var userData = SocialCubit.get(context).userData;
        
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  //Widget 'Align'can be used here
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50.0),
                    child: Container(
                      width: double.infinity,
                      height: 150.0,
                      decoration:  BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(5.0)),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              userData!.coverImage!,
                            ),
                          )),
                    ),
                  ),
                  CircleAvatar(
                      radius: 60,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child:  CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(
                          userData.profileImage!,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${userData.name}',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold, fontFamily: 'BoldFont'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${userData.bio}',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(color: Colors.grey),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '100',
                          style: TextStyle(fontFamily: 'BoldFont'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'posts',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '256',
                          style: TextStyle(fontFamily: 'BoldFont'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Photoes',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '10k',
                          style: TextStyle(fontFamily: 'BoldFont'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Followers',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Text(
                          '64',
                          style: TextStyle(fontFamily: 'BoldFont'),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Followings',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                      child: OutlinedButton(
                          onPressed: () {},
                          child: Text(
                            'Add Photoes',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.blue),
                          ))),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(onPressed: () {
                    
                    navigateToAndSave( EditProfileScreen(),context);

                  }, child: Icon(Icons.edit))
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
