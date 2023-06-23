class ProductModel {
  int? id;
  int? barkod;
  double? fiyatListe;
  double? fiyat;
  String? ad;
  String? tarihOlusturma;
  int? adet;

  ProductModel(
      {this.id,
        this.barkod,
        this.fiyatListe,
        this.fiyat,
        this.ad,
        this.tarihOlusturma,
        this.adet
      });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    barkod = json['Barkod'];
    fiyatListe = json['FiyatListe'];
    fiyat = json['Fiyat'];
    ad = json['Ad'];
    tarihOlusturma = json['TarihOlusturma'];
    adet=json['Adet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Barkod'] = barkod;
    data['FiyatListe'] = fiyatListe;
    data['Fiyat'] = fiyat;
    data['Ad'] = ad;
    data['TarihOlusturma'] = tarihOlusturma;
    data['Adet']=adet;
    return data;
  }
}