import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upd8s/core/constants/app_images.dart';
import 'package:upd8s/core/theme/app_colors.dart';
import 'package:upd8s/features/home/presentation/widgets/post_card/cubit/post_card_cubit.dart';
import 'package:upd8s/features/home/presentation/widgets/post_card/cubit/post_card_state.dart';

class PostCard extends StatelessWidget {
  final String postId;

  final String schoolName;
  final String time;
  final String description;
  final String imageUrl;

  final int likes;
  final int comments;
  final int shares;

  final bool isLiked;
  final bool isSaved;

  final String schoolLogoUrl;

  final Function(String postId)? onPostTap;
  final Function(String postId)? onMoreTap;
  final Function(String postId)? onLikeTap;
  final Function(String postId)? onCommentTap;
  final Function(String postId)? onShareTap;
  final Function(String postId)? onBookmarkTap;

  const PostCard({
    super.key,
    required this.postId,
    required this.schoolName,
    required this.schoolLogoUrl,
    required this.time,
    required this.description,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isLiked,
    required this.isSaved,
    this.onPostTap,
    this.onMoreTap,
    this.onLikeTap,
    this.onCommentTap,
    this.onShareTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PostCardCubit(isLiked: isLiked, isSaved: isSaved, likes: likes),
      child: BlocBuilder<PostCardCubit, PostCardState>(
        builder: (context, state) {
          final cubit = context.read<PostCardCubit>();

          return InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () => onPostTap?.call(postId),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(schoolLogoUrl),
                      ),
                      const SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              schoolName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      InkWell(
                        onTap: () => onMoreTap?.call(postId),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: SvgPicture.asset(AppAssets.more),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// DESCRIPTION
                  _DescriptionText(
                    description: description,
                    isExpanded: state.isExpanded,
                    onReadMore: cubit.toggleExpand,
                  ),

                  const SizedBox(height: 12),

                  /// IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// ACTIONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// LIKE
                      _ActionItem(
                        iconPath: state.isLiked
                            ? AppAssets.thumbsUpFilled
                            : AppAssets.thumbsUp,
                        count: state.likes,
                        onTap: () {
                          cubit.toggleLike();
                          onLikeTap?.call(postId);
                        },
                      ),

                      /// COMMENT
                      _ActionItem(
                        iconPath: AppAssets.chatCircleDots,
                        count: comments,
                        onTap: () => onCommentTap?.call(postId),
                      ),

                      /// SHARE
                      _ActionItem(
                        iconPath: AppAssets.share,
                        count: shares,
                        onTap: () => onShareTap?.call(postId),
                      ),

                      /// SAVE
                      InkWell(
                        onTap: () {
                          cubit.toggleSave();
                          onBookmarkTap?.call(postId);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            state.isSaved
                                ? AppAssets.saveFilled
                                : AppAssets.bookmarkSimple,
                            height: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DescriptionText extends StatefulWidget {
  final String description;
  final bool isExpanded;
  final VoidCallback onReadMore;

  const _DescriptionText({
    required this.description,
    required this.isExpanded,
    required this.onReadMore,
  });

  @override
  State<_DescriptionText> createState() => _DescriptionTextState();
}

class _DescriptionTextState extends State<_DescriptionText> {
  bool _isOverflowing = false;
  String _trimmedText = "";

  final TextStyle textStyle = const TextStyle(
    fontFamily: "Aptos",
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 1.4,
    letterSpacing: -0.065,
    color: Colors.black,
  );

  late final TextStyle linkStyle;

  @override
  void initState() {
    super.initState();

    linkStyle = textStyle.copyWith(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: AppColor.primary100,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _calculateTrimmedText();
  }

  @override
  void didUpdateWidget(covariant _DescriptionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.description != widget.description) {
      _calculateTrimmedText();
    }
  }

  void _calculateTrimmedText() {
    const readMore = "… Read more";

    final maxWidth = MediaQuery.of(context).size.width - 32;

    final textPainter = TextPainter(
      text: TextSpan(text: widget.description, style: textStyle),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth);

    if (!textPainter.didExceedMaxLines) {
      setState(() {
        _isOverflowing = false;
        _trimmedText = widget.description;
      });
      return;
    }

    final readMorePainter = TextPainter(
      text: TextSpan(text: readMore, style: linkStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );

    readMorePainter.layout(maxWidth: maxWidth);

    final position = textPainter.getPositionForOffset(
      Offset(maxWidth - readMorePainter.width, textPainter.height),
    );

    setState(() {
      _isOverflowing = true;
      _trimmedText = widget.description.substring(0, position.offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOverflowing) {
      return Text(widget.description, style: textStyle);
    }

    if (widget.isExpanded) {
      return RichText(
        text: TextSpan(
          style: textStyle,
          children: [
            TextSpan(text: widget.description),
            TextSpan(
              text: "  Read less",
              style: linkStyle,
              recognizer: TapGestureRecognizer()..onTap = widget.onReadMore,
            ),
          ],
        ),
      );
    }

    return RichText(
      text: TextSpan(
        style: textStyle,
        children: [
          TextSpan(text: _trimmedText),
          TextSpan(
            text: "… Read more",
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = widget.onReadMore,
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  final String iconPath;
  final int count;
  final VoidCallback? onTap;

  const _ActionItem({required this.iconPath, required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(iconPath, height: 20),
            const SizedBox(width: 6),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
