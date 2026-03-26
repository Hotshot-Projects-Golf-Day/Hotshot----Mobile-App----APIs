class PostCardState {
  final bool isLiked;
  final bool isSaved;
  final int likes;
  final bool isExpanded;

  const PostCardState({
    required this.isLiked,
    required this.isSaved,
    required this.likes,
    required this.isExpanded,
  });

  PostCardState copyWith({
    bool? isLiked,
    bool? isSaved,
    int? likes,
    bool? isExpanded,
  }) {
    return PostCardState(
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      likes: likes ?? this.likes,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}