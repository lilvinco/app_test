class QuestionResponse {
  int? status;
  List<QuestionModel>? questionModel;

  QuestionResponse({this.status, this.questionModel});

  QuestionResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['payload'] != null) {
      questionModel = <QuestionModel>[];
      json['payload'].forEach((v) {
        questionModel!.add(QuestionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (questionModel != null) {
      data['payload'] = questionModel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionModel {
  int? id;
  int? userId;
  String? question;
  int? voteCount;
  int? upVoteCount;
  int? downVoteCount;
  bool? authUserAdded;
  bool? authUserCanVote;
  bool? authUserUpVoted;
  bool? authUserDownVoted;
  String? userName;
  String? userProfilePictureUrl;
  int? createdAtTimestamp;
  bool? isArtist;
  List<QuestionModel>? childQuestions;
  bool? authuserCanArchive;

  QuestionModel({
    this.id,
    this.userId,
    this.question,
    this.voteCount,
    this.authUserAdded,
    this.authUserCanVote,
    this.authUserUpVoted,
    this.authUserDownVoted,
    this.userName,
    this.isArtist,
    this.upVoteCount,
    this.downVoteCount,
    this.userProfilePictureUrl,
    this.createdAtTimestamp,
    this.childQuestions,
    this.authuserCanArchive,
  });

  QuestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    question = json['question'];
    voteCount = json['vote_count'];
    upVoteCount = json['upvote_count'];
    downVoteCount = json['downvote_count'];
    authUserAdded = json['auth_user_added'];
    authUserCanVote = json['auth_user_can_vote'];
    authUserUpVoted = json['auth_user_up_voted'];
    authUserDownVoted = json['auth_user_down_voted'];
    userName = json['user_name'];
    isArtist = json['is_artist'];
    authuserCanArchive = json['auth_user_can_archive'];
    userProfilePictureUrl = json['user_profile_picture_url'];
    createdAtTimestamp = json['created_at_timestamp'];
    if (json['answers'] != null) {
      childQuestions = <QuestionModel>[];
      json['answers'].forEach((v) {
        childQuestions!.add(QuestionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['question'] = question;
    data['vote_count'] = voteCount;
    data['upvote_count'] = upVoteCount;
    data['downvote_count'] = downVoteCount;
    data['auth_user_added'] = authUserAdded;
    data['auth_user_can_vote'] = authUserCanVote;
    data['auth_user_up_voted'] = authUserUpVoted;
    data['auth_user_down_voted'] = authUserDownVoted;
    data['auth_user_can_archive'] = authuserCanArchive;
    data['user_name'] = userName;
    data['is_artist'] = isArtist;
    data['user_profile_picture_url'] = userProfilePictureUrl;
    data['created_at_timestamp'] = createdAtTimestamp;
    if (childQuestions != null) {
      data['answers'] = childQuestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
