import 'package:flutter/material.dart';
import 'package:simpeg_mascitra_mobile/models/activity_model.dart';
import 'package:simpeg_mascitra_mobile/pages/kegiatanPage/riwayat_page.dart';
// Hapus import AppColors jika tidak digunakan lagi di file ini
// import 'package:simpeg_mascitra_mobile/pages/utils/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final bool showActions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.onBackPressed,
    this.showActions = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Menggunakan Container sebagai dasar AppBar
    return Container(
      // Tinggi container adalah 80 + tinggi status bar
      // agar background bisa sampai ke atas layar
      height: MediaQuery.of(context).padding.top + 80,
      decoration: BoxDecoration(
        image: DecorationImage(
          // PASTIKAN Anda memiliki gambar di path ini.
          // Berdasarkan screenshot Anda, ini adalah gambar dengan pola oranye.
          image: AssetImage('assets/images/Grey.png'), // <-- SESUAIKAN PATH GAMBAR ANDA
          fit: BoxFit.cover,
        ),
      ),
      // SafeArea memastikan konten (icon, teks) tidak tertimpa status bar
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Menampilkan tombol kembali jika showBackButton bernilai true
              if (showBackButton)
                // Digabung agar spasi hanya muncul jika tombol ada
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      // Gunakan callback kustom atau default Navigator.pop
                      onPressed: onBackPressed ?? () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              
              // Judul AppBar
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              // Spacer akan mendorong widget setelahnya ke ujung kanan
              Spacer(),
              
              // Menampilkan tombol action jika showActions bernilai true
              if (showActions)
                IconButton(
                  icon: Icon(Icons.history, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RiwayatPage(),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // Tentukan tinggi area konten dari AppBar, yaitu 80
  // Scaffold akan menggunakan ini untuk mengatur posisi body
  Size get preferredSize => Size.fromHeight(80);
}