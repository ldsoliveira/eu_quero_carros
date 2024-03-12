import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:eu_quero_carros/core/errors/exceptions.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/dao/reservas_dao.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/models/car_model.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/models/reserva_model.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/data/repositories/eu_quero_carros_repo.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

part 'eu_quero_carros_event.dart';
part 'eu_quero_carros_state.dart';

class EuQueroCarrosBloc extends Bloc<EuQueroCarrosEvent, EuQueroCarrosState> {
  final EuQueroCarrosRepositoryImpl _repository;

  EuQueroCarrosBloc(this._repository) : super(EuQueroCarrosInitial()) {
    on<EuQueroCarrosGetCarsListEvent>(_onGet);
    on<EuQueroCarrosSalvaReservaEvent>(_onSaveReserva);
  }

  Future<void> _onGet(
      EuQueroCarrosGetCarsListEvent event, Emitter<EuQueroCarrosState> emit) async {
    try {
      emit(EuQueroCarrosLoading());
      final cars = await _repository.getCarsList();
      // Aproveita e envia as reservas feitas
      _repository.sendReservas();
      emit(EuQueroCarrosLoaded(cars));
    } on NetworkConnectivityFailure catch (networkFailure) {
      emit(EuQueroCarrosError(networkFailure));
    } on ServerFailure catch (serverFailure) {
      emit(EuQueroCarrosError(serverFailure));
    } catch(_, __) {
      emit(EuQueroCarrosError(UnknownFailure()));
    }
  }

  Future<void> _onSaveReserva(
      EuQueroCarrosSalvaReservaEvent event, Emitter<EuQueroCarrosState> emit) async {
    try {
      emit(EuQueroCarrosLoading());

      final reserva = ReservaModel(
        carroId: event.car.id,
        modeloId: event.car.modeloId,
        emailInteressado: event.email,
        nome: event.name,
        timestampCriacao: DateTime.now().millisecondsSinceEpoch,
      );

      GetIt.I.get<ReservasDAO>().insertReserva(reserva);

      ScaffoldMessenger.of(event.context).showSnackBar(
        const SnackBar(content: Text('Reserva salva com sucesso')),
      );

      add(EuQueroCarrosGetCarsListEvent());
    } catch(_, __) {
      emit(EuQueroCarrosError(UnknownFailure()));
    }
  }
}



