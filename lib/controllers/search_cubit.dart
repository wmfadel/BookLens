import 'package:bloc/bloc.dart';
import 'package:book_lens/models/api_book.dart';
import 'package:book_lens/services/books_service.dart';
import 'package:book_lens/services/camera_service.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    BooksService? booksService,
    CameraService? cameraService,
  })  : _booksService = booksService ?? BooksService(),
        _cameraService = cameraService ?? CameraService(),
        super(SearchInitial());

  final BooksService _booksService;
  final CameraService _cameraService;

  CameraController? get cameraController => _cameraService.cameraController;

  initCamera() async {
    try {
      emit(CameraLoading());
      await _cameraService.requestCameraPermission();
      await _cameraService.initCameraController();
      emit(CameraCompleted());
    } catch (e) {
      emit(CameraError(message: e.toString()));
    }
  }

  closeCamera() {
    _cameraService.stopCamera();
  }

  Future<void> scanImage() async {
    try {
      final text = await _cameraService.scanPicture();
      emit(
        text != null
            ? ScanCompleted(text)
            : const ScanError('Failed to scan content'),
      );
    } catch (e) {
      emit(CameraError(message: e.toString()));
    }
  }

  search(String content) async {
    if (content.isEmpty) {
      return emit(const SearchError(message: 'Please enter a book name'));
    }
    emit(SearchLoading());
    try {
      List<APIBook> books = await _booksService.searchAPIBook(content);
      emit(SearchCompleted(books));
    } catch (e) {
      emit(const SearchError());
    }
  }
}
