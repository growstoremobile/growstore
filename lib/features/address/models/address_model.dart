class AddressModel {
  final String id;
  final String name;
  final String cep;
  final String street;
  final String number;
  final String complement;
  final String neighborhood;
  final String city;
  final String state;
  final bool isDefault;

  const AddressModel({
    required this.id,
    required this.name,
    required this.cep,
    required this.street,
    required this.number,
    required this.complement,
    required this.neighborhood,
    required this.city,
    required this.state,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cep': cep,
      'street': street,
      'number': number,
      if (complement.isNotEmpty) 'complement': complement,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
      'isDefault': isDefault,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json, String id) {
    return AddressModel(
      id: id,
      name: json['name'] ?? '',
      cep: json['cep'] ?? '',
      street: json['street'] ?? '',
      number: json['number'] ?? '',
      complement: json['complement'] ?? '',
      neighborhood: json['neighborhood'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      isDefault: json['isDefault'] ?? false,
    );
  }

  AddressModel copyWith({bool? isDefault}) {
    return AddressModel(
      id: id,
      name: name,
      cep: cep,
      street: street,
      number: number,
      complement: complement,
      neighborhood: neighborhood,
      city: city,
      state: state,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
