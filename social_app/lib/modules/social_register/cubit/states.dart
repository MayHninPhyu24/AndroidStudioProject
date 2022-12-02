
abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {

}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;
  SocialRegisterErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates{

}


class SocialCreateUserInitialState extends SocialRegisterStates {}

class SocialCreateUserLoadingState extends SocialRegisterStates {}

class SocialCreateUserSuccessState extends SocialRegisterStates {
  final String uid;
  SocialCreateUserSuccessState(this.uid);
}

class SocialCreateUserErrorState extends SocialRegisterStates {
  final String error;
  SocialCreateUserErrorState(this.error);
}
