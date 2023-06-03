import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/usercredential_model.dart';
import 'package:social_app/modules/chat_details/chat_details.dart';
import 'package:social_app/shared/components/components.dart';

import '../../layout/social_layout/cubit/social_cubit.dart';
import '../../layout/social_layout/cubit/social_states.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return cubit.users.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount:cubit.users.length,
                itemBuilder: (context, index) => buildUser(context,cubit.users[index]));
      },
    );
  }

  Widget buildUser(context,UserCredentialModel model ) =>
      InkWell(
        onTap: (){
          navigateToAndSave(ChatDetailsScreen(userModel: model,), context);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    model.profileImage! ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                model.name!,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 15.0),
              ),
            ],
          ),
        ),
      );
}
