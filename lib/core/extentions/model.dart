import 'package:fake_store/features/home/data/models/product.dart';

import '../../features/home/domain/entities/product.dart';

extension ProductModelExtension on ProductModel {
  ProductEntity get toEntity {
    return ProductEntity(
      id: id,
      title: title,
      image: image,
      price: price,
      description: description,
      category: category,
    );
  }
}
