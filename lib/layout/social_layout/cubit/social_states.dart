abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserDataLoadingState extends SocialStates {}

class SocialGetUserDataSucessState extends SocialStates {}

class SocialGetUserDataErrorState extends SocialStates {
  final String error;
  SocialGetUserDataErrorState(this.error);
}

class SocialBottomNavItemChangeState extends SocialStates {}

class SocialPostsScreenChangeState extends SocialStates {}

class SocialChangeProfileImageSuccessState extends SocialStates{}

class SocialChangeProfileImageErrorState extends SocialStates{
  final String error;
  SocialChangeProfileImageErrorState(this.error);
}

class SocialChangeCoverImageSuccessState extends SocialStates{}

class SocialChangeCoverImageErrorState extends SocialStates{
  final String error;
  SocialChangeCoverImageErrorState(this.error);
}

class SocialUploadProfileImageLoadingState extends SocialStates{}
class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{
  final String error;

  SocialUploadProfileImageErrorState(this.error);
}

class SocialUploadCoverImageLoadingState extends SocialStates{}
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{
  final String error;

  SocialUploadCoverImageErrorState(this.error);
}

class SocialUpdateUserDataLoadingState extends SocialStates{}
class SocialUpdateUserDataProfileLoadingState extends SocialStates{}
class SocialUpdateUserDataCoverLoadingState extends SocialStates{}
class SocialUpdateUserDataSuccessState extends SocialStates{}
class SocialUpdateUserDataErrorState extends SocialStates{
  final String error;

  SocialUpdateUserDataErrorState(this.error);
}


class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSuccessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates{
  final String error;

  SocialGetPostsErrorState(this.error);
}

class SocialPickPostImageSuccessState extends SocialStates{}
class SocialPickPostImageErrorState extends SocialStates{
  final String error;

  SocialPickPostImageErrorState(this.error);
}

class SocialUploadPostImageLoadingState extends SocialStates{}
class SocialUploadPostImageSuccessState extends SocialStates{}
class SocialUploadPostImageErrorState extends SocialStates{
  final String error;

  SocialUploadPostImageErrorState(this.error);
}

class SocialUploadPostLoadingState extends SocialStates{}
class SocialUploadPostSuccessState extends SocialStates{}
class SocialUploadPostErrorState extends SocialStates{
  final String error;

  SocialUploadPostErrorState(this.error);
}

class SocialPickPostImageDeleteState extends SocialStates{}

class SocialGiveLikeSuccessState extends SocialStates{}

class SocialGiveLikeErrorState extends SocialStates{
  final String error;

  SocialGiveLikeErrorState(this.error);
}

class SocialWriteCommentSuccessState extends SocialStates{}

class SocialWriteCommentErrorState extends SocialStates{
  final String error;

  SocialWriteCommentErrorState(this.error);
}

class SocialGetAllUsersLoadingState  extends SocialStates{}

class SocialGetAllUsersSuccessState  extends SocialStates{}

class SocialGetAllUsersErrorState  extends SocialStates{
  final String error ;

  SocialGetAllUsersErrorState(this.error);
}

class SocialChangePostLikeStateSuccessState extends SocialStates{}

class SocialChangePostLikeStateErrorState extends SocialStates{
  final String error;

  SocialChangePostLikeStateErrorState(this.error);
}


class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{
  final String error;

  SocialSendMessageErrorState(this.error);
}

class SocialGetMessageSuccessState extends SocialStates{}

class SocialGetMessageErrorState extends SocialStates{
  final String error;

  SocialGetMessageErrorState(this.error);
}


class SocialDeleteMessagesAtMeSuccessState extends SocialStates{}

class SocialDeleteMessagesAtMeErrorState extends SocialStates{
  final String error;

  SocialDeleteMessagesAtMeErrorState(this.error);
}

class SocialDeleteMessagesAtHimSuccessState extends SocialStates{}

class SocialDeleteMessagesAtHimErrorState extends SocialStates{
  final String error;

  SocialDeleteMessagesAtHimErrorState(this.error);
}

class SocialUploadMessageImageSuccessState extends SocialStates{}

class SocialUploadMessageImageErrorState extends SocialStates{
  final String error;

  SocialUploadMessageImageErrorState(this.error);
}