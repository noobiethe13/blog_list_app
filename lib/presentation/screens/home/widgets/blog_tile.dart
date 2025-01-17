import 'package:blog_list_app/data/models/blog_model.dart';
import 'package:blog_list_app/presentation/screens/home/widgets/blog_stat_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogTile extends StatelessWidget {
  final BlogModel blog;
  const BlogTile({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    String timeAgo(String isoDateString) {
      DateTime dateTime = DateTime.parse(isoDateString);
      DateTime now = DateTime.now();
      Duration difference = now.difference(dateTime);

      if (difference.inSeconds < 60) {
        return "just now";
      } else if (difference.inMinutes < 60) {
        return "${difference.inMinutes} mins ago";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} hours ago";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} days ago";
      } else if (difference.inDays < 30) {
        return "${(difference.inDays / 7).floor()} weeks ago";
      } else if (difference.inDays < 365) {
        return "${(difference.inDays / 30).floor()} months ago";
      } else {
        return "${(difference.inDays / 365).floor()} years ago";
      }
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 4),
            ),
          ]),
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: blog.userName.isNotEmpty
                          ? "${blog.userName} "
                          : "Anonymous ",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: blog.community.isNotEmpty
                          ? "in ${blog.community}"
                          : "",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                    TextSpan(
                      text: " • ${timeAgo(blog.createdAt)}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ),
          ]),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: CachedNetworkImage(
                  imageUrl: blog.postPicture.isNotEmpty
                      ? blog.postPicture
                      : "https://img.icons8.com/?size=100&id=t7urZGVsoexs&format=png&color=000000",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.postTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    Text(
                      blog.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[500]),
                    ),
                    Divider(
                      color: Colors.grey[600],
                      thickness: 0.3,
                    ),
                    BlogStatBar(
                      comments: blog.comments,
                      votes: blog.votes,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
