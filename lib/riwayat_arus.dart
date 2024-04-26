import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiwayatArus extends StatefulWidget {
  const RiwayatArus({Key? key}) : super(key: key);

  @override
  State<RiwayatArus> createState() => _RiwayatArusState();
}

class _RiwayatArusState extends State<RiwayatArus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3876BF),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 50.0, left: 5.0, right: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                              context); // Kembali ke halaman sebelumnya
                        },
                        child: Image.asset(
                          'assets/kembali.png',
                          width: 25,
                          height: 25,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 50.0, left: 10.0, right: 8.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Riwayat Pemantauan',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Arus listrik',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height:
                        10), // Padding untuk memberi ruang agar tabel tidak tumpang tindih dengan tombol kembali
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(16),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('riwayat_arus')
                        .orderBy('waktu')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      // Tampilkan data dari Firestore menggunakan tabel atau widget lain sesuai kebutuhan
                      return DataTable(
                        columnSpacing: 44, // Atur jarak antar kolom
                        dataRowHeight: 50, // Atur tinggi baris data
                        headingRowHeight: 70, // Atur tinggi baris header
                        decoration: BoxDecoration(
                          // Atur dekorasi tabel
                          color: const Color.fromARGB(
                              255, 16, 87, 122), // Warna latar belakang tabel
                          borderRadius:
                              BorderRadius.circular(10), // Bentuk border tabel
                        ),
                        columns: [
                          DataColumn(
                            label: Container(
                              alignment: Alignment
                                  .centerLeft, // Mengatur posisi teks ke kiri
                              padding: EdgeInsets.only(
                                  left:
                                      15.0), // Geser teks ke kanan sejauh 15 piksel
                              child: Text(
                                'Waktu',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text('Arus Masuk',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                          DataColumn(
                            label: Text('Arus Keluar',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                        rows: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;
                          // Konversi timestamp Firestore ke DateTime
                          DateTime waktu =
                              (data['waktu'] as Timestamp).toDate();
                          // Format DateTime menjadi string dengan format yang diinginkan
                          return DataRow(
                            cells: [
                              DataCell(
                                Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Atur posisi teks di tengah secara horizontal
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Atur posisi teks di tengah secara vertikal
                                  children: [
                                    Text(DateFormat('yyyy-MM-dd').format(waktu),
                                        style: TextStyle(color: Colors.white)),
                                    Text(DateFormat('HH:mm:ss').format(waktu),
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Atur posisi teks di tengah secara horizontal
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Atur posisi teks di tengah secara vertikal
                                  children: [
                                    Text(data['arus_masuk'].toString(),
                                        style: TextStyle(color: Colors.white)),
                                    SizedBox(width: 5), // Spacer
                                    Text('V',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center, // Atur posisi teks di tengah secara horizontal
                                  crossAxisAlignment: CrossAxisAlignment
                                      .center, // Atur posisi teks di tengah secara vertikal
                                  children: [
                                    Text(data['arus_keluar'].toString(),
                                        style: TextStyle(color: Colors.white)),
                                    SizedBox(width: 5), // Spacer
                                    Text('V',
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
