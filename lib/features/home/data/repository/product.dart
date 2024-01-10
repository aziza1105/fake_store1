import 'package:fake_store/core/either/either.dart';
import 'package:fake_store/core/extentions/model.dart';
import 'package:fake_store/core/failure/failure.dart';
import 'package:fake_store/features/home/data/data_source/remote_data_source.dart';
import 'package:fake_store/features/home/domain/entities/product.dart';
import 'package:fake_store/features/home/domain/repository/product.dart';

import '../../../../core/exception/exception.dart';

class ProductRepositoryImpl implements ProductRepository {
  final HomeRemoteDataSource _remoteDataSource;

  const ProductRepositoryImpl(HomeRemoteDataSource remoteDataSource)
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<ServerFailure, List<ProductEntity>>> getProducts() async {
    try {
      final productModelList = await _remoteDataSource.getProducts();

      return Right(
        productModelList.map((model) => model.toEntity).toList(),
      );
    } on ServerException catch (exception) {
      return Left(ServerFailure());
    }
  }
}
