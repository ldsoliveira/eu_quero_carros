import 'package:eu_quero_carros/features/eu_quero_carros/presentation/bloc/eu_quero_carros_bloc.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/widgets/home_page/home_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WS WORK! - Eu quero carros'),
        actions: [
          BlocBuilder<EuQueroCarrosBloc, EuQueroCarrosState>(
            bloc: GetIt.I.get<EuQueroCarrosBloc>(),
            builder: (ctx, state) {
              if(state is EuQueroCarrosLoaded) {
                return IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () {
                    GetIt.I.get<EuQueroCarrosBloc>()
                        .add(EuQueroCarrosGetCarsListEvent());
                  },
                );
              }

              return const SizedBox.shrink();
            }
          ),

        ],
      ),
      body: const HomePageBody(),
    );
  }
}