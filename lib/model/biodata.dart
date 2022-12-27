// ignore_for_file: file_names, unnecessary_this, prefer_collection_literals

class Biodata {
  int? id;
  String? nim;
  String? nama;
  String? alamat;
  String? jenisKelamin;
  String? tglLahir;

  Biodata(
      {this.id,
      this.nim,
      this.nama,
      this.alamat,
      this.jenisKelamin,
      this.tglLahir});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nim'] = nim;
    map['nama'] = nama;
    map['alamat'] = alamat;
    map['jenisKelamin'] = jenisKelamin;
    map['tglLahir'] = tglLahir;

    return map;
  }

  Biodata.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.nim = map['nim'];
    this.nama = map['nama'];
    this.alamat = map['alamat'];
    this.jenisKelamin = map['jenisKelamin'];
    this.tglLahir = map['tglLahir'];
  }
}
