class NewsNewCnn {
    bool success;
    dynamic message;
    Data data;

    NewsNewCnn({
        required this.success,
        required this.message,
        required this.data,
    });

    factory NewsNewCnn.fromJson(Map<String, dynamic> json) => NewsNewCnn(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String link;
    String description;
    String title;
    String image;
    List<Post> posts;

    Data({
        required this.link,
        required this.description,
        required this.title,
        required this.image,
        required this.posts,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        link: json["link"],
        description: json["description"],
        title: json["title"],
        image: json["image"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "link": link,
        "description": description,
        "title": title,
        "image": image,
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    };
}

class Post {
    String link;
    String title;
    DateTime pubDate;
    String description;
    String thumbnail;

    Post({
        required this.link,
        required this.title,
        required this.pubDate,
        required this.description,
        required this.thumbnail,
    });

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        link: json["link"],
        title: json["title"],
        pubDate: DateTime.parse(json["pubDate"]),
        description: json["description"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "link": link,
        "title": title,
        "pubDate": pubDate.toIso8601String(),
        "description": description,
        "thumbnail": thumbnail,
    };
}