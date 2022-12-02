import '../../models/post_model.dart';

abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

//Create Post
class CreatePostLoadingState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialStates {
  final String error;

  CreatePostErrorState(this.error);
}

class PostImagePickedSuccessState extends SocialStates {}

class PostImagePickedErrorState extends SocialStates {}

class RemovePostImageState extends SocialStates {}


class GetPostLoadingState extends SocialStates {}

class GetPostSuccessState extends SocialStates {
  List<PostModel>  postModel;
  GetPostSuccessState(this.postModel);
}

class GetPostErrorState extends SocialStates {
  final String error;

  GetPostErrorState(this.error);
}

//Like Post
class LikePostLoadingState extends SocialStates {}

class LikePostSuccessState extends SocialStates {
  List<PostModel>  postModel;
  LikePostSuccessState(this.postModel);
}

class LikePostErrorState extends SocialStates {
  final String error;

  LikePostErrorState(this.error);
}

// Get All User
class SocialGetAllUserLoadingState extends SocialStates {}

class SocialGetAllUserSuccessState extends SocialStates {}

class SocialGetAllUserErrorState extends SocialStates {
  final String error;

  SocialGetAllUserErrorState(this.error);
}

//Chat
class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}

class GetMessageSuccessState extends SocialStates {}
