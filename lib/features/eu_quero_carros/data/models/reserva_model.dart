import 'dart:convert';

class ReservaModel {
  ReservaModel({
    required this.carroId,
    required this.modeloId,
    required this.emailInteressado,
    required this.nome,
    required this.timestampCriacao,
  });

  final int carroId;
  final int modeloId;
  final String emailInteressado;
  final String nome;
  final int timestampCriacao;

  Map<String, dynamic> toMap() {
    return {
      'carro_id': carroId,
      'modelo_id': modeloId,
      'email_interessado': emailInteressado,
      'nome': nome,
      'timestamp_criacao': timestampCriacao,
    };
  }

  factory ReservaModel.fromMap(Map<String, dynamic> map) {
    return ReservaModel(
      carroId: map['carro_id'] ?? 0,
      modeloId: map['modelo_id'] ?? 0,
      emailInteressado: map['email_interessado'] ?? 'Informação indisponível',
      nome: map['nome'] ?? 'Informação indisponível',
      timestampCriacao: map['timestamp_criacao'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReservaModel.fromJson(String source) => ReservaModel.fromMap(json.decode(source));
}
