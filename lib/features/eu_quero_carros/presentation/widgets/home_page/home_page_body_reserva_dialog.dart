import 'package:eu_quero_carros/features/eu_quero_carros/data/models/car_model.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/bloc/eu_quero_carros_bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePageBodyReservaDialog extends StatefulWidget {
  const HomePageBodyReservaDialog({
    Key? key,
    required this.selectedCar,
  }) : super(key: key);

  final CarModel selectedCar;

  @override
  State<HomePageBodyReservaDialog> createState() => _HomePageBodyReservaDialogState();
}

class _HomePageBodyReservaDialogState extends State<HomePageBodyReservaDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reservar'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome.';
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email.';
                  }
                  if (!_emailRegExp.hasMatch(value)) {
                    return 'Por favor, insira um email válido.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  GetIt.I.get<EuQueroCarrosBloc>().add(
                    EuQueroCarrosSalvaReservaEvent(
                      name: _nomeController.text,
                      email: _emailController.text,
                      car: widget.selectedCar,
                      context: context,
                    )
                  );

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Eu quero!'),
            ),
          ]
        ),
      ],
    );
  }
}
