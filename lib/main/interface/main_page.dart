import 'package:coopebombas/colors.dart';
import 'package:coopebombas/common/models/user_model.dart';
import 'package:coopebombas/main/domain/main_provider.dart';
import 'package:coopebombas/main/domain/posts_states_enum.dart';
import 'package:coopebombas/main/interface/widgets/post_widget.dart';
import 'package:coopebombas/profile/profile_injection.dart';
import 'package:coopebombas/select_post/select_post_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:route_animation_helper/route_animation_helper.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/icon.png',
              fit: BoxFit.fitHeight,
              height: 50,
            ),
            Text(
              'Poster',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  RouteAnimationHelper.createRoute(
                    buildContext: context,
                    destination: ProfileInjection.injection(
                      user: mainProvider.user.value!,
                    ),
                    animType: AnimType.size,
                  ),
                );
              },
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: CooColors().cooBlue,
      body: ValueListenableBuilder(
        valueListenable: mainProvider.postsStateEnum,
        builder: (context, postsState, snapshot) {
          return postsState == PostsStates.bussy
              ? CircularProgressIndicator()
              : postsState == PostsStates.empty
                  ? Text(
                      'No hay públicaciones para mostrar',
                      style: GoogleFonts.poppins(),
                    )
                  : postsState == PostsStates.errorRed
                      ? Text(
                          'Hay un problema en la conexión',
                          style: GoogleFonts.poppins(),
                        )
                      : postsState == PostsStates.none
                          ? Text(
                              'Actualiza',
                              style: GoogleFonts.poppins(),
                            )
                          : ValueListenableBuilder(
                              valueListenable: mainProvider.posts,
                              builder: (context, posts, snapshot) {
                                return RefreshIndicator(
                                  key: mainProvider.refresKey.value,
                                  onRefresh: () => mainProvider.getPosts(),
                                  child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: posts?.length,
                                    itemBuilder: (context, index) {
                                      final postUser = mainProvider.getUserById(
                                        userId: (posts![index].userId ?? 0),
                                      );
                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            RouteAnimationHelper.createRoute(
                                              buildContext: context,
                                              destination:
                                                  SelectPostInjection.injection(
                                                post: posts[index],
                                                user: mainProvider.user.value!,
                                                postUser: postUser,
                                              ),
                                              animType: AnimType.size,
                                            ),
                                          );
                                        },
                                        child: PostWidget(
                                          postUser: postUser!,
                                          user: mainProvider.user.value!,
                                          post: posts[index],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            );
        },
      ),
    );
  }
}
