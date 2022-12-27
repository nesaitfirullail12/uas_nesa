// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/biodata.dart';

class FormBiodata extends StatefulWidget {
  final Biodata? biodata;

  FormBiodata({this.biodata});

  @override
  // ignore: library_private_types_in_public_api
  _FormBiodataState createState() => _FormBiodataState();
}

class _FormBiodataState extends State<FormBiodata> {
  DbHelper db = DbHelper();

  TextEditingController? nim;
  TextEditingController? nama;
  TextEditingController? alamat;
  TextEditingController? jenisKelamin;
  TextEditingController? tglLahir;

  @override
  void initState() {
    nim = TextEditingController(
        text: widget.biodata == null ? '' : widget.biodata!.nim);

    nama = TextEditingController(
        text: widget.biodata == null ? '' : widget.biodata!.nama);

    alamat = TextEditingController(
        text: widget.biodata == null ? '' : widget.biodata!.alamat);

    jenisKelamin = TextEditingController(
        text: widget.biodata == null ? '' : widget.biodata!.jenisKelamin);

    tglLahir = TextEditingController(
        text: widget.biodata == null ? '' : widget.biodata!.tglLahir);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Biodata'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nim,
              decoration: InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nama,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: alamat,
              decoration: InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: jenisKelamin,
              decoration: InputDecoration(
                labelText: 'Jenis Kelamin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: tglLahir,
              decoration: InputDecoration(
                labelText: 'Tanggal Lahir',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.biodata == null)
                  ? Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertBiodata();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> upsertBiodata() async {
    if (widget.biodata != null) {
      //update
      await db.updateBiodata(
        Biodata.fromMap(
          {
            'id': widget.biodata!.id,
            'nim': nim!.text,
            'nama': nama!.text,
            'alamat': alamat!.text,
            'jenisKelamin': jenisKelamin!.text,
            'tglLahir': tglLahir!.text,
          },
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveBiodata(
        Biodata(
          nim: nim!.text,
          nama: nama!.text,
          alamat: alamat!.text,
          jenisKelamin: jenisKelamin!.text,
          tglLahir: tglLahir!.text,
        ),
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context, 'save');
    }
  }
}
