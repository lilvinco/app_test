import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/base/base.dart';
import 'package:igroove_fan_box_one/constants/assets.dart';
import 'package:igroove_fan_box_one/core/services/comment_service.dart';
import 'package:igroove_fan_box_one/core/services/user_service.dart';
import 'package:igroove_fan_box_one/localization/localization.dart';
import 'package:igroove_fan_box_one/management/helper.dart';
import 'package:igroove_fan_box_one/model/assets_comments_model.dart';
import 'package:igroove_fan_box_one/model/question_model.dart';
import 'package:igroove_fan_box_one/ui/pages/common/error_alert.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentReplyWidgetParameters {
  final String assetID;
  final bool activateFanQuestions;
  final bool isArtist;
  final bool smallPadding;

  CommentReplyWidgetParameters({
    required this.assetID,
    required this.activateFanQuestions,
    this.smallPadding = false,
    this.isArtist = false,
  });
}

class CommentReplyWidget extends StatefulWidget {
  final CommentReplyWidgetParameters parameters;
  CommentReplyWidget({Key? key, required this.parameters}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CommentReplyWidgetState();
  }
}

class _CommentReplyWidgetState extends State<CommentReplyWidget> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  bool isLoading = false;
  List<Comments> comments = [];
  List<Widget> preparedList = [];
  String commentTextHeader = AppLocalizations().commentWriteCommentText!;
  final FocusNode _focusNode = FocusNode();
  String? selectedCommentID;
  int total = 0;
  String id = "0";
  bool isReplying = false;
  Function? opnReply;

  CommentService commentService = CommentService();

  @override
  void initState() {
    print('Is this an artist? ${widget.parameters.isArtist}');
    commentTextHeader = widget.parameters.activateFanQuestions
        ? AppLocalizations().commentWriteQuestionText!
        : AppLocalizations().commentWriteCommentText!;

    CommentService.streamControllerReplyTo.stream.listen((replyObject) {
      selectedCommentID = replyObject.parentID;
      commentController.text = replyObject.message;
      _focusNode.requestFocus();

      setState(() {
        isReplying = true;
        opnReply = replyObject.onReply;
      });
      commentService.setCommentFieldHasFocus(true);
    });
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (isPhoneVerificationOpen()) {
          _focusNode.unfocus();
          return;
        }
      }

      print("CommentHasFocus => ${_focusNode.hasFocus}");
      commentService.setCommentFieldHasFocus(_focusNode.hasFocus);
    });
    super.initState();
  }

  List<QuestionModel> questionList = [];
  int totalVotes = 0;

  addQuestion({required String question, String? parentID}) async {
    setState(() {
      isLoading = true;
    });

    UserService userService = Provider.of(context, listen: false);

    try {
      print('REPLY THROUGH THIS');
      RegisterResponse response = await userService.addFanQuestion(
          question: question, parentID: parentID);

      if (response.status == 1) {
        CommentService().updateShowCommentWidget();
        opnReply!();
      } else {
        await Navigator.pushNamed(
          context,
          AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
            title: AppLocalizations.of(context)!.generalDialogSorry!,
            message: response.message,
          ),
        );
      }
    } on DioError catch (e) {
      print(e.toString());

      await Navigator.pushNamed(context, AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
              title: AppLocalizations.of(context)!.generalDialogSorry!,
              message: e.toString()));
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  voteQuestion({required String id}) async {
    setState(() {
      isLoading = true;
    });

    UserService userService = Provider.of(context, listen: false);

    try {
      RegisterResponse response =
          await userService.addVoteToFanQuestion(questionID: id);

      if (response.status == 1) {
        //Todo
        //getQuestions();
      } else {
        await Navigator.pushNamed(context, AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message: response.message));
      }
    } on DioError catch (e) {
      print(e.toString());

      await Navigator.pushNamed(context, AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
              title: AppLocalizations.of(context)!.generalDialogSorry!,
              message: e.toString()));
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  setComment({required String comment, String? commentID}) async {
    UserService userService = Provider.of(context, listen: false);

    try {
      RegisterResponse response = await userService.setAssetComment(
          assetID: widget.parameters.assetID,
          comment: comment,
          parentID: commentID);

      if (response.status == 1) {
        setState(() {
          selectedCommentID = null;
          commentTextHeader = AppLocalizations().commentWriteCommentText!;
        });
        CommentService().updateShowCommentWidget();
      } else {
        await Navigator.pushNamed(context, AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message: response.message));
      }
    } on DioError catch (e) {
      print(e.toString());

      await Navigator.pushNamed(context, AppRoutes.errorAlert,
          arguments: ErrorAlertParams(
              title: AppLocalizations.of(context)!.generalDialogSorry!,
              message: e.toString()));
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (id != widget.parameters.assetID) {
      if (widget.parameters.activateFanQuestions) {
        setState(() {
          id = widget.parameters.assetID;
        });
      } else {
        setState(() {
          id = widget.parameters.assetID;
        });
      }
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(maxHeight: 500),
      color: IGrooveTheme.colors.black2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: IGrooveTheme.colors.white!.withOpacity(0.1),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: widget.parameters.smallPadding ? 15 : 40, top: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Flexible(
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      maxLines: 4,
                      minLines: 1,
                      focusNode: _focusNode,
                      cursorColor: IGrooveTheme.colors.grey4,
                      style: TextStyle(
                          fontSize: 14,
                          height: 18 / 14,
                          fontWeight: FontWeight.w400,
                          color: IGrooveTheme.colors.white!.withOpacity(0.5)),
                      controller: commentController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            commentController.text = "";
                            _focusNode.unfocus();
                            commentService.setCommentFieldHasFocus(false);
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 14,
                            color: IGrooveTheme.colors.black2,
                          ),
                        ),
                        suffixIconConstraints:
                            const BoxConstraints(maxHeight: 40, maxWidth: 40),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.5),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.5),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.5),
                        ),
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(21, 11, 21, 11),
                        labelText: commentTextHeader,
                        focusColor: IGrooveTheme.colors.white!.withOpacity(0.5),
                        fillColor: IGrooveTheme.colors.grey3,
                        filled: true,
                        labelStyle: TextStyle(
                            color: IGrooveTheme.colors.white!.withOpacity(0.5)),
                      ),
                      validator: (value) => value!.isEmpty
                          ? widget.parameters.activateFanQuestions
                              ? AppLocalizations()
                                  .commentQuestionValidationEmpty!
                              : AppLocalizations()
                                  .commentCommentValidationEmpty!
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    print('Is Artist:: ${widget.parameters.isArtist}');
                    print('Is Replying:: $isReplying');
                    if (widget.parameters.isArtist && !isReplying) {
                      unawaited(
                        Navigator.pushNamed(
                          context,
                          AppRoutes.errorAlert,
                          arguments: ErrorAlertParams(
                              title: AppLocalizations.of(context)!
                                  .artistCannotPostQuestionTitle!,
                              message: AppLocalizations.of(context)!
                                  .artistCannotPostQuestionTitle!),
                        ),
                      );
                      return;
                    }
                    if (isPhoneVerificationOpen()) {
                      return;
                    }
                    if (widget.parameters.activateFanQuestions) {
                      if (formKey.currentState!.validate()) {
                        print(commentController.text);
                        addQuestion(
                            question: commentController.text,
                            parentID: selectedCommentID);
                        commentController.clear();
                        _focusNode.unfocus();
                        commentService.setCommentFieldHasFocus(false);
                      } else {
                        print("Nicht gültig");
                      }
                    } else {
                      if (formKey.currentState!.validate()) {
                        print(commentController.text);
                        setComment(
                            comment: commentController.text,
                            commentID: selectedCommentID);
                        commentController.clear();
                        _focusNode.unfocus();
                        commentService.setCommentFieldHasFocus(false);
                        setState(() {
                          isReplying = false;
                        });
                      } else {
                        print("Nicht gültig");
                      }
                    }
                  },
                  child: SvgPicture.asset(
                    IGrooveAssets.svgSendCommentButtonIcon,
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
