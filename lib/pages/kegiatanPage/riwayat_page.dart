import 'dart:ui'; // Diperlukan untuk ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:simpeg_mascitra_mobile/models/activity_model.dart';
import 'package:simpeg_mascitra_mobile/widgets/custom_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import '../utils/colors.dart';

class RiwayatPage extends StatefulWidget {
  // Constructor kembali sederhana, tanpa parameter
  const RiwayatPage({Key? key}) : super(key: key);

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  // State untuk menyimpan tanggal yang dipilih oleh pengguna
  DateTime? _selectedDate;

  // Data dummy untuk ditampilkan di kartu
  final List<ActivityModel> _dummyActivities = [
    ActivityModel(
      deskripsiKegiatan: 'Mengerjakan fitur login',
      targetKegiatan: 'Menyelesaikan UI dan integrasi API untuk autentikasi pengguna.',
      realisasiKegiatan: 'UI selesai, API sedang dalam proses integrasi.',
    ),
    ActivityModel(
      deskripsiKegiatan: 'Rapat dengan tim desain',
      targetKegiatan: 'Finalisasi mockup untuk halaman dashboard.',
      realisasiKegiatan: 'Mockup telah disetujui dengan beberapa revisi kecil.',
    ),
  ];
  
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('id_ID', null);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Riwayat Kegiatan Harian',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Bagian daftar kegiatan yang bisa di-scroll
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              // Kita hanya menampilkan data dummy, jadi itemCount sesuai panjang data dummy
              itemCount: _dummyActivities.length,
              itemBuilder: (context, index) {
                // Gunakan tanggal yang dipilih atau tanggal hari ini untuk header kartu
                final displayDate = _selectedDate ?? DateTime.now();
                return _buildActivityCard(_dummyActivities[index], displayDate);
              },
            ),
          ),
          // Bagian filter yang tetap di bawah
          _buildFilterSection(),
        ],
      ),
    );
  }

  // Widget untuk membuat kartu kegiatan
  Widget _buildActivityCard(ActivityModel activity, DateTime date) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Tanggal
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              DateFormat('d MMMM yyyy', 'id_ID').format(date),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          // Detail Kegiatan
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('Deskripsi Kegiatan', activity.deskripsiKegiatan),
                Divider(height: 24),
                _buildDetailRow('Target Kegiatan', activity.targetKegiatan),
                Divider(height: 24),
                _buildDetailRow('Realisasi Kegiatan', activity.realisasiKegiatan),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk baris detail di dalam kartu
  Widget _buildDetailRow(String title, String? content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.text,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 4),
        Text(
          content ?? 'Tidak ada data',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  // Widget untuk bagian filter di bawah
  Widget _buildFilterSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter Absensi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 12),
          // Pilihan Tanggal
          ListTile(
            leading: Icon(Icons.calendar_today_outlined, color: AppColors.primary),
            title: Text('Pilih Tanggal', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500)),
            subtitle: Text(
              _selectedDate == null
                  ? 'Tidak Ada Data'
                  : DateFormat('d MMMM yyyy', 'id_ID').format(_selectedDate!),
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: _showDatePicker, // Panggil method date picker
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          SizedBox(height: 20),
          // Tombol Cari
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Aksi simulasi saat tombol cari ditekan
                final message = _selectedDate == null
                  ? 'Silakan pilih tanggal terlebih dahulu'
                  : 'Simulasi: Mencari kegiatan untuk ${DateFormat('d MMMM yyyy', 'id_ID').format(_selectedDate!)}';
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppColors.primary,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Cari',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Method date picker yang Anda berikan
  void _showDatePicker() {
    DateTime tempSelectedDate = _selectedDate ?? DateTime.now();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TableCalendar(
                        locale: 'id_ID',
                        focusedDay: tempSelectedDate,
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        selectedDayPredicate: (day) => isSameDay(tempSelectedDate, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          dialogSetState(() {
                            tempSelectedDate = selectedDay;
                          });
                        },
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Update state halaman utama saat tombol ditekan
                            setState(() {
                              _selectedDate = tempSelectedDate;
                            });
                            Navigator.pop(context); // Tutup dialog
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            "Pilih Tanggal", // Diubah ke Bahasa Indonesia
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}