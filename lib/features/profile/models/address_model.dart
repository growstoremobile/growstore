class AddressModel {
  const AddressModel({
    required this.id,
    required this.label,
    required this.recipient,
    required this.street,
    required this.number,
    required this.city,
    required this.state,
    required this.zipCode,
    this.complement = '',
    this.isDefault = false,
  });

  final String id;
  final String label;
  final String recipient;
  final String street;
  final String number;
  final String complement;
  final String city;
  final String state;
  final String zipCode;
  final bool isDefault;

  String get summary {
    final complementText = complement.trim().isEmpty
        ? ''
        : ', ${complement.trim()}';

    return '$street, $number$complementText - $city/$state, $zipCode';
  }

  AddressModel copyWith({
    String? id,
    String? label,
    String? recipient,
    String? street,
    String? number,
    String? complement,
    String? city,
    String? state,
    String? zipCode,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      label: label ?? this.label,
      recipient: recipient ?? this.recipient,
      street: street ?? this.street,
      number: number ?? this.number,
      complement: complement ?? this.complement,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  factory AddressModel.fromJson(Map<dynamic, dynamic> json) {
    return AddressModel(
      id: json['id']?.toString() ?? '',
      label: json['label']?.toString() ?? 'Endereco',
      recipient: json['recipient']?.toString() ?? '',
      street: json['street']?.toString() ?? '',
      number: json['number']?.toString() ?? '',
      complement: json['complement']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      zipCode: json['zipCode']?.toString() ?? '',
      isDefault: json['isDefault'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'recipient': recipient,
      'street': street,
      'number': number,
      'complement': complement,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'isDefault': isDefault,
    };
  }
}
