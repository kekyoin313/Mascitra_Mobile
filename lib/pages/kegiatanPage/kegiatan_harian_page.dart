import 'package:flutter/material.dart';
import 'package:simpeg_mascitra_mobile/models/activity_model.dart';
import 'package:simpeg_mascitra_mobile/pages/kegiatanPage/kegiatan_berhasil_page.dart';
import 'package:simpeg_mascitra_mobile/widgets/custom_app_bar.dart';
import 'package:simpeg_mascitra_mobile/widgets/custom_input_field.dart';
import '../utils/colors.dart';
import 'pilih_tanggal_page.dart';
import 'riwayat_page.dart';

class KegiatanHarianPage extends StatefulWidget {
  @override
  _KegiatanHarianPageState createState() => _KegiatanHarianPageState();
}

class _KegiatanHarianPageState extends State<KegiatanHarianPage> {
  final ActivityModel activityModel = ActivityModel();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController realisasiController = TextEditingController();

  @override
  void dispose() {
    deskripsiController.dispose();
    targetController.dispose();
    realisasiController.dispose();
    super.dispose();
  }

  Widget _buildDateSection() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(
          Icons.calendar_today_outlined,
          color: AppColors.grey,
          size: 20,
        ),
        title: Text(
          'Pilih Tanggal',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.text,
            fontFamily: 'Poppins',
          ),
        ),
        subtitle: Text(
          activityModel.selectedDate ?? 'Tidak Ada Data',
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
            fontFamily: 'Poppins',
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.grey,
        ),
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PilihTanggalPage()),
          );
          if (result != null && result is String) {
            setState(() {
              activityModel.selectedDate = result;
            });
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        title: 'Kegiatan Harian',
        showBackButton: true,
        showActions: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildDateSection(),
                  CustomInputField(
                    title: 'Deskripsi Kegiatan',
                    controller: deskripsiController,
                  ),
                  CustomInputField(
                    title: 'Target Kegiatan',
                    controller: targetController,
                  ),
                  CustomInputField(
                    title: 'Realisasi Kegiatan',
                    controller: realisasiController,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PengajuanBerhasilPage(),
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
                      'Simpan',
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
        ],
      ),
    );
  }
}