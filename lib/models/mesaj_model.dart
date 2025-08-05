class PlanlananMesaj {
  final String id;
  final String alici;
  final DateTime tarih;
  final String saat;
  final String mesaj;
  final DateTime olusturmaTarihi;

  PlanlananMesaj({
    required this.id,
    required this.alici,
    required this.tarih,
    required this.saat,
    required this.mesaj,
    required this.olusturmaTarihi,
  });

  // JSON serialization için
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alici': alici,
      'tarih': tarih.toIso8601String(),
      'saat': saat,
      'mesaj': mesaj,
      'olusturmaTarihi': olusturmaTarihi.toIso8601String(),
    };
  }

  factory PlanlananMesaj.fromJson(Map<String, dynamic> json) {
    return PlanlananMesaj(
      id: json['id'],
      alici: json['alici'],
      tarih: DateTime.parse(json['tarih']),
      saat: json['saat'],
      mesaj: json['mesaj'],
      olusturmaTarihi: DateTime.parse(json['olusturmaTarihi']),
    );
  }

  PlanlananMesaj copyWith({
    String? id,
    String? alici,
    DateTime? tarih,
    String? saat,
    String? mesaj,
    DateTime? olusturmaTarihi,
  }) {
    return PlanlananMesaj(
      id: id ?? this.id,
      alici: alici ?? this.alici,
      tarih: tarih ?? this.tarih,
      saat: saat ?? this.saat,
      mesaj: mesaj ?? this.mesaj,
      olusturmaTarihi: olusturmaTarihi ?? this.olusturmaTarihi,
    );
  }
}
