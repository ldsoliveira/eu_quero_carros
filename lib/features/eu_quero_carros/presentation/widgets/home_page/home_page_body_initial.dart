import 'package:eu_quero_carros/features/eu_quero_carros/presentation/bloc/eu_quero_carros_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePageBodyInitial extends StatelessWidget {
  const HomePageBodyInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Text('Nenhum carro disponível no momento')),
        const SizedBox(height: 15),
        ElevatedButton.icon(
          icon: const Icon(Icons.download),
          label: const Text('Atualizar lista'),
          onPressed: () {
            GetIt.I.get<EuQueroCarrosBloc>()
                .add(EuQueroCarrosGetCarsListEvent());
          },
        )
      ],
    );
  }
}
