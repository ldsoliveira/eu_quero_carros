import 'package:dio/dio.dart';
import 'package:eu_quero_carros/core/background_manager.dart';
import 'package:eu_quero_carros/core/network/network_info.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/dao/reservas_dao.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/datasources/remote_datasource.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/repositories/eu_quero_carros_repo.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/bloc/eu_quero_carros_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

GetIt di = GetIt.instance;

Future<void> init() async {
  // Bloc
  di.registerLazySingleton(() => EuQueroCarrosBloc(
    di(),
  ));

  // Repository
  di.registerLazySingleton<EuQueroCarrosRepositoryImpl>(() => EuQueroCarrosRepositoryImpl(
    remoteDataSource: di(),
    networkInfo: di(),
  ));

  // Utils
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfo(
    di()
  ));
  di.registerLazySingleton(() => InternetConnectionChecker());

  // Datasources
  di.registerLazySingleton<CarsRemoteDataSourceImpl>(() =>
      CarsRemoteDataSourceImpl(httpClient: di(), reservaDAO: di()));

  // HTTP
  di.registerLazySingleton(() => Dio());

  // DAO
  di.registerLazySingleton(() => ReservasDAO());

  // Background
  di.registerLazySingleton(() => BackgroundTaskManager());
}