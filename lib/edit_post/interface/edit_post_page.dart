import 'package:coopebombas/colors.dart';
import 'package:coopebombas/edit_post/domain/edit_post_provider.dart';
import 'package:coopebombas/edit_post/domain/edit_post_states_enum.dart';
import 'package:coopebombas/main/main_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:route_animation_helper/route_animation_helper.dart';

class EditPostPage extends StatelessWidget {
  const EditPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final editPostProvider = Provider.of<EditPostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CooColors().cooBlue,
        elevation: 0,
        title: Text(
          'Editar publicación',
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ValueListenableBuilder(
            valueListenable: editPostProvider.editPostState,
            builder: (context, editPostState, child) {
              return editPostState == EditPostStatesEnum.bussy
                  ? Center(child: CircularProgressIndicator())
                  : editPostState == EditPostStatesEnum.error
                      ? Center(
                          child: Text(
                            'Hubo un error',
                            style: GoogleFonts.poppins(),
                          ),
                        )
                      : editPostState == EditPostStatesEnum.loaded
                          ? Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Editar titulo',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: CooColors().cooBlue,
                                      fontSize: 30,
                                    ),
                                  ),
                                  TextField(
                                    controller:
                                        editPostProvider.titleController.value,
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    'Editar cuerpo',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: CooColors().cooBlue,
                                      fontSize: 30,
                                    ),
                                  ),
                                  TextField(
                                    controller:
                                        editPostProvider.bodyController.value,
                                    maxLines: 10,
                                  ),
                                  SizedBox(
                                    height: 100,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      editPostProvider
                                          .updatePost(
                                              post:
                                                  editPostProvider.post.value!)
                                          .then(
                                        (value) {
                                          showPlatformDialog(
                                            context: context,
                                            builder: (context) =>
                                                BasicDialogAlert(
                                              title: Text("Discard draft?"),
                                              content: Text(
                                                  "Action cannot be undone."),
                                              actions: <Widget>[
                                                BasicDialogAction(
                                                  title: Text("Actualizar"),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      RouteAnimationHelper
                                                          .createRoute(
                                                        buildContext: context,
                                                        destination:
                                                            MainInjection
                                                                .injection(),
                                                        animType:
                                                            AnimType.slideStart,
                                                      ),
                                                    );
                                                  },
                                                ),
                                                BasicDialogAction(
                                                  title: Text("Cancelar"),
                                                  onPressed: () {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          'No se pudo actualizar',
                                                        ),
                                                      ),
                                                    );
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          80,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: CooColors().cooBlue,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Actualizar',
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.save,
                                            color: Colors.white,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            );
            },
          ),
        ),
      ),
    );
  }
}
