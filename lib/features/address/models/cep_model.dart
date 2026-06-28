class CepModel {
  final String cep;
  final String street;
  final String neighborhood;
  final String city;
  final String state;

  CepModel({
    required this.cep,
    required this.street,
    required this.neighborhood,
    required this.city,
    required this.state,
  });

  factory CepModel.fromJson(Map<String, dynamic> json) {
    return CepModel(
      cep: json['cep'] ?? '',
      street: json['logradouro'] ?? '',
      neighborhood: json['bairro'] ?? '',
      city: json['localidade'] ?? '',
      state: json['uf'] ?? '',
    );
  }
}
