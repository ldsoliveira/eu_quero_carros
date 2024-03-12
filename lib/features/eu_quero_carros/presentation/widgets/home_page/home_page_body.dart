import 'package:eu_quero_carros/features/eu_quero_carros/presentation/bloc/eu_quero_carros_bloc.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/widgets/home_page/home_page_body_error.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/widgets/home_page/home_page_body_initial.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/widgets/home_page/home_page_body_loaded.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/widgets/home_page/home_page_body_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EuQueroCarrosBloc, EuQueroCarrosState>(
      bloc: GetIt.I.get<EuQueroCarrosBloc>(),
      builder: (_, state) {
        switch (state.runtimeType) {
          case EuQueroCarrosInitial:
            return const HomePageBodyInitial();
          case EuQueroCarrosLoading:
            return const HomePageBodyLoading();
          case EuQueroCarrosError:
            return HomePageBodyError(
              exception: (state as EuQueroCarrosError).exception
            );
          case EuQueroCarrosLoaded:
            return HomePageBodyLoaded(
              cars: (state as EuQueroCarrosLoaded).cars
            );
          default:
            return const HomePageBodyInitial();
        }
      },
    );
  }
}
