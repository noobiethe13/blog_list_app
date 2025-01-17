import 'package:blog_list_app/presentation/screens/home/home_view_model.dart';
import 'package:blog_list_app/presentation/screens/home/widgets/blog_tile.dart';
import 'package:blog_list_app/presentation/shared_widgets/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ref.read(HomeViewModel.provider);
    _viewModel.isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _viewModel.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(HomeViewModel.provider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          child: Container(
        height: kToolbarHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "All Posts",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.black),
              ),
              Icon(
                CupertinoIcons.bell,
                color: Colors.black,
              )
            ],
          ),
        ),
      )),
      body: _viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : _viewModel.blogs.isEmpty
              ? const Center(
                  child: Text(
                    "Unable to fetch data. \nPlease try again later.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _viewModel.blogs.length,
                          itemBuilder: (context, index) {
                            final blog = _viewModel.blogs[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: BlogTile(
                                blog: blog,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
