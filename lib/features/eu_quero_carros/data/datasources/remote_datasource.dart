
import 'package:dio/dio.dart';
import 'package:eu_quero_carros/core/endpoints.dart';
import 'package:eu_quero_carros/core/errors/exceptions.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/dao/reservas_dao.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/models/car_model.dart';

/// Contrato datasource
abstract class CarsRemoteDataSource {
  /// Faz uma chamada ao endpoint [https://wswork.com.br/cars.json].
  /// Em caso de erro, faz um throw em [ServerException].
  Future<List<CarModel>> getCarsList();


  /// Envia todas as reservas salvas no banco de dados. Em caso de sucesso,
  /// deleta as reservas no banco
  Future<void> sendReservas();
}

class CarsRemoteDataSourceImpl implements CarsRemoteDataSource {
  final Dio httpClient;
  final ReservasDAO reservaDAO;

  CarsRemoteDataSourceImpl({required this.reservaDAO, required this.httpClient});

  @override
  Future<List<CarModel>> getCarsList() async {
    try {
      final response = await httpClient.get(
        Endpoints.wsWorkCars
      );

      final cars = response.data['cars'];

      if(response.statusCode == 200) {
        final convertedCars = <CarModel>[];
        for(final car in cars) {
          convertedCars.add(CarModel.fromMap(car));
        }
        return convertedCars;
      } else {
        throw ServerException();
      }
    } catch(_, __) {
      throw UnknownFailure();
    }
  }

  @override
  Future<void> sendReservas() async {
    try {
      final reservas = await reservaDAO.getReservas();
      final reservasMap = reservas.map((reserva) => reserva.toMap()).toList();


      if(reservasMap.isNotEmpty) {
        for(final reserva in reservasMap) {
          final response = await httpClient.post(
            Endpoints.wsWorkLeads,
            data: FormData.fromMap(reserva)
          );

          if(response.statusCode == 200 || response.statusCode == 201) {
            reservaDAO.deleteReserva(reserva['timestamp_criacao']);
            return;
          } else {
            throw ServerException();
          }
        }
      }
    } catch(_, __) {
      throw UnknownFailure();
    }
  }
}