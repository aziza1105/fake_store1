import 'package:fake_store/core/either/either.dart';
import 'package:fake_store/core/exception/exception.dart';
import 'package:fake_store/core/failure/failure.dart';
import 'package:fake_store/features/login/data/data_source/remote_data_source.dart';
import 'package:fake_store/features/login/domain/repository/auth.dart';
import 'package:fake_store/features/login/presentation/bloc/auth/authentication_bloc.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final dataSource = AuthenticationRemoteDataSource();

  @override
  Future<Either<ServerFailure, AuthenticatedUserEntity>> getUser(
      String username, String password) async {
    try {
      await dataSource.getUser(username, password);

      return Right(const AuthenticatedUserEntity.empty());
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}
