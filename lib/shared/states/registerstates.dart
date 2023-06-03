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

class SocialCreateUserLoadingState extends SocialRegisterStates{} 
class SocialCreateUserSuccessState extends SocialRegisterStates{
   
}

class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;
  SocialCreateUserErrorState(this.error);
}

class SocialuploadImageLoadingState extends SocialRegisterStates{}
class SocialuploadImageSuccessState extends SocialRegisterStates{

}
class SocialuploadImageErrorState extends SocialRegisterStates{
  final String error;

  SocialuploadImageErrorState(this.error);
}


class SocialChooseImageFromGallerySuccessState extends SocialRegisterStates{}
class SocialChooseImageFromGalleryErrorState extends SocialRegisterStates{
  final String error;

  SocialChooseImageFromGalleryErrorState(this.error);
}

class SocialChooseImageFromCameraSuccessState extends SocialRegisterStates{}
class SocialChooseImageFromCameraErrorState extends SocialRegisterStates{
  final String error;

  SocialChooseImageFromCameraErrorState(this.error);
}