import 'package:dio/dio.dart';
import 'package:eu_quero_carros/core/background_manager.dart';
import 'package:eu_quero_carros/core/network/network_info.dart';
import 'package:eu_quero_carros/core/style/theme_data.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/dao/reservas_dao.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/bloc/eu_quero_carros_bloc.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:eu_quero_carros/dependency_injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';


// TODO: revisa tudo
// TODO: testar o código
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  BackgroundTaskManager().initialize();
  BackgroundTaskManager().scheduleBackgroundTask(
    dao: GetIt.I.get<ReservasDAO>(),
    dio: GetIt.I.get<Dio>(),
    networkInfo: GetIt.I.get<NetworkInfo>(),
  );

  runApp(BlocProvider(
    create: (context) => GetIt.I.get<EuQueroCarrosBloc>(),
    child: MaterialApp(
      title: 'Eu quero carros',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: CustomAppTheme.appTheme()
    ),
  ));
}