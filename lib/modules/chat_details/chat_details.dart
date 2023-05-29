import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../layout/social_layout/cubit/social_cubit.dart';
import '../../layout/social_layout/cubit/social_states.dart';
import '../../models/message_model.dart';
import '../../models/usercredential_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserCredentialModel userModel;
  ChatDetailsScreen({super.key, required this.userModel});
  var messageController = TextEditingController();
  var random = Random().nextInt(100) % 2;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(userModel.uID!);

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialSendMessageSuccessState) {
            messageController.text = '';
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(userModel.profileImage!),
                      ),
                      random == 0
                          ? CircleAvatar(
                              radius: 9.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                backgroundColor: Colors.green[400],
                                radius: 6.0,
                              ))
                          : CircleAvatar(
                              radius: 9.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 6.0,
                              ))
                    ],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.name!,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(fontSize: 15.0),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        random == 0
                            ? Text(
                                'نشط الأن',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              )
                            : Text(
                                'نشط منذ ساعة واحدة',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              )
                      ],
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.phone,
                      color: defaultColor,
                      size: 25.0,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.video_call,
                        color: defaultColor, size: 30.0)),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.info, color: defaultColor, size: 25.0)),
              ],
            ),
            body: Column(
              children: [
                cubit.messages.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : Expanded(
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.messages.length,
                            itemBuilder: (context, index) {
                              if (cubit.messages[index].senderID ==
                                  cubit.userData!.uID) {
                                return buildMyMessage(cubit.messages[index]);
                              }
                              return buildPartnerMessage(cubit.messages[index]);
                            }),
                      ),
                if (cubit.messages.isEmpty) const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            cubit.deleteMessagesAtMe(userModel.uID!);
                          },
                          icon: const Icon(
                            Icons.grid_view_rounded,
                            color: defaultColor,
                            size: 25.0,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.camera_alt_outlined,
                              color: defaultColor, size: 30.0)),
                      IconButton(
                          onPressed: () {
                            cubit.pickMessageImageFromGallery();
                          },
                          icon: const Icon(Icons.photo_camera_back,
                              color: defaultColor, size: 30.0)),
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius:
                                BorderRadiusDirectional.circular(15.0),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'type message here'),
                                ),
                              ),
                              Container(
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    onPressed: () {
                                      cubit.sendMessage(
                                          text: messageController.text,
                                          receiverID: userModel.uID!);
                                    },
                                    minWidth: 1.0,
                                    child: const Icon(
                                      Icons.send_outlined,
                                      size: 25.0,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }

  Widget buildPartnerMessage(MessageModel model) => Column(
        children: [
          if (model.text != '')
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(20.0),
                          topEnd: Radius.circular(20.0),
                          bottomEnd: Radius.circular(20.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(model.text!),
                    )),
              ),
            ),
          if (model.imageUrl != '')
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(10.0),
                          topEnd: Radius.circular(10.0),
                          bottomEnd: Radius.circular(10.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Image.network(
                          model.imageUrl!,
                          height: 200.0,
                          width: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              ),
            ),
        ],
      );

  Widget buildMyMessage(MessageModel model) => Column(
        children: [
          if (model.text != '')
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                    decoration: BoxDecoration(
                        color: defaultColor.withOpacity(0.2),
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(20.0),
                          topEnd: Radius.circular(20.0),
                          bottomStart: Radius.circular(20.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: Text(model.text!),
                    )),
              ),
            ),
          if (model.imageUrl != '')
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                    decoration: BoxDecoration(
                        color: defaultColor.withOpacity(0.2),
                        borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(10.0),
                          topEnd: Radius.circular(10.0),
                          bottomStart: Radius.circular(10.0),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Image.network(
                          model.imageUrl!,
                          height: 200.0,
                          width: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
              ),
            ),
        ],
      );
}

//defaultColor.withOpacity(0.2),