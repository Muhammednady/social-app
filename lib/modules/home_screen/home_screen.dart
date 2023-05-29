import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../layout/social_layout/cubit/social_cubit.dart';
import '../../layout/social_layout/cubit/social_states.dart';
import '../../models/post_model.dart';
import '../../shared/consonents.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var posts = SocialCubit.get(context).posts;

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  Card(
                      elevation: 10.0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Image.asset(
                            'assets/images/chat.jpg',
                            width: double.infinity,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, right: 5.0),
                            child: Text(
                              'Communicate with friends',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      )),
                  posts.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: posts.length,
                          itemBuilder: (context, index) =>
                              buildPostItem(context, posts[index], index),
                        )
                ],
              )),
        );
      },
    );
  }
}

Widget buildPostItem(context, PostModel post, int index) => Column(
      children: [
        Card(
          elevation: 10.0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(post.image!),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${post.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(height: 1.3),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              const Icon(
                                Icons.check_circle_rounded,
                                color: Colors.blue,
                                size: 15.0,
                              )
                            ],
                          ),
                          Text(
                            '${post.date}',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 12, height: 1.3),
                          )
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    color: Colors.grey[300],
                    height: 1.0,
                    width: double.infinity,
                  ),
                ),
                Text(
                  '${post.post}',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(height: 1.2),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Wrap(
                    spacing: 5.0,
                    children: [
                      Container(
                        height: 20.0,
                        child: MaterialButton(
                            padding: EdgeInsets.zero,
                            minWidth: 1.0,
                            onPressed: () {},
                            child: Text(
                              '#Software_development',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontSize: 12,
                                      color: defaultColor,
                                      fontFamily: 'BoldFont'),
                            )),
                      ),
                      Container(
                        height: 20.0,
                        child: MaterialButton(
                            padding: EdgeInsets.zero,
                            minWidth: 1.0,
                            onPressed: () {},
                            child: Text(
                              '#mobile_development',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontSize: 12,
                                      color: defaultColor,
                                      fontFamily: 'BoldFont'),
                            )),
                      ),
                      Container(
                        height: 20.0,
                        child: MaterialButton(
                            padding: EdgeInsets.zero,
                            minWidth: 1.0,
                            onPressed: () {},
                            child: Text(
                              '#flutter_development',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontSize: 12,
                                      color: defaultColor,
                                      fontFamily: 'BoldFont'),
                            )),
                      ),
                    ],
                  ),
                ),
                if (post.postImage!.isNotEmpty)
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.zero,
                    child: Image.network(
                      post.postImage!,
                      width: double.infinity,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          SocialCubit.get(context).changePostLikeState(
                              postId: SocialCubit.get(context).postIDs[index],
                              index: index,
                              isLiked: post.likes);
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 5.0),
                          child: Row(
                            children: [
                              post.likes
                                  ? Image.asset(
                                      'assets/images/fullheart.png',
                                      height: 16,
                                      width: 16,
                                    )
                                  : Image.asset(
                                      'assets/images/heart.png',
                                      height: 16,
                                      width: 16,
                                    ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(fontSize: 11, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat_outlined,
                              color: Colors.amber[200],
                              size: 20,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              '${SocialCubit.get(context).comments[index]}',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 11, color: Colors.grey),
                            ),
                            Text(
                              ' comments',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Container(
                    color: Colors.grey[200],
                    height: 1.0,
                    width: double.infinity,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          ///////////////////////////////////
                          ///
                          SocialCubit.get(context).wrietComment(index);
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15.0,
                              backgroundImage: NetworkImage(
                                  SocialCubit.get(context)
                                      .userData!
                                      .profileImage!),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Write a comment...',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {
                        ////////////////////////////
                        ///
                        SocialCubit.get(context).giveLike(index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/heart.png',
                              height: 15,
                              width: 15,
                              colorBlendMode: BlendMode.color,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              'like',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 11, color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.ios_share_outlined,
                              color: Colors.green[300],
                              size: 17.0,
                            ),
                            SizedBox(
                              width: 7.0,
                            ),
                            Text(
                              'share',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontSize: 11,
                                      color: Colors.grey,
                                      height: 1.5),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
