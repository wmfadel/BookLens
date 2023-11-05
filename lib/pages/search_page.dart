import 'package:book_lens/controllers/search_cubit.dart';
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
      body: Column(
        children: [
          // Expanded(
          // child: CameraPreview(_cameraController!),
          // ),
          Container(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: FloatingActionButton(
                onPressed: () {
                  // _scanImage();
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
