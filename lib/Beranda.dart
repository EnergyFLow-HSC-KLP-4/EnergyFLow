import 'package:energyflow/riwayat_air.dart';
import 'package:energyflow/riwayat_arus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int battery = 0; 
  int kuatArus = 0;
  int kecepatanAir = 0;

  @override
  void initState(){
    super.initState();
    //manggil firebase
    FirebaseDatabase.instance
        .ref()
        .child('baterai') // Menggunakan '' sebagai kunci
        .onValue
        .listen((event) {
      print('Nilai dari Firebase: ${event.snapshot.value}');
      // Memeriksa apakah event.snapshot.value tidak null sebelum mengaksesnya
      if (event.snapshot.value != null) {
        // Konversi nilai ke tipe data int
        setState(() {
          battery = int.parse(event.snapshot.value.toString());
        });
      }
    });

    FirebaseDatabase.instance
        .ref()
        .child('kuat_arus') // Menggunakan '' sebagai kunci
        .onValue
        .listen((event) {
      print('Nilai dari Firebase: ${event.snapshot.value}');
      // Memeriksa apakah event.snapshot.value tidak null sebelum mengaksesnya
      if (event.snapshot.value != null) {
        // Konversi nilai ke tipe data int
        setState(() {
          kuatArus = int.parse(event.snapshot.value.toString());
        });
      }
    });

    FirebaseDatabase.instance
        .ref()
        .child('kecepatan_air') // Menggunakan '' sebagai kunci
        .onValue
        .listen((event) {
      print('Nilai dari Firebase: ${event.snapshot.value}');
      // Memeriksa apakah event.snapshot.value tidak null sebelum mengaksesnya
      if (event.snapshot.value != null) {
        // Konversi nilai ke tipe data int
        setState(() {
          kecepatanAir = int.parse(event.snapshot.value.toString());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menentukan path gambar berdasarkan nilai variabel battery
    String imagePath;
    if (battery == 0) {
      imagePath = 'assets/Battery 0.png';
    } else if (battery <= 30) {
      imagePath = 'assets/Battery 30.png';
    } else if (battery <= 99) {
      imagePath = 'assets/Battery 70.png';
    } else {
      imagePath = 'assets/Battery 100.png';
    }

    return Scaffold(
      backgroundColor: Color(0xFF192655),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              top: 58,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Energy',
                    style: TextStyle(
                      fontFamily: 'RubikOne',
                      fontSize: 56,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Text(
                    'Flow',
                    style: TextStyle(
                      fontFamily: 'Felipa',
                      fontSize: 56,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 155,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          imagePath,
                          width: 200, // Sesuaikan lebar gambar dengan kebutuhan Anda
                          height: 109, // Sesuaikan tinggi gambar dengan kebutuhan Anda
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 10), // Spasi antara gambar dan teks
                        Text(
                          '$battery%', // Teks yang ingin Anda tambahkan
                          style: TextStyle(
                            fontSize: 31, // Ukuran teks
                            color: Color(0xFFA8E483), // Warna teks
                            fontWeight: FontWeight.bold, // Ketebalan teks
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 0), // Spacer antara gambar dan bentuk di bawahnya
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 20), // Atur jarak dari atas
                      width: 400, // Atur lebar sesuai kebutuhan
                      height: 600, // Atur tinggi sesuai kebutuhan
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF5DC), // Warna luar
                        borderRadius: BorderRadius.circular(57), // Bentuk sudut luar
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 35), // Atur jarak antara kotak dan bagian atas container
                        child: Column( // Gunakan Column untuk menampung dua kotak
                          children: [
                            Container(
                              width: 300,
                              height: 250, // Tinggi diperbesar agar ada ruang untuk chart
                              child: Column(
                                children: [
                                  Container(
                                    width: 300,
                                    height: 220,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF3876BF),
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 20,
                                          offset: Offset(0, 14),
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                          top: 10,
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              'Kuat Arus Masuk',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 30,
                                          child: Container(
                                            width: 150, // Atur lebar sesuai kebutuhan chart
                                            height: 150, // Atur tinggi sesuai kebutuhan chart
                                            child: Stack(
                                              children: [
                                                PieChart(
                                                  PieChartData(
                                                    startDegreeOffset: 123,
                                                    sectionsSpace: 0,
                                                    centerSpaceRadius: 50,
                                                    sections: [
                                                      PieChartSectionData(
                                                        value: 45,
                                                        color: Color(0xFFA8E483),
                                                        radius: 18,
                                                        showTitle: false,
                                                      ),
                                                      PieChartSectionData(
                                                        value: 10,
                                                        color: Colors.grey.shade400,
                                                        radius: 8,
                                                        showTitle: false,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  //now perfect
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: 65,
                                                        width: 65,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.grey.shade200,
                                                                blurRadius: 5.0,
                                                                spreadRadius: 5.0,
                                                                offset: const Offset(1.0, 1.0)),
                                                          ],
                                                        ),
                                                        child:  Center(
                                                          child: Text(
                                                            '$kuatArus V',
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                    
                                    Positioned(
                                      top: 170, // Atur posisi vertikal sesuai kebutuhan
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => RiwayatArus()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(150, 10), // Atur lebar dan tinggi sesuai kebutuhan
                                          backgroundColor: Colors.transparent, // Ubah warna latar belakang menjadi transparan
                                          elevation: 0, // Hapus efek elevasi
                                        ),
                                        child: Text(
                                          'Riwayat',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 0), // Spasi antara dua kotak
                            Container(
                              width: 300, // Atur lebar sesuai kebutuhan box dalam
                              height: 230, // Atur tinggi sesuai kebutuhan box dalam
                              decoration: BoxDecoration(
                                color: Color(0xFFE1AA74), // Warna dalam
                                borderRadius: BorderRadius.circular(40), // Bentuk sudut dalam
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3), // Warna bayangan
                                    spreadRadius: 2, // Seberapa jauh bayangan menyebar
                                    blurRadius: 20, // Seberapa kabur bayangan
                                    offset: Offset(0, 14), // Perpindahan bayangan (x, y)
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment(0, -0.85), // Atur posisi teks secara manual
                                      child: Text(
                                        'Kecepatan Air', // Teks yang ingin Anda tambahkan
                                        style: TextStyle(
                                          fontSize: 20, // Ukuran teks
                                          color: Colors.white, // Warna teks
                                          fontWeight: FontWeight.bold, // Ketebalan teks
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 0),
                                    
                                    Positioned(
                                      bottom: 40,
                                      child: Container(
                                        width: 150, // Atur lebar sesuai kebutuhan chart
                                        height: 140, // Atur tinggi sesuai kebutuhan chart
                                        child: Stack(
                                          children: [ 
                                            PieChart(
                                              PieChartData(
                                                startDegreeOffset: 123,
                                                sectionsSpace: 0,
                                                centerSpaceRadius: 50,
                                                sections: [
                                                  PieChartSectionData(
                                                    value: 45,
                                                    color: Colors.blue.shade900,
                                                    radius: 19,
                                                    showTitle: false,
                                                  ),
                                                  PieChartSectionData(
                                                    value: 10,
                                                    color: Colors.grey.shade400,
                                                    radius: 8,
                                                    showTitle: false,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned.fill(
                                              //now perfect
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 65,
                                                    width: 65,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey.shade200,
                                                            blurRadius: 5.0,
                                                            spreadRadius: 5.0,
                                                            offset: const Offset(1.0, 1.0)),
                                                      ],
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        '$kecepatanAir m/s',
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 180, // Atur posisi vertikal sesuai kebutuhan
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => RiwayatAir()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: Size(150, 10), // Atur lebar dan tinggi sesuai kebutuhan
                                          backgroundColor: Colors.transparent, // Ubah warna latar belakang menjadi transparan
                                          elevation: 0, // Hapus efek elevasi
                                        ),
                                        child: Text(
                                          'Riwayat',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
