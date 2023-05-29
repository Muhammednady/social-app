import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:social_app/layout/social_layout/cubit/social_cubit.dart';
import 'package:social_app/layout/social_layout/cubit/social_states.dart';
import 'package:social_app/modules/posts_screen/cubit/post_cubit.dart';
import 'package:social_app/shared/components/components.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});

  var postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialUploadPostSuccessState){
          postController.text = '';
          showToast('your post uploaded successfully', ToastStates.SUCCESS);
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        return Scaffold(
            appBar: defaultAppBar(
              context,
              buttonText: 'Post',
              text: 'Create Post',
              onPressed: () {
                if(cubit.postImage == null){
                  cubit.createPost(post: postController.text);
                }else{
                  cubit.uploadPostImage(post: postController.text);
                }
               
              },
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  if (state is SocialUploadPostLoadingState)
                    const SizedBox(
                      height: 10.0,
                    ),
                  if (state is SocialUploadPostLoadingState)
                    LinearProgressIndicator(),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage:
                            NetworkImage(cubit.userData!.profileImage!),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        cubit.userData!.name!,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: postController,
                      decoration: InputDecoration(
                          hintText:
                              'What is on your mind.......',
                              border: InputBorder.none,
                              ),
                    ),
                  ),
                  if (cubit.postImage != null)
                    const SizedBox(
                      height: 10.0,
                    ),
                  if (cubit.postImage != null)
                   Stack(
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
                                    image: FileImage(cubit.postImage!))),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 15.0,
                            child: IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).deletePostImage();
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 15.0,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                        onTap: () {
                          cubit.pickPostImage();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_outlined,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'add photo',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(color: Colors.blue),
                              )
                            ],
                          ),
                        ),
                      )),
                      Expanded(
                          child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text('# tags',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(color: Colors.blue),),
                          ),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}

 /*BlocConsumer<PostCubit, PostStates>(
          listener: (context, state) {},
          builder: (context, state) {

            return ;
          },
        ),*/