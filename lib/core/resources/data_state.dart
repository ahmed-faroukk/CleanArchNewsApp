import 'package:dio/dio.dart';

abstract class Resource<T> {
  final T ? data;
  final DioError ? error;

  Resource({this.data, this.error});
}

class Success<T> extends Resource<T> {
  Success(T data) : super(data: data);
}

class Error<T> extends Resource<T> {
  Error(DioError error) : super(error : error );
}

class Loading<T> extends Resource<T> {
  Loading() : super();
}
