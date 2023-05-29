abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}
class SocialRegisterLoadingState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates{
   //final ShopLogInModel? shopRegisterModel;
   //RegisterSuccessState( this.shopRegisterModel);

}
class SocialRegisterErrorState extends SocialRegisterStates{
  final String error;
  SocialRegisterErrorState(this.error);
}

class PasswordChangeRegisterState extends SocialRegisterStates{}


class SocialCreateUserSuccessState extends SocialRegisterStates{
   
}

class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;
  SocialCreateUserErrorState(this.error);
}

class SocialuploadImageFromGalleryLoadingState extends SocialRegisterStates{}
class SocialuploadImageFromGallerySuccessState extends SocialRegisterStates{
  final String imageUrl;

  SocialuploadImageFromGallerySuccessState(this.imageUrl);
}
class SocialuploadImageFromGalleryErrorState extends SocialRegisterStates{
  final String error;

  SocialuploadImageFromGalleryErrorState(this.error);
}
class SocialuploadImageFromCameraLoadingState extends SocialRegisterStates{}
class SocialuploadImageFromCameraSuccessState extends SocialRegisterStates{
  final String imageUrl;

  SocialuploadImageFromCameraSuccessState(this.imageUrl);
}
class SocialuploadImageFromCameraErrorState extends SocialRegisterStates{
  final String error;

  SocialuploadImageFromCameraErrorState(this.error);
}