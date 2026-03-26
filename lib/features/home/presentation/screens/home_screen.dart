import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:upd8s/core/widgets/app_background.dart';
import 'package:upd8s/core/widgets/app_snackbar.dart';
import 'package:upd8s/features/home/presentation/widgets/home_top_bar.dart';
import 'package:upd8s/features/home/presentation/widgets/post_card/widget/post_card.dart';
import 'package:upd8s/features/profile/presentation/widgets/comment_bottom_sheet.dart';
import 'package:upd8s/routes/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> posts = [
    {
      "postId": "post_101",
      "schoolName": "St DunStans Primary",
      "time": "08:39 am",
      "description":
          "Our Annual Day was a spectacular celebration filled with performances and fun moments.",
      "schoolLogoUrl":
          "https://marketplace.canva.com/EAGdue2NOUs/1/0/1600w/canva-blue-and-yellow-modern-school-logo-meJ5KjyNVT4.jpg",
      "imageUrl":
          "https://c8.alamy.com/comp/DJ78B0/south-africa-cape-town-guguletu-township-intshinga-primary-school-DJ78B0.jpg",
      "likes": 1964,
      "comments": 135,
      "shares": 2,
    },
    {
      "postId": "post_102",
      "schoolName": "Green Valley School",
      "time": "09:15 am",
      "description":
          "We are one of the best international schools in Hyderabad  offering world-class education through effective programmes that promote academic excellence and holistic growth. We implement child-centric approaches in all initiatives at our campuses and adopt the best pedagogies to create a smoother and beautiful learning journey for our students.",
      "schoolLogoUrl":
          "https://marketplace.canva.com/EAGdue2NOUs/1/0/1600w/canva-blue-and-yellow-modern-school-logo-meJ5KjyNVT4.jpg",
      "imageUrl":
          "https://thumbs.dreamstime.com/b/percy-mdala-high-school-students-26581500.jpg",
      "likes": 820,
      "comments": 45,
      "shares": 10,
    },
    {
      "postId": "post_103",
      "schoolName": "Sunrise Public School",
      "time": "10:20 am",
      "description":
          "Our students had a great learning experience during the science center visit.",
      "schoolLogoUrl":
          "https://marketplace.canva.com/EAGdue2NOUs/1/0/1600w/canva-blue-and-yellow-modern-school-logo-meJ5KjyNVT4.jpg",
      "imageUrl":
          "https://groundup.org.za/media/uploads/images/Graphics/lisa_nelson/school-outside-small.jpg",
      "likes": 540,
      "comments": 22,
      "shares": 5,
    },
    {
      "postId": "post_104",
      "schoolName": "Bright Future Academy",
      "time": "11:05 am",
      "description":
          "A wonderful day with students learning teamwork and leadership.",
      "schoolLogoUrl":
          "https://marketplace.canva.com/EAGdue2NOUs/1/0/1600w/canva-blue-and-yellow-modern-school-logo-meJ5KjyNVT4.jpg",
      "imageUrl":
          "https://cdn.wisemove.co.za/image/blog/4a1aedd05ebf246f5243499e29f4d695.webp",
      "likes": 312,
      "comments": 18,
      "shares": 3,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: AppBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  HomeTopBar(
                    schoolName: "Hilton College",
                    logoUrl:
                        "https://marketplace.canva.com/EAGdue2NOUs/1/0/1600w/canva-blue-and-yellow-modern-school-logo-meJ5KjyNVT4.jpg",
                    onNotificationTap: () {
                      AppSnackbar.showWarning(
                        context,
                        'We’re working on this feature.',
                      );
                    },
                    onCreateTap: () {
                      context.pushNamed(AppRoute.createPost.name);
                    },
                    onFilterTap: () {
                      AppSnackbar.showWarning(
                        context,
                        'We’re working on this feature.',
                      );
                    },
                    onSearch: (value) {
                      AppSnackbar.showWarning(
                        context,
                        'We’re working on this feature.',
                      );
                    },
                    onLogoTap: () {
                      FocusScope.of(context).unfocus();
                      context.pushNamed(
                        AppRoute.profile.name,
                        queryParameters: {'isOwnProfile': 'true'},
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: PostCard(
                            postId: post["postId"],
                            schoolName: post["schoolName"],
                            time: post["time"],
                            description: post["description"],
                            schoolLogoUrl: post["schoolLogoUrl"],
                            imageUrl: post["imageUrl"],
                            likes: post["likes"],
                            comments: post["comments"],
                            shares: post["shares"],
                            isLiked: false,
                            isSaved: false,

                            onPostTap: (id) {
                              print("Open post details $id");
                              context.pushNamed(
                                AppRoute.profile.name,
                                queryParameters: {'isOwnProfile': 'false'},
                              );
                            },

                            onLikeTap: (id) {
                              print("Like API call for $id");
                            },
                            onBookmarkTap: (id) {
                              print("Save API call for $id");
                            },
                            onMoreTap: (id) {
                              print("More options for $id");
                              AppSnackbar.showWarning(
                                context,
                                'We’re working on this feature.',
                              );
                            },
                            onShareTap: (id) {
                              print("Share $id");
                              AppSnackbar.showWarning(
                                context,
                                'We’re working on this feature.',
                              );
                            },
                            onCommentTap: (id) {
                              print("Comment on $id");
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => const CommentsBottomSheet(),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
