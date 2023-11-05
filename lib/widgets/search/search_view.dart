import 'package:book_lens/controllers/search_cubit.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return Column(
      children: [
        Expanded(
          child: cubit.cameraController == null
              ? const SizedBox()
              : CameraPreview(cubit.cameraController!),
        ),
        Container(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: FloatingActionButton(
              onPressed: () {
                cubit.scanImage();
              },
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ),
      ],
    );
  }
}
