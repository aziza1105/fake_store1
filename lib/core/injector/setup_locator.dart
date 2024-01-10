import 'package:dio/dio.dart';
import 'package:fake_store/features/home/data/data_source/remote_data_source.dart';
import 'package:fake_store/features/home/data/repository/product.dart';
import 'package:fake_store/features/home/domain/usecase/get_products.dart';
import 'package:fake_store/features/login/data/repository/auth.dart';
import 'package:fake_store/features/login/domain/usecase/get_user.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.I;

Future<void> setupLocator() async{
  serviceLocator.registerSingletonAsync(
          () async=> await SharedPreferences.getInstance()
  );

  serviceLocator.registerLazySingleton(() => AuthenticationRepositoryImpl());
  //serviceLocator.registerLazySingleton(() => GetUserUseCase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => Dio (BaseOptions(baseUrl: 'https://fakestoreapi.com')));
  serviceLocator.registerLazySingleton(() => HomeRemoteDataSource());
  serviceLocator.registerLazySingleton(() => ProductRepositoryImpl(serviceLocator()));
  serviceLocator.registerLazySingleton(() => GetProductsUseCase(serviceLocator()));
}