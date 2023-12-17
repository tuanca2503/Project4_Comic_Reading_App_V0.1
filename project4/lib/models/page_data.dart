class PageData<T> {
  List<T> data = [];
  int totalPages;
  int totalElements;
  bool hasNext;

  PageData({
    required this.data,
    required this.totalPages,
    required this.totalElements,
    required this.hasNext,
  });

  PageData.empty()
      : data = [],
        totalPages = 0,
        totalElements = 0,
        hasNext = false;

  PageData.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT)
      : data = (json['data'] as List).map((itemJson) => fromJsonT(itemJson)).toList(),
        totalPages = json['totalPages'],
        totalElements = json['totalElements'],
        hasNext = json['hasNext'];
}