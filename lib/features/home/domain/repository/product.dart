import 'package:fake_store/features/home/domain/entities/product.dart';

import '../../../../core/either/either.dart';
import '../../../../core/failure/failure.dart';

abstract class ProductRepository {
  Future<Either<ServerFailure, List<ProductEntity>>> getProducts();
}