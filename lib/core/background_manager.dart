import 'dart:async';
import 'package:background_fetch/background_fetch.dart';
import 'package:dio/dio.dart';
import 'package:eu_quero_carros/core/endpoints.dart';
import 'package:eu_quero_carros/core/network/network_info.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/dao/reservas_dao.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BackgroundTaskManager {
  static final BackgroundTaskManager _instance = BackgroundTaskManager._internal();

  factory BackgroundTaskManager() {
    return _instance;
  }

  BackgroundTaskManager._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleBackgroundTask({required NetworkInfo networkInfo,
      required Dio dio, required ReservasDAO dao}) async {
    await flutterLocalNotificationsPlugin.cancelAll();

    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 1440, // A cada 24h
        stopOnTerminate: true,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      ),
      (String taskId) async {
        await executeBackgroundTask(networkInfo: networkInfo, dio: dio, dao: dao);

        BackgroundFetch.finish(taskId);
      },
    );

    await BackgroundFetch.scheduleTask(
      TaskConfig(
        taskId: 'eu_quero_carros_task',
        delay: 0, // Tempo de espera para iniciar a primeira execução
        periodic: true,
        forceAlarmManager: true, // Força o uso do AlarmManager no Android (necessário para tarefas em segundo plano)
      ),
    );
  }

  Future<void> executeBackgroundTask({required NetworkInfo networkInfo, required Dio dio, required ReservasDAO dao}) async {
    try {
      if (await networkInfo.isConnected) {
        final reservas = await dao.getReservas();
        final reservasMap = reservas.map((reserva) => reserva.toMap()).toList();

        if(reservas.isNotEmpty) {
          for(final reserva in reservasMap) {
            final response = await dio.post(
              Endpoints.wsWorkLeads,
              data: reservasMap,
            );

            if (response.statusCode == 200 || response.statusCode == 201) {
              dao.deleteReserva(reserva['timestamp_criacao']);
              return;
            }
          }
        }
      }
    } catch (_, __) {}
  }
}
