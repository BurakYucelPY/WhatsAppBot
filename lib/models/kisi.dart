class Kisi {
  final String id;
  final String isim;
  final String soyisim;
  final String telefon;
  final String eposta;
  final String sirket;
  final String ulkeKodu;

  Kisi({
    required this.id,
    required this.isim,
    required this.soyisim,
    required this.telefon,
    required this.eposta,
    required this.sirket,
    required this.ulkeKodu,
  });

  String get tamIsim => '$isim $soyisim';
  String get tamTelefon => '$ulkeKodu $telefon';
}
