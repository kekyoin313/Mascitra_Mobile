// lib/pages/pilih_tanggal_page.dart

import 'dart:ui'; // Diperlukan untuk ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart'; // Diperlukan untuk locale
import 'package:simpeg_mascitra_mobile/widgets/custom_app_bar.dart';
import 'package:table_calendar/table_calendar.dart'; // Import package table_calendar
import '../utils/colors.dart';

class PilihTanggalPage extends StatefulWidget {
  @override
  _PilihTanggalPageState createState() => _PilihTanggalPageState();
}

class _PilihTanggalPageState extends State<PilihTanggalPage> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Inisialisasi locale untuk bahasa Indonesia
    initializeDateFormatting('id_ID', null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Pilih Tanggal',
        showBackButton: true,
        showActions: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Widget untuk menampilkan tanggal yang dipilih (tetap sama)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.calendar_today_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      title: Text(
                        'Tanggal Kegiatan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.text,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      subtitle: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.grey,
                      ),
                      onTap: () {
                        _showDatePicker(); // Panggil date picker baru
                      },
                    ),
                  ),
                  Spacer(),
                  // Tombol 'Pilih Tanggal' (tetap sama)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        String formattedDate =
                            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
                        Navigator.pop(context, formattedDate);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Pilih Tanggal',
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
            ),
          ),
        ],
      ),
    );
  }

  // === METHOD LAMA DIHAPUS DAN DIGANTI DENGAN YANG DI BAWAH INI ===

  void _showDatePicker() {
    // Variabel sementara untuk menampung tanggal yang dipilih di dalam dialog
    DateTime tempSelectedDate = selectedDate;

    showDialog(
      context: context,
      barrierDismissible: true, // Bisa ditutup dengan klik di luar dialog
      builder: (context) {
        // StatefulBuilder agar UI di dalam dialog bisa di-update
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), // Efek blur
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    // Menggunakan AppColors.primary agar konsisten
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Ukuran mengikuti konten
                    children: [
                      TableCalendar(
                        locale: 'id_ID', // Set bahasa ke Indonesia
                        focusedDay: tempSelectedDate,
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        // Menandai tanggal yang dipilih
                        selectedDayPredicate: (day) => isSameDay(tempSelectedDate, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          // Update UI di dalam dialog saat tanggal baru dipilih
                          dialogSetState(() {
                            tempSelectedDate = selectedDay;
                          });
                        },
                        // Styling header kalender
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Styling untuk tanggal
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
                              selectedDate = tempSelectedDate;
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
                            "Choose Date",
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