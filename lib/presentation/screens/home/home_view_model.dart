import 'package:blog_list_app/data/models/blog_model.dart';
import 'package:blog_list_app/data/services/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _homeViewModel =
    ChangeNotifierProvider<HomeViewModel>((ref) => HomeViewModel(ApiService()));

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService;

  HomeViewModel(this._apiService);

  static ChangeNotifierProvider<HomeViewModel> get provider => _homeViewModel;

  bool isLoading = false;
  List<BlogModel> _blogs = [];

  List<BlogModel> get blogs => _blogs;

  init() async {
    _blogs = await _apiService.fetchBlogPosts();
    isLoading = false;
    notifyListeners();
  }
}
