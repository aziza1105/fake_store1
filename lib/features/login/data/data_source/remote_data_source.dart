import 'package:dio/dio.dart';
import 'package:fake_store/core/exception/exception.dart';
import 'package:fake_store/core/injector/setup_locator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_data_source.freezed.dart';

abstract class AuthenticationRemoteDataSource {
  factory AuthenticationRemoteDataSource() =>
      _AuthenticationRemoteDataSourceImpl();
  Future<AuthenticatedUserModel> getUser(String username, String password);
}

class _AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final dio = serviceLocator<Dio>();
  @override
  Future<AuthenticatedUserModel> getUser(
      String username, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return const AuthenticatedUserModel();
      } else {
        throw ServerException();
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException();
    }
  }
}

@freezed
class AuthenticatedUserModel with _$AuthenticatedUserModel {
  const factory AuthenticatedUserModel({
    @Default(0) int id,
    @Default('') String email,
    @Default('') String username,
  }) = _AuthenticatedUserModel;
}
