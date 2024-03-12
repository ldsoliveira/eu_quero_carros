part of 'eu_quero_carros_bloc.dart';

@immutable
abstract class EuQueroCarrosEvent extends Equatable {}

class EuQueroCarrosGetCarsListEvent extends EuQueroCarrosEvent {
  @override
  List<Object?> get props => [];
}

class EuQueroCarrosSalvaReservaEvent extends EuQueroCarrosEvent {
  final String name;
  final String email;
  final CarModel car;
  final BuildContext context;

  EuQueroCarrosSalvaReservaEvent({required this.context, required this.name,
    required this.email, required this.car});

  @override
  List<Object?> get props => [name, email, car];
}
