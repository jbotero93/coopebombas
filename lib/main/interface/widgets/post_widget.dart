import 'package:coopebombas/colors.dart';
import 'package:coopebombas/common/models/post_model.dart';
import 'package:coopebombas/common/models/user_model.dart';
import 'package:coopebombas/edit_post/edit_post_injection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:route_animation_helper/route_animation_helper.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.postUser,
    required this.post,
    required this.user,
  });

  final UserModel postUser;
  final PostModel post;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.person,
                color: CooColors().cooBlue,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                (postUser.name ?? ''),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: CooColors().cooBlue,
                ),
              ),
              postUser.id == user.id
                  ? Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  RouteAnimationHelper.createRoute(
                                    buildContext: context,
                                    destination: EditPostInjection.injection(
                                      id: post.id!,
                                    ),
                                    animType: AnimType.size,
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.edit,
                                color: CooColors().cooBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_city_rounded,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                (postUser.address!.city ?? ''),
                style: GoogleFonts.poppins(
                  color: Colors.black45,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Divider(),
          Text(
            (post.title ?? ''),
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            (post.body ?? ''),
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(),
          ),
          Divider(),
          Text(
            (postUser.company!.name ?? ''),
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: CooColors().cooBlue,
            ),
          ),
        ],
      ),
    );
  }
}
