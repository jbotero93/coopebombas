import 'package:coopebombas/colors.dart';
import 'package:coopebombas/common/models/post_model.dart';
import 'package:coopebombas/common/models/user_model.dart';
import 'package:coopebombas/select_post/domain/comment_state_enum.dart';
import 'package:coopebombas/select_post/domain/select_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SelectPostPage extends StatelessWidget {
  const SelectPostPage({
    super.key,
    required this.post,
    required this.user,
    required this.postUser,
  });

  final PostModel post;
  final UserModel user;
  final UserModel postUser;

  @override
  Widget build(BuildContext context) {
    final selectPostProvider = Provider.of<SelectPostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CooColors().cooBlue,
        elevation: 0,
        title: Text(
          '${post.title}',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.black54,
                          size: 50,
                        ),
                        Text(
                          (postUser.name ?? ''),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: CooColors().cooBlue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(
                          Icons.location_city_rounded,
                          color: Colors.black38,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          (postUser.name ?? ''),
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: CooColors().cooBlue,
                    ),
                    Text(
                      (post.title ?? ''),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      (post.body ?? ''),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(),
                    ),
                    Divider(
                      color: CooColors().cooBlue,
                    ),
                    Text(
                      'Comentarios',
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(
                      valueListenable: selectPostProvider.comments,
                      builder: (context, comments, snapshot) {
                        return ValueListenableBuilder(
                          valueListenable: selectPostProvider.commentStateEnum,
                          builder: (context, commentState, snapshot) {
                            return commentState == CommentStateEnum.filled
                                ? Column(
                                    children: comments!
                                        .map(
                                          (e) => Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: Colors.black12,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      color:
                                                          CooColors().cooBlue,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        (e.name ?? ''),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  (e.body ?? ''),
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  )
                                : Center(
                                    child:
                                        commentState == CommentStateEnum.bussy
                                            ? const CircularProgressIndicator()
                                            : Container(),
                                  );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
            /*Positioned(
              bottom: 20,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.send,
                        color: CooColors().cooBlue,
                      ),
                    ),
                  ),
                ),
              ),
            ) */
          ],
        ),
      ),
    );
  }
}
