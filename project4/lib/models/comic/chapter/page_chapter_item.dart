class PageChapterItem {
  String id;
  String name;
  int? lastUpdatedDate;

  PageChapterItem({required this.id, required this.name});

  PageChapterItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        lastUpdatedDate = json['lastUpdatedDate'];
}
