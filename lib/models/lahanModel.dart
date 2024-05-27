class Lahan {
  final int id;
  final String nama;
  final int umur;

  Lahan({required this.id, required this.nama, required this.umur});

  factory Lahan.fromMap(Map<String, dynamic> map) {
    return Lahan(
      id: map['Id'] ?? 0,
      nama: map['Lahan'] ?? '',
      umur: map['Umur'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'Lahan': nama,
      'Umur': umur,
    };
  }
}
