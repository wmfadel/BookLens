part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class CameraLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class CameraCompleted extends SearchState {
  @override
  List<Object> get props => [];
}

class CameraError extends SearchState {
  final String? message;

  const CameraError({this.message});

  @override
  List<Object?> get props => [message];
}

class SearchLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchCompleted extends SearchState {
  final List<APIBook> books;

  const SearchCompleted(this.books);

  @override
  List<Object> get props => [books];
}

class SearchError extends SearchState {
  final String? message;

  const SearchError({this.message});

  @override
  List<Object?> get props => [message];
}
