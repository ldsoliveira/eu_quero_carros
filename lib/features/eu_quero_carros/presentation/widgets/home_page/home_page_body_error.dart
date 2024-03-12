import 'package:eu_quero_carros/core/errors/exceptions.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/bloc/eu_quero_carros_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePageBodyError extends StatelessWidget {
  HomePageBodyError({
    Key? key,
    required this.exception
  }) : super(key: key);

  final Exception exception;

  final description = {
    NetworkConnectivityFailure: 'Dispositivo sem conexão com a internet. Por favor se conecte e tente novamente',
    ServerFailure: 'O servidor está indisponível no momento, por favor, tente novamente mais tarde',
    UnknownFailure: 'Ocorreu um erro desconhecido, por favor, tente novamente',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            description[exception.runtimeType] ?? description.values.last,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          icon: const Icon(Icons.sync),
          label: const Text('Tentar novamente'),
          onPressed: () {
            GetIt.I.get<EuQueroCarrosBloc>()
                .add(EuQueroCarrosGetCarsListEvent());
          },
        )
      ],
    );
  }
}


