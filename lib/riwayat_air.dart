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
      backgroundColor: Color(0xFFE1AA74),
      appBar: AppBar(
        backgroundColor: Color(0xFFE1AA74),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/kembali.png',
            width: 30,
            height: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 30,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Riwayat Pemantauan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Kuat Arus Air',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        centerTitle: true, // Posisikan judul teks ke tengah
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(30),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('riwayat_air')
                    .orderBy('waktu', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  return DataTable(
                    columnSpacing: 86,
                    headingRowHeight: 70,
                    dataRowHeight: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF9F652B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    columns: [
                      DataColumn(
                        label: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Waktu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Mempertahankan warna teks
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Kuat Arus Air (m/s)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Mempertahankan warna teks
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      DateTime waktu =
                          (data['waktu'] as Timestamp).toDate();
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
                                SizedBox(width: 5),
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
    );
  }
}
