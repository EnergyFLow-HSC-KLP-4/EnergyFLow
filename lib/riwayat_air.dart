import 'package:energyflow/Beranda.dart';
import 'package:flutter/material.dart';

class RiwayatAir extends StatefulWidget {
  const RiwayatAir({Key? key}) : super(key: key);

  @override
  State<RiwayatAir> createState() => _RiwayatAirState();
}

class _RiwayatAirState extends State<RiwayatAir> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE1AA74), // Atur warna latar belakang sesuai kebutuhan
      body: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Beranda()),
                    );
                  },
                  child: Image.asset(
                    'assets/kembali.png', // Sesuaikan dengan path file logo kembali Anda
                    width: 40, // Atur lebar sesuai kebutuhan
                    height: 40, // Atur tinggi sesuai kebutuhan
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(), // Mengatur bentuk tombol menjadi lingkaran
                    backgroundColor: Colors.transparent, // Ubah warna latar belakang menjadi transparan
                    elevation: 0, // Hapus efek elevasi
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 50.0, left: 10.0, right: 8.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, // Mengatur posisi teks secara vertikal di atas
                    crossAxisAlignment: CrossAxisAlignment.center, // Mengatur posisi teks secara horizontal di tengah
                    children: [
                      Text(
                        'Riwayat Pemantauan',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), // Mengatur teks menjadi bold
                      ),
                      Text(
                        'Kuat Arus Air',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), // Mengatur teks menjadi bold
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}