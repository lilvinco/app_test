// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:igroove_fan_box_one/api/auth.dart';
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
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class ItemModel {
  String title;
  IconData icon;
  int id;
  ItemModel(this.title, this.icon, this.id);
}

class CommentShowWidgetParameters {
  final String assetID;
  final bool activateFanQuestions;
  final bool isArtist;
  final bool showOnlyAnswered;
  final bool orderByMostVoted;
  int? pageNumber;
  int? orderType;
  final Function()? onLoadComplete;
  final Function()? onLimitReached;
  final Function()? resetPageNumber;
  final Function()? resetLimitReached;

  // ignore: avoid_unused_constructor_parameters
  CommentShowWidgetParameters({
    required this.assetID,
    required this.activateFanQuestions,
    this.isArtist = false,
    this.showOnlyAnswered = false,
    this.orderByMostVoted = false,
    this.pageNumber,
    this.orderType,
    // initialize onLoadComplete
    required this.onLoadComplete,
    required this.onLimitReached,
    required this.resetLimitReached,
    required this.resetPageNumber,
  });
}

class CommentShowWidget extends StatefulWidget {
  final CommentShowWidgetParameters parameters;
  CommentShowWidget({Key? key, required this.parameters}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CommentShowWidgetState();
  }
}

class CommentShowWidgetState extends State<CommentShowWidget> {
  bool isLoading = false;
  int currentPage = 1;
  int queryOrder = 0;
  bool isChangingOrder = false;
  bool limitReached = false;
  List<Comments> comments = [];
  List<Widget> preparedList = [];
  String commentTextHeader = AppLocalizations().commentWriteCommentText!;
  String? selectedCommentID;
  int total = 0;
  String id = "0";
  CommentService commentService = CommentService();
  List<QuestionModel> questionList = [];
  int totalVotes = 0;
  bool initialLoading = true;
  StreamController<bool>? updateComments =
      CommentService().streamControllerUpdateShowCommentWidget;
  StreamSubscription? subscription;
  Function? onReply;
  Duration refreshInterval = const Duration(seconds: 10);
  Timer? timer;

  getNewData() {
    if (mounted) {
      if (widget.parameters.activateFanQuestions) {
        getQuestions();
      } else {
        getComments();
      }
    }
  }

  onLikeUnlike() {
    // Reorder the questionList so the ones with most likes come first
    questionList.sort((a, b) => b.upVoteCount!.compareTo(a.upVoteCount!));
  }

  onItemSelected(int orderType) async {
    setState(() => queryOrder = orderType);
    setState(() => isChangingOrder = true);
    widget.parameters.resetPageNumber!();
    widget.parameters.resetLimitReached!();

    if (widget.parameters.activateFanQuestions) {
      setState(() => questionList = []);
      await getQuestions();
    } else {
      setState(() => comments = []);
      await getComments();
    }
    setState(() => isChangingOrder = false);
  }

  bool newElementWasSet = false;

  @override
  void initState() {
    super.initState();
    setState(() => queryOrder = widget.parameters.orderType ?? 1);
    timer = Timer.periodic(refreshInterval, (Timer t) {
      if (!widget.parameters.activateFanQuestions) {
        print('Getting answered questions');
        print('Getting comments');
        refreshComments();
      }
    });
    getNewData();
    commentTextHeader = widget.parameters.activateFanQuestions
        ? AppLocalizations().commentWriteQuestionText!
        : AppLocalizations().commentWriteCommentText!;
    subscription = updateComments?.stream.listen((update) {
      if (widget.parameters.activateFanQuestions) {
        setState(() {
          //questionList = [];
        });
      } else {
        setState(() {
          //comments = [];
        });
      }
      setState(() {
        newElementWasSet = true;
      });

      getNewData();
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    timer?.cancel();
    super.dispose();
  }

  resetOrder(int newOrder) async {
    setState(() => queryOrder = newOrder);
    setState(() {});
  }

  resetQuestions() {
    setState(() {
      isLoading = true;
      questionList = [];
      preparedList = [];
    });
  }

  resetComments() {
    setState(() => queryOrder = 0);
    setState(() {
      isLoading = true;
      comments = [];
      preparedList = [];
    });
  }

  getQuestions() async {
    setState(() {
      isLoading = true;
    });
    await Auth.check();

    UserService userService = Provider.of(context, listen: false);
    try {
      QuestionResponse response = await userService.getFanQuestions(
        pageNumber: widget.parameters.pageNumber,
        type: widget.parameters.showOnlyAnswered ? 2 : 1,
        order: queryOrder,
      );

      if (response.status == 1) {
        widget.parameters.onLoadComplete!();
        if (response.questionModel == null || response.questionModel!.isEmpty) {
          widget.parameters.onLimitReached!();
          return;
        }
        if (response.questionModel!.length < 10) {
          widget.parameters.onLimitReached!();
        }
        totalVotes = 0;
        for (QuestionModel question in response.questionModel!) {
          totalVotes += question.voteCount!;
          questionList.add(question);
        }
        prepareList();
      } else {
        await Navigator.pushNamed(context, AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message:
                    AppLocalizations.of(context)!.generalDialogSorryText!));
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
      setState(() {
        isLoading = false;
        initialLoading = false;
      });
    }
  }

  voteQuestion({required String id, int type = 1}) async {
    setState(() {
      isLoading = true;
    });

    bool isSubELement = false;
    int indexOfElement =
        questionList.indexWhere((element) => element.id.toString() == id);

    int indexOfSubElement = -1;
    if (indexOfElement == -1) {
      for (var question in questionList) {
        if (question.childQuestions!.isNotEmpty) {
          indexOfSubElement = question.childQuestions!
              .indexWhere((element) => element.id.toString() == id);

          if (indexOfSubElement != -1) {
            isSubELement = true;
            indexOfElement =
                questionList.indexWhere((element) => element.id == question.id);
          }
        }
        if (isSubELement) {
          break;
        }
      }
    }

    if (!isSubELement) {
      setState(() {
        if (type == 1) {
          // likes
          if (questionList[indexOfElement].authUserDownVoted!) {
            questionList[indexOfElement].authUserDownVoted = false;
            questionList[indexOfElement].downVoteCount =
                questionList[indexOfElement].downVoteCount! - 1;
            questionList[indexOfElement].voteCount =
                questionList[indexOfElement].voteCount! + 1;
          }

          if (questionList[indexOfElement].authUserUpVoted!) {
            questionList[indexOfElement].authUserUpVoted = false;
            questionList[indexOfElement].upVoteCount =
                questionList[indexOfElement].upVoteCount! - 1;
            questionList[indexOfElement].voteCount =
                questionList[indexOfElement].voteCount! - 1;
          } else {
            questionList[indexOfElement].authUserUpVoted = true;
            questionList[indexOfElement].upVoteCount =
                questionList[indexOfElement].upVoteCount! + 1;
            questionList[indexOfElement].voteCount =
                questionList[indexOfElement].voteCount! + 1;
          }
        } else {
          // dislike
          if (questionList[indexOfElement].authUserUpVoted!) {
            questionList[indexOfElement].authUserUpVoted = false;
            questionList[indexOfElement].upVoteCount =
                questionList[indexOfElement].upVoteCount! - 1;
            questionList[indexOfElement].voteCount =
                questionList[indexOfElement].voteCount! - 1;
          }

          if (questionList[indexOfElement].authUserDownVoted!) {
            questionList[indexOfElement].authUserDownVoted = false;
            questionList[indexOfElement].downVoteCount =
                questionList[indexOfElement].downVoteCount! - 1;
            questionList[indexOfElement].voteCount =
                questionList[indexOfElement].voteCount! + 1;
          } else {
            questionList[indexOfElement].authUserDownVoted = true;
            questionList[indexOfElement].downVoteCount =
                questionList[indexOfElement].downVoteCount! + 1;
            questionList[indexOfElement].voteCount =
                questionList[indexOfElement].voteCount! - 1;
          }
        }
      });
    } else {
      setState(() {
        if (type == 1) {
          // likes
          if (questionList[indexOfElement]
              .childQuestions![indexOfSubElement]
              .authUserDownVoted!) {
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .authUserDownVoted = false;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .downVoteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .downVoteCount! -
                1;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .voteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .voteCount! +
                1;
          }

          if (questionList[indexOfElement]
              .childQuestions![indexOfSubElement]
              .authUserUpVoted!) {
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .authUserUpVoted = false;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .upVoteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .upVoteCount! -
                1;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .voteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .voteCount! -
                1;
          } else {
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .authUserUpVoted = true;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .upVoteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .upVoteCount! +
                1;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .voteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .voteCount! +
                1;
          }
        } else {
          // dislike
          if (questionList[indexOfElement]
              .childQuestions![indexOfSubElement]
              .authUserUpVoted!) {
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .authUserUpVoted = false;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .upVoteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .upVoteCount! -
                1;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .voteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .voteCount! -
                1;
          }

          if (questionList[indexOfElement]
              .childQuestions![indexOfSubElement]
              .authUserDownVoted!) {
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .authUserDownVoted = false;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .downVoteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .downVoteCount! -
                1;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .voteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .voteCount! +
                1;
          } else {
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .authUserDownVoted = true;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .downVoteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .downVoteCount! +
                1;
            questionList[indexOfElement]
                .childQuestions![indexOfSubElement]
                .voteCount = questionList[indexOfElement]
                    .childQuestions![indexOfSubElement]
                    .voteCount! -
                1;
          }
        }
      });
    }
    onLikeUnlike();

    prepareList();

    UserService userService = Provider.of(context, listen: false);

    try {
      RegisterResponse response =
          await userService.addVoteToFanQuestion(questionID: id, type: type);

      if (response.status == 1) {
        //getQuestions();
        // onLikeUnlike();
      } else {
        await Navigator.pushNamed(context, AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message: response.message));
      }
    } on DioError catch (e) {
      print(e.toString());

      await Navigator.pushNamed(
        context,
        AppRoutes.errorAlert,
        arguments: ErrorAlertParams(
            title: AppLocalizations.of(context)!.generalDialogSorry!,
            message: e.toString()),
      );
    } catch (e, stacktrace) {
      print(e.toString());
      print(stacktrace.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  likeComment(
      {required String assetId,
      required String commentId,
      int type = 1}) async {
    setState(() => isLoading = true);
    bool isSubELement = false;
    int indexOfElement =
        comments.indexWhere((element) => element.id.toString() == commentId);

    int indexOfSubElement = -1;
    if (indexOfElement == -1) {
      for (var comment in comments) {
        if (comment.childComments!.isNotEmpty) {
          indexOfSubElement = comment.childComments!
              .indexWhere((element) => element.id.toString() == commentId);

          if (indexOfSubElement != -1) {
            isSubELement = true;
            indexOfElement =
                comments.indexWhere((element) => element.id == comment.id);
          }
        }
        if (isSubELement) {
          break;
        }
      }
    }

    if (!isSubELement) {
      setState(() {
        if (type == 1) {
          // likes
          if (comments[indexOfElement].authUserDisliked!) {
            comments[indexOfElement].authUserDisliked = false;
            comments[indexOfElement].statistics!.dislikes =
                comments[indexOfElement].statistics!.dislikes! - 1;
          }

          if (comments[indexOfElement].authUserLiked!) {
            comments[indexOfElement].authUserLiked = false;
            comments[indexOfElement].statistics!.likes =
                comments[indexOfElement].statistics!.likes! - 1;
          } else {
            comments[indexOfElement].authUserLiked = true;
            comments[indexOfElement].statistics!.likes =
                comments[indexOfElement].statistics!.likes! + 1;
          }
        } else {
          // dislike
          if (comments[indexOfElement].authUserLiked!) {
            comments[indexOfElement].authUserLiked = false;
            comments[indexOfElement].statistics!.likes =
                comments[indexOfElement].statistics!.likes! - 1;
          }

          if (comments[indexOfElement].authUserDisliked!) {
            comments[indexOfElement].authUserDisliked = false;
            comments[indexOfElement].statistics!.dislikes =
                comments[indexOfElement].statistics!.dislikes! - 1;
          } else {
            comments[indexOfElement].authUserDisliked = true;
            comments[indexOfElement].statistics!.dislikes =
                comments[indexOfElement].statistics!.dislikes! + 1;
          }
        }
      });
    } else {
      setState(() {
        if (type == 1) {
          // likes

          if (comments[indexOfElement]
              .childComments![indexOfSubElement]
              .authUserDisliked!) {
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .authUserDisliked = false;
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .statistics!
                .dislikes = comments[indexOfElement]
                    .childComments![indexOfSubElement]
                    .statistics!
                    .dislikes! -
                1;
          }

          if (comments[indexOfElement]
              .childComments![indexOfSubElement]
              .authUserLiked!) {
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .authUserLiked = false;
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .statistics!
                .likes = comments[indexOfElement]
                    .childComments![indexOfSubElement]
                    .statistics!
                    .likes! -
                1;
          } else {
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .authUserLiked = true;
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .statistics!
                .likes = comments[indexOfElement]
                    .childComments![indexOfSubElement]
                    .statistics!
                    .likes! +
                1;
          }
        } else {
          // dislike
          if (comments[indexOfElement]
              .childComments![indexOfSubElement]
              .authUserLiked!) {
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .authUserLiked = false;
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .statistics!
                .likes = comments[indexOfElement]
                    .childComments![indexOfSubElement]
                    .statistics!
                    .likes! -
                1;
          }

          if (comments[indexOfElement]
              .childComments![indexOfSubElement]
              .authUserDisliked!) {
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .authUserDisliked = false;
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .statistics!
                .dislikes = comments[indexOfElement]
                    .childComments![indexOfSubElement]
                    .statistics!
                    .dislikes! -
                1;
          } else {
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .authUserDisliked = true;
            comments[indexOfElement]
                .childComments![indexOfSubElement]
                .statistics!
                .dislikes = comments[indexOfElement]
                    .childComments![indexOfSubElement]
                    .statistics!
                    .dislikes! +
                1;
          }
        }
      });
    }

    prepareList();

    UserService userService = Provider.of(context, listen: false);

    try {
      RegisterResponse response = await userService.addLikeToComment(
          assetID: assetId, commentID: commentId, type: type);

      if (response.status == 1) {
        //getComments();
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

  refreshComments() async {
    UserService userService = Provider.of(context, listen: false);
    debugPrint('QUerying in order: $queryOrder');
    AssetsCommentResponse response = await userService.getAssetComment(
      assetID: widget.parameters.assetID,
      from: 1,
      pageNumber: !newElementWasSet ? widget.parameters.pageNumber : 0,
      order: queryOrder,
    );
    comments = response.payload!.comments!;
    total = response.totalComments!;
    setState(() {});
    prepareList();
  }

  getComments() async {
    setState(() {
      isLoading = true;
    });

    await Auth.check();
    selectedCommentID = null;

    UserService userService = Provider.of(context, listen: false);
    debugPrint('QUerying in order: $queryOrder');

    try {
      AssetsCommentResponse response = await userService.getAssetComment(
        assetID: widget.parameters.assetID,
        pageNumber: !newElementWasSet ? widget.parameters.pageNumber : 0,
        order: queryOrder,
      );
      setState(() => total = response.totalComments!);
      if (response.status == 1) {
        widget.parameters.onLoadComplete!();
        if (response.payload?.comments == null) {
          widget.parameters.onLimitReached!();
          return;
        }
        if (newElementWasSet) {
          comments = [];
          int lastListwasNotFull = response.payload!.comments!.length % 10;
          comments.addAll(response.payload!.comments!.getRange(
              0,
              lastListwasNotFull != 0
                  ? response.payload!.comments!.length
                  : widget.parameters.pageNumber! * 10));

          newElementWasSet = false;
        } else {
          List<Comments> _newComments = response.payload?.comments ?? [];
          if (_newComments.isEmpty || _newComments.length < 10) {
            widget.parameters.onLimitReached!();
          }
          comments.addAll(_newComments);
        }

        prepareList();
      } else {
        await Navigator.pushNamed(context, AppRoutes.errorAlert,
            arguments: ErrorAlertParams(
                title: AppLocalizations.of(context)!.generalDialogSorry!,
                message:
                    AppLocalizations.of(context)!.generalDialogSorryText!));
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
      setState(() {
        isLoading = false;
        initialLoading = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (initialLoading && isLoading) {
      // if (isLoading) {
      return Padding(
        padding: const EdgeInsets.only(top: 150),
        child: loadingWidget(),
      );
    }
    // if (isLoading) {
    //   // if (isLoading) {
    //   return Padding(
    //     padding: const EdgeInsets.only(top: 150),
    //     child: loadingWidget(),
    //   );
    // }

    return Container(
      color: IGrooveTheme.colors.black2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: !widget.parameters.activateFanQuestions
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        singular(
                            raw: total,
                            formatted: total.toString(),
                            plural:
                                AppLocalizations.of(context)!.generalComments!,
                            singular:
                                AppLocalizations.of(context)!.generalComment!),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: IGrooveTheme.colors.white),
                      ),
                      PopupMenuButton<int>(
                        color: const Color(0XFF4C4C4C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        icon: SvgPicture.asset(IGrooveAssets.filterSvg),
                        onSelected: (value) => onItemSelected(value),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<int>>[
                          PopupMenuItem(
                            value: 0,
                            child: Text(
                              AppLocalizations.of(context)!.orderByLikes!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: queryOrder == 0
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Text(
                              AppLocalizations.of(context)!.orderByNewest,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: queryOrder == 1
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
          if (isChangingOrder)
            Container(
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Text(
                '${AppLocalizations.of(context)!.refreshingFeed}...',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 12,
                ),
              )),
            ),
          ...preparedList,
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  List<CustomPopupMenuController> controllerList = [];

  Widget userComment({
    Comments? comment,
    QuestionModel? question,
    bool showLikes = false,
    required double leftSpace,
    required bool allowReply,
    Comments? parentComment,
    bool hideVotes = false,
    bool isArtist = false,
  }) {
    DateTime commentDate = DateTime.fromMillisecondsSinceEpoch(
      ((comment != null
              ? comment.createdAtTimestamp!
              : question!.createdAtTimestamp!) *
          1000),
    );
    DateTime today = DateTime.now();
    int differenceInMilliseconds = today.difference(commentDate).inMilliseconds;
    DateTime commentAgo = DateTime.now()
        .subtract(Duration(milliseconds: differenceInMilliseconds));
    timeago.setLocaleMessages('de', timeago.DeMessages());
    String timeAgoString = timeago.format(commentAgo, locale: 'de');
    timeAgoString = timeAgoString.replaceAll("~", "");

    // Get username to highlight
    String? mentionedUserName;
    String shownComment =
        comment != null ? comment.comment! : question!.question!;

    int indexOfAt = shownComment.indexOf('@');
    int indexOfSpace = shownComment.indexOf(' ');
    if (indexOfSpace - indexOfAt > 3 && indexOfAt == 0 && indexOfSpace > 0) {
      mentionedUserName = shownComment.substring(indexOfAt, indexOfSpace);
      shownComment = shownComment.replaceAll(mentionedUserName, '');
      print("Username=> $mentionedUserName");
    }

    controllerList.add(CustomPopupMenuController());

    return Padding(
      padding: EdgeInsets.fromLTRB(leftSpace, 0.0, 0.0, 10.0),
      child: ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        color: comment?.userId ==
                                    UserService.userData!.payload!.user!.id ||
                                question?.userName ==
                                    UserService
                                        .userData!.payload!.user!.userName
                            ? IGrooveTheme.colors.goldDark
                            : IGrooveTheme.colors.grey3),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: CachedNetworkImage(
                                      imageUrl: comment != null
                                          ? comment.userProfilePictureUrl!
                                          : question!.userProfilePictureUrl!,
                                      fit: BoxFit.cover,
                                      placeholder: (BuildContext context,
                                              String url) =>
                                          Center(
                                              child: CircularProgressIndicator(
                                        backgroundColor:
                                            IGrooveTheme.colors.white4,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color?>(
                                                IGrooveTheme.colors.grey12),
                                      )),
                                      errorWidget: (BuildContext context,
                                              String url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment != null
                                          ? comment.userName!
                                          : question!.userName!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                          height: 13 / 13,
                                          color: IGrooveTheme.colors.white),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      timeAgoString,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          height: 12 / 12,
                                          color: IGrooveTheme.colors.white!
                                              .withOpacity(0.75)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (question != null && hideVotes == false)
                              Column(
                                children: [
                                  Text(question.voteCount.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: IGrooveTheme.colors.white!,
                                        height: 36 / 30,
                                        letterSpacing: -1.2,
                                        fontSize: 30,
                                      )),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .commentVotes!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: IGrooveTheme.colors.white!
                                            .withOpacity(0.75),
                                        height: 18 / 13,
                                        fontSize: 13,
                                      )),
                                ],
                              ),
                          ],
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 3),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(children: <TextSpan>[
                                        if (mentionedUserName != null)
                                          TextSpan(
                                            text: mentionedUserName,
                                            style: TextStyle(
                                                color:
                                                    IGrooveTheme.colors.gold2,
                                                fontSize: 13,
                                                height: 18 / 13,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        TextSpan(
                                          text: shownComment,
                                          style: TextStyle(
                                              color: IGrooveTheme.colors.white,
                                              fontSize: 13,
                                              height: 18 / 13,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        if (!widget.parameters.showOnlyAnswered || showLikes)
                          GestureDetector(
                            onTap: () {
                              if (isPhoneVerificationOpen()) {
                                return;
                              }
                              if (question != null) {
                                voteQuestion(
                                    id: question.id.toString(), type: 1);
                              } else {
                                likeComment(
                                  assetId: widget.parameters.assetID,
                                  commentId: comment!.id.toString(),
                                  type: 1,
                                );
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  ((question != null &&
                                              question.authUserUpVoted!) ||
                                          (comment != null &&
                                              comment.authUserLiked!))
                                      ? IGrooveAssets.svglikeFilledIcon
                                      : IGrooveAssets.svgthumbUpTransparentIcon,
                                  width: 15,
                                  height: 15,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  question != null
                                      ? question.upVoteCount.toString()
                                      : comment!.statistics!.likes!.toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      height: 13 / 13,
                                      color: IGrooveTheme.colors.white!
                                          .withOpacity(0.75),
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 20,
                        ),
                        if (!widget.parameters.showOnlyAnswered || showLikes)
                          GestureDetector(
                            onTap: () {
                              if (isPhoneVerificationOpen()) {
                                return;
                              }
                              if (question != null) {
                                voteQuestion(
                                    id: question.id.toString(), type: -1);
                              } else {
                                likeComment(
                                    assetId: widget.parameters.assetID,
                                    commentId: comment!.id.toString(),
                                    type: -1);
                              }
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationX(math.pi),
                                  child: SvgPicture.asset(
                                    ((question != null &&
                                                question.authUserDownVoted!) ||
                                            (comment != null &&
                                                comment.authUserDisliked!))
                                        ? IGrooveAssets.svglikeFilledIcon
                                        : IGrooveAssets
                                            .svgthumbUpTransparentIcon,
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  question != null
                                      ? question.downVoteCount.toString()
                                      : comment!.statistics!.dislikes!
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      height: 13 / 13,
                                      color: IGrooveTheme.colors.white!
                                          .withOpacity(0.75),
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        const SizedBox(
                          width: 20,
                        ),
                        if (allowReply || isArtist)
                          GestureDetector(
                              onTap: () {
                                if (isPhoneVerificationOpen()) {
                                  return;
                                }

                                String message = "";
                                if (comment != null) {
                                  message = "@${comment.userName!} ";
                                } else {
                                  message = "";
                                }

                                String commentID = parentComment != null
                                    ? parentComment.id.toString()
                                    : comment != null
                                        ? comment.id!.toString()
                                        : question!.id.toString();

                                CommentService.replyTo(
                                  replyObject: ReplyToObject(
                                      message: message,
                                      parentID: commentID,
                                      onReply: () {
                                        if (question != null) {
                                          print('Removing Question');
                                          questionList.remove(question);
                                          prepareList();
                                        }
                                      }),
                                );
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Text(
                                  AppLocalizations.of(context)!.commentReply!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      height: 13 / 13,
                                      color: IGrooveTheme.colors.white,
                                      letterSpacing: 0))),
                        const Spacer(),
                        if (UserService.userData!.payload!.user!.id ==
                                comment?.userId ||
                            UserService.userData!.payload!.user!.id ==
                                question?.userId ||
                            UserService.userData!.payload!.user!.isArtist! ||
                            (question?.isArtist == false ||
                                    comment?.isArtist == false) &&
                                (!widget.parameters.showOnlyAnswered &&
                                        question?.isArtist == false ||
                                    comment?.isArtist == false))
                          Container(
                            height: 18,
                            width: 18,
                            child: optionMenu(
                                isComment: comment != null ? true : false,
                                comment: comment,
                                question: question,
                                onArchive: () {
                                  if (comment != null) {
                                    comments.remove(comment);
                                    prepareList();
                                  } else {
                                    questionList.remove(question);
                                  }
                                  prepareList();
                                }),
                          ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget optionMenu({
    required bool isComment,
    Comments? comment,
    QuestionModel? question,
    Function? onArchive,
  }) {
    return PopupMenuButton<int>(
      //iconSize: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: const Color(0XFF4C4C4C),
      icon: SvgPicture.asset(
        IGrooveAssets.svgIconOptionMenuIcon,
        //width: 16,
        //height: 4,
      ),
      padding: const EdgeInsets.all(0),
      onSelected: (value) async {
        if (value == 0) {
          UserService userService = Provider.of(context, listen: false);
          if (isComment) {
            await userService.archiveComment(
                assetID: widget.parameters.assetID, commentID: comment!.id!);
          } else {
            await userService.archiveQuestion(questionID: question!.id!);
          }
          onArchive!();
        } else if (value == 1) {
          UserService userService = Provider.of(context, listen: false);
          if (isComment) {
            await userService.reportComment(
                commentID: comment!.id!, assetID: widget.parameters.assetID);
            return;
          } else {
            await userService.reportQuestion(questionID: question!.id!);
            return;
          }
        } else if (value == 2) {
          UserService userService = Provider.of(context, listen: false);
          if (isComment) {
            await userService.reportComment(
                commentID: comment!.id!,
                assetID: widget.parameters.assetID,
                reportType: 1);
            return;
          } else {
            await userService.reportQuestion(
                questionID: question!.id!, reportType: 1);
            return;
          }
        }
        getNewData();
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        if (UserService.userData!.payload!.user!.id == comment?.userId ||
            UserService.userData!.payload!.user!.id == question?.userId ||
            UserService.userData!.payload!.user!.isArtist!)
          PopupMenuItem(
            value: 0,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.auto_delete_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        AppLocalizations().generalArchive!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if ((question?.isArtist == false || comment?.isArtist == false) &&
            UserService.userData!.payload!.user!.id != question?.userId &&
            UserService.userData!.payload!.user!.id != comment?.userId)
          PopupMenuItem(
            value: 1,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.flag_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        AppLocalizations().generalReportContent!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if ((question?.isArtist == false || comment?.isArtist == false) &&
            UserService.userData!.payload!.user!.id != question?.userId &&
            UserService.userData!.payload!.user!.id != comment?.userId)
          PopupMenuItem(
            value: 2,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Icons.people_alt_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        AppLocalizations().generalReportUser!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  prepareList() {
    preparedList = [];

    if (widget.parameters.activateFanQuestions) {
      if (widget.parameters.showOnlyAnswered) {
        for (QuestionModel questions in questionList) {
          if (questions.childQuestions!.isNotEmpty) {
            preparedList.add(userComment(
              question: questions,
              leftSpace: 2,
              allowReply: widget.parameters.isArtist,
            ));

            for (QuestionModel subQuestion in questions.childQuestions!) {
              preparedList.add(userComment(
                  question: subQuestion,
                  showLikes: true,
                  leftSpace: 52,
                  allowReply: false,
                  isArtist: false,
                  hideVotes: true));
            }
          }
        }
        setState(() {});

        return;
      }

      if (widget.parameters.orderByMostVoted) {
        for (QuestionModel questions in questionList) {
          if (questions.childQuestions!.isEmpty) {
            //total += 1;
            preparedList.add(userComment(
              question: questions,
              leftSpace: 2,
              allowReply: widget.parameters.isArtist,
            ));
          }
        }
        setState(() {});

        return;
      }
    }

    for (Comments comment in comments) {
      //total += 1;
      preparedList.add(userComment(
        comment: comment,
        leftSpace: 2,
        allowReply: true,
      ));

      if (comment.childComments != null && comment.childComments!.isNotEmpty) {
        preparedList.add(
          Padding(
            padding: const EdgeInsets.only(left: 76.0, bottom: 10),
            child: Row(
              children: [
                SvgPicture.asset(
                  IGrooveAssets.svgturnNIcon,
                  width: 11,
                  height: 11,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  comment.childComments!.length.toString() +
                      " " +
                      AppLocalizations.of(context)!.commentReply!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0,
                    color: IGrooveTheme.colors.white,
                  ),
                ),
              ],
            ),
          ),
        );

        for (Comments subComment in comment.childComments!) {
          // total += 1;
          preparedList.add(userComment(
              comment: subComment,
              leftSpace: 52,
              allowReply: true,
              parentComment: comment));
        }
      }
    }
    setState(() {});
  }
}
