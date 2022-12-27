// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_function_literals_in_foreach_calls, non_constant_identifier_names, unused_element, unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'form_biodata.dart';

import 'database/db_helper.dart';
import 'model/biodata.dart';

class ListBiodataPage extends StatefulWidget {
  const ListBiodataPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListBiodataPageState createState() => _ListBiodataPageState();
}

class _ListBiodataPageState extends State<ListBiodataPage> {
  List<Biodata> listBiodata = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    //menjalankan fungsi getallbiodata saat pertama kali dimuat
    _getAllBiodata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Biodata App"),
        ),
      ),
      body: ListView.builder(
          itemCount: listBiodata.length,
          itemBuilder: (context, index) {
            Biodata biodata = listBiodata[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('${biodata.nim}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Email: ${biodata.nama}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Phone: ${biodata.alamat}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Company: ${biodata.jenisKelamin}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Company: ${biodata.tglLahir}"),
                    ),
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(biodata);
                          },
                          icon: Icon(Icons.edit)),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${biodata.nim}")
                                ],
                              ),
                            ),
                            //terdapat 2 button.
                            //jika ya maka jalankan _deleteBiodata() dan tutup dialog
                            //jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteBiodata(biodata, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  //mengambil semua data Biodata
  Future<void> _getAllBiodata() async {
    //list menampung data dari database
    var list = await db.getAllBiodata();

    //ada perubahanan state
    setState(() {
      //hapus data pada listBiodata
      listBiodata.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((biodata) {
        //masukan data ke listBiodata
        listBiodata.add(Biodata.fromMap(biodata));
      });
    });
  }

  //menghapus data biodata
  Future<void> _deleteBiodata(Biodata biodata, int position) async {
    await db.deleteBiodata(biodata.id!);
    setState(() {
      listBiodata.removeAt(position);
    });
  }

  // membuka halaman tambah biodata
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormBiodata()));
    if (result == 'save') {
      await _getAllBiodata();
    }
  }

  //membuka halaman edit biodata
  Future<void> _openFormEdit(Biodata biodata) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormBiodata(biodata: biodata)));
    if (result == 'update') {
      await _getAllBiodata();
    }
  }
}
