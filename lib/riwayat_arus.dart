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
      appBar: AppBar(
        backgroundColor: Color(0xFF3876BF),
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/kembali.png',
            width: 25,
            height: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 25,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Riwayat Pemantauan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Arus listrik',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('riwayat_arus')
                    .orderBy('waktu', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return DataTable(
                    columnSpacing: 44,
                    dataRowHeight: 50,
                    headingRowHeight: 70,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 16, 87, 122),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    columns: [
                      DataColumn(
                        label: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 15.0),
                          child: Text(
                            'Waktu',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Arus Masuk',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Arus Keluar',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    rows: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
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
                                  data['arus_masuk'].toString(),
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'mA',
                                  style: TextStyle(color: Colors.white),
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
                                  data['arus_keluar'].toString(),
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'mA',
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
            ),
          ],
        ),
      ),
    );
  }
}
