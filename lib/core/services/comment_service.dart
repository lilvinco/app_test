import 'dart:async';

class CommentService {
  static final CommentService _commentService = CommentService._internal();
  StreamController<bool> streamControllerUpdateShowCommentWidget =
      StreamController.broadcast();
  static StreamController<ReplyToObject> streamControllerReplyTo =
      StreamController.broadcast();

  static bool commentFieldHasFocus = false;

  factory CommentService() {
    return _commentService;
  }

  CommentService._internal();

  updateShowCommentWidget() {
    streamControllerUpdateShowCommentWidget.add(true);
  }

  setCommentFieldHasFocus(bool hasFocus) {
    commentFieldHasFocus = hasFocus;
  }

  static replyTo({required ReplyToObject replyObject}) {
    streamControllerReplyTo.add(replyObject);
  }
}

class ReplyToObject {
  String parentID;
  String message;
  Function? onReply;
  ReplyToObject({
    required this.message,
    required this.parentID,
    this.onReply,
  });
}
