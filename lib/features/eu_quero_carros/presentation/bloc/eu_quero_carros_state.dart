part of 'eu_quero_carros_bloc.dart';

@immutable
abstract class EuQueroCarrosState extends Equatable {}

class EuQueroCarrosInitial extends EuQueroCarrosState {
  @override
  List<Object?> get props => [];
}

class EuQueroCarrosLoading extends EuQueroCarrosState {
  @override
  List<Object?> get props => [];
}

class EuQueroCarrosError extends EuQueroCarrosState {
  final Exception exception;

  EuQueroCarrosError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class EuQueroCarrosLoaded extends EuQueroCarrosState {
  final List<CarModel> cars;

  EuQueroCarrosLoaded(this.cars);

  @override
  List<Object?> get props => [cars];
}