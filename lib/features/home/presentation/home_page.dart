import 'package:fake_store/core/usecase/usecase.dart';
import 'package:fake_store/features/home/data/repository/product.dart';
import 'package:fake_store/features/home/domain/usecase/get_products.dart';
import 'package:fake_store/features/home/presentation/pages/single_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/data_source/remote_data_source.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('FakeStore '),
      ),
      body: FutureBuilder(
        future: GetProductsUseCase(
          ProductRepositoryImpl(
            HomeRemoteDataSource(),
          ),
        ).call(NoParams()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isLeft) {
              return const SizedBox();
            } else {
              final list = snapshot.data!.right;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // mainAxisSpacing: 10,
                    // crossAxisSpacing: 10,
                    childAspectRatio: 1 / 1.5),
                itemCount: list.length,
                itemBuilder: (_, index) {
                  final product = list[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => SingleProductPage(product: product),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.maxFinite,
                            height: 80,
                            child: Image.network(product.image),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            product.description,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '\$ ${product.price}',
                            maxLines: 3,
                            // textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}
