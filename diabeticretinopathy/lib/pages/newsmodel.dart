//class model for the news, these variables are set so the request only collects the required data
class NewsModel {
  String title, imageUrl, content, description;
  NewsModel(
      {required this.title,
      required this.description,
      required this.content,
      required this.imageUrl});
  factory NewsModel.fromJson(Map<String, dynamic> jsonData) {
    return NewsModel(
      title: jsonData['title'] ?? "",
      description: jsonData['description'] ?? "",
      content: jsonData['content'] ?? "",
      imageUrl: jsonData['urlToImage'] ?? "",
    );
  }
}
