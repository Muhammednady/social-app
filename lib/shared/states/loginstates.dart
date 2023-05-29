

abstract class SocialLogInStates{}

class SocialLogInInitialState extends SocialLogInStates{}

class SocialLogInLoadingState extends SocialLogInStates{}
class SocialLogInSuccessState extends SocialLogInStates{
  final String uid;

  SocialLogInSuccessState(this.uid);

}
class SocialLogInErrorState extends SocialLogInStates{
  final String error;
  SocialLogInErrorState(this.error);
}
class PasswordChangeState extends SocialLogInStates{}

