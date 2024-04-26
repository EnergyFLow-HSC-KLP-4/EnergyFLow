import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class RiwayatAir extends StatefulWidget {
  const RiwayatAir({Key? key}) : super(key: key);

  @override
  State<RiwayatAir> createState() => _RiwayatAirState();
}

class _RiwayatAirState extends State<RiwayatAir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:
          Color(0xFFE1AA74), // Atur warna latar belakang sesuai kebutuhan
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
                              'Kurat Arus Air',
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
                SizedBox(height: 20), // Berikan sedikit jarak dari atas
                Container(
                  padding: const EdgeInsets.all(16),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('riwayat_air')
                        .orderBy('waktu')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      // Tampilkan data dari Firestore menggunakan tabel atau widget lain sesuai kebutuhan
                      return DataTable(
                        columnSpacing: 115, // Atur jarak antar kolom
                        headingRowHeight: 70, // Atur tinggi baris header
                        dataRowHeight: 50, // Atur tinggi baris data
                        decoration: BoxDecoration(
                          color: Color(
                              0xFF9F652B), // Atur warna latar belakang tabel
                          borderRadius: BorderRadius.circular(
                              10), // Atur sudut border tabel
                        ),
                        columns: [
                          DataColumn(
                            label: Container(
                              alignment: Alignment.center,
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
                            label: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Kuat Arus Air (m/s)',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat('yyyy-MM-dd').format(waktu),
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      DateFormat('HH:mm:ss').format(waktu),
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      data['kuat_air'].toString(),
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                        width:
                                            5), // Spasi antara nilai dan teks "m/s"
                                    Text(
                                      'm/s',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
