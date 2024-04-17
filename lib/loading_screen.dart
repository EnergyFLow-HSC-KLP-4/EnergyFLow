import 'dart:async';
import 'package:flutter/material.dart';
import 'Beranda.dart'; // Pastikan Anda mengimpor file Beranda.dart dengan benar

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menunda navigasi ke tampilan Beranda setelah 3 detik
    Timer(const Duration(seconds: 2), () {
      // Navigasi ke Beranda dan ganti tata letak (layout) dengan menggantikan
      // LoadingScreen dari tumpukan navigasi
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000), // Durasi transisi
          pageBuilder: (_, __, ___) => Beranda(key: UniqueKey()), // Tambahkan key di sini
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Loading Screen.png'), 
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
