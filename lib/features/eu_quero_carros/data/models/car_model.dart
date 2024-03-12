import 'dart:convert';

class CarModel {
  CarModel({
    required this.id,
    required this.timestampCadastro,
    required this.modeloId,
    required this.ano,
    required this.combustivel,
    required this.numPortas,
    required this.cor,
    required this.nomeModelo,
    required this.valor,
  });

  final int id;
  final int timestampCadastro;
  final int modeloId;
  final int ano;
  final String combustivel;
  final int numPortas;
  final String cor;
  final String nomeModelo;
  final double valor;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp_cadastro': timestampCadastro,
      'modelo_id': modeloId,
      'ano': ano,
      'combustivel': combustivel,
      'num_portas': numPortas,
      'cor': cor,
      'nome_modelo': nomeModelo,
      'valor': valor,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] ?? 0,
      timestampCadastro: map['timestamp_cadastro'] ?? 0,
      modeloId: map['modelo_id'] ?? 0,
      ano: map['ano'] ?? 0,
      combustivel: map['combustivel'] ?? 'Informação indisponível',
      numPortas: map['num_portas'] ?? 2,
      cor: map['cor'] ?? 'Informação indisponível',
      nomeModelo: map['nome_modelo'] ?? 'Informação indisponível',
      valor: map['valor'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarModel.fromJson(String source) => CarModel.fromMap(json.decode(source));
}
