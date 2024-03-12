import 'package:eu_quero_carros/features/eu_quero_carros/data/models/car_model.dart';
import 'package:eu_quero_carros/features/eu_quero_carros/presentation/widgets/home_page/home_page_body_reserva_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePageBodyLoaded extends StatefulWidget {
  const HomePageBodyLoaded({
    Key? key,
    required this.cars
  }) : super(key: key);

  final List<CarModel> cars;

  @override
  State<HomePageBodyLoaded> createState() => _HomePageBodyLoadedState();
}

class _HomePageBodyLoadedState extends State<HomePageBodyLoaded> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Text(
            'Esta é a lista de carros disponíveis para você. Selecione um (ou vários) que você queira reservar',
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 20),
              itemCount: widget.cars.length,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildCardContent(index),
                    ),
                  ),
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (ctx) => HomePageBodyReservaDialog(
                          selectedCar: widget.cars[index])
                    );
                  },
                );
              }
          ),
        ),
      ],
    );
  }

  Widget _buildCardContent(int index) {
    final car = widget.cars[index];

    final date = DateTime.fromMillisecondsSinceEpoch(
        car.timestampCadastro * 1000);
    final formattedDate = DateFormat('dd/MM/yyyy hh:mm').format(date);

    return Column(
      children: [
        Text(
          '${car.nomeModelo} ${car.ano} - ${car.combustivel}',
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
        Text(
          'Cor: ${car.cor} - ${car.numPortas} portas',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text('Cadastrado em: $formattedDate'),
        Text(
          'R\$ ${car.valor.toStringAsFixed(3)}',
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
