
Column(
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  if (!FirebaseAuth.instance.currentUser!.emailVerified)
                    Container(
                      height: 50.0,
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 10.0),
                        child: Row(
                          children: [
                            Icon(Icons.info_outline),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(child: Text('Please,verify your email')),
                            defaultTextButton(
                                text: 'send',
                                onAction: () {
                                  FirebaseAuth.instance.currentUser!
                                      .sendEmailVerification()
                                      .then((value) {
                                    showToast(
                                        'Check your mail', ToastStates.SUCCESS);
                                  }).catchError((error) {});
                                })
                          ],
                        ),
                      ),
                    )
                ],
              )