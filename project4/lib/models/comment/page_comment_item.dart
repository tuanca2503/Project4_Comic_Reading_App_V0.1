class PageCommentItem {
  String id;
  String content;
  int lastUpdatedDate;
  String? parentCommentId;
  bool isOwnComment;
  String username;
  String? userAvatar;

  PageCommentItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        lastUpdatedDate = json['lastUpdatedDate'],
        parentCommentId = json['parentCommentId'],
        isOwnComment = json['isOwnComment'] ?? json['ownComment'],
        username = json['username'],
        userAvatar = json['userAvatar'];

}