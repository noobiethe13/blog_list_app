import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/blog_model.dart';

class ApiService {
  static const String apiUrl = 'https://api.hive.blog/';

  Future<List<BlogModel>> fetchBlogPosts() async {
    try {
      const Map<String, dynamic> payload = {
        "id": 1,
        "jsonrpc": "2.0",
        "method": "bridge.get_ranked_posts",
        "params": {"sort": "trending", "tag": "", "observer": "hive.blog"}
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json, text/plain, */*',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> result = data['result'] ?? [];

        final output = result.map((json) {
          final jsonMetadata = json['json_metadata'];
          final description =
              (jsonMetadata is Map && jsonMetadata['description'] is String)
                  ? jsonMetadata['description']
                  : '';
          final images = (jsonMetadata is Map &&
                  jsonMetadata['image'] is List &&
                  jsonMetadata['image'].isNotEmpty)
              ? jsonMetadata['image']
              : [];

          return BlogModel(
            userName: json['author'] ?? '',
            postPicture: images.isNotEmpty ? images[0] : '',
            postTitle: json['title'] ?? '',
            votes: (json['stats'] is Map)
                ? (json['stats']['total_votes'] ?? 0)
                : 0,
            comments: json['children'] ?? 0,
            community: json['community_title'] ?? '',
            createdAt: json['created'] ?? '',
            description: description,
          );
        }).toList();
        return output;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching blog posts: $e');
      return [];
    }
  }
}
