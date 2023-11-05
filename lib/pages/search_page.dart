import 'package:book_lens/controllers/search_cubit.dart';
import 'package:book_lens/pages/results_page.dart';
import 'package:book_lens/widgets/search/search_error_view.dart';
import 'package:book_lens/widgets/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with WidgetsBindingObserver {
  late SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    _searchCubit = context.read<SearchCubit>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _searchCubit.closeCamera();
    super.dispose();
  }

  // Starts and stops the camera according to the lifecycle of the app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_searchCubit.cameraController == null ||
        !_searchCubit.cameraController!.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      _searchCubit.closeCamera();
    } else if (state == AppLifecycleState.resumed &&
        _searchCubit.cameraController != null &&
        _searchCubit.cameraController!.value.isInitialized) {
      _searchCubit.initCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is ScanError) {
            ScaffoldMessenger.of(context)
              ..removeCurrentMaterialBanner()
              ..showMaterialBanner(
                MaterialBanner(
                  content: Text(state.error),
                  actions: [
                    TextButton(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .removeCurrentMaterialBanner(),
                        child: const Icon(Icons.clear))
                  ],
                ),
              );
          } else if (state is ScanCompleted) {
            _searchCubit.search(state.text);
          } else if (state is SearchCompleted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ResultScreen(books: state.books),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CameraLoading || state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchError || state is CameraError) {
            return const SearchErrorView();
          } else {
            return const SearchView();
          }
        },
      ),
    );
  }
}
