abstract class PostStates{}

class SocialPostInitialState extends PostStates{}

class SocialPickPostImageSuccessState extends PostStates{}
class SocialPickPostImageErrorState extends PostStates{
  final String error;

  SocialPickPostImageErrorState(this.error);
}

class SocialUploadPostImageLoadingState extends PostStates{}
class SocialUploadPostImageSuccessState extends PostStates{}
class SocialUploadPostImageErrorState extends PostStates{
  final String error;

  SocialUploadPostImageErrorState(this.error);
}

class SocialUploadPostLoadingState extends PostStates{}
class SocialUploadPostSuccessState extends PostStates{}
class SocialUploadPostErrorState extends PostStates{
  final String error;

  SocialUploadPostErrorState(this.error);
}