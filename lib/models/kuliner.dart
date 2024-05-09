import 'dart:convert';

class Kuliner {
  final String nama;
  final String alamat;
  final String foto;

  Kuliner({
    required this.nama,
    required this.alamat,
    required this.foto,
  });

  Kuliner copyWith({
    String? nama,
    String? alamat,
    String? foto,
  }) {
    return Kuliner(
      nama: nama ?? this.nama,
      alamat: alamat ?? this.alamat,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'alamat': alamat,
      'foto': foto,
    };
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
      nama: map['nama'] as String,
      alamat: map['alamat'] as String,
      foto: map['foto'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) =>
      Kuliner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kuliner(nama: $nama, alamat: $alamat, foto: $foto)';
  }

  @override
  bool operator ==(covariant Kuliner other) {
    if (identical(this, other)) return true;

    return other.nama == nama && other.alamat == alamat && other.foto == foto;
  }

  @override
  int get hashCode {
    return nama.hashCode ^ alamat.hashCode ^ foto.hashCode;
  }
}
