import 'package:flutter_bloc/flutter_bloc.dart';
import 'post_card_state.dart';

class PostCardCubit extends Cubit<PostCardState> {
  PostCardCubit({
    required bool isLiked,
    required bool isSaved,
    required int likes,
  }) : super(
         PostCardState(
           isLiked: isLiked,
           isSaved: isSaved,
           likes: likes,
           isExpanded: false,
         ),
       );

  void toggleLike() {
    final liked = !state.isLiked;

    emit(
      state.copyWith(
        isLiked: liked,
        likes: liked ? state.likes + 1 : state.likes - 1,
      ),
    );
  }

  void toggleSave() {
    emit(state.copyWith(isSaved: !state.isSaved));
  }

  void toggleExpand() {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }
}
