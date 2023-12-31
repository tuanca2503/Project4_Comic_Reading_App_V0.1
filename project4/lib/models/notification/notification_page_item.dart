class NotificationPageItem {
  String id;
  String action;
  bool isRead;
  String comicId;
  String comicName;
  String coverImage;
  int createdDate;

  NotificationPageItem(this.id, this.action, this.isRead, this.comicId,
      this.comicName, this.coverImage, this.createdDate);

  NotificationPageItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        action = json['action'],
        isRead = json['read'] ?? json['isRead'],
        comicId = json['mangaId'],
        comicName = json['mangaName'],
        coverImage = json['coverImage'],
        createdDate = json['createdDate'];
}