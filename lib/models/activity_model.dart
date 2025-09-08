class ActivityModel {
  String? selectedDate;
  String? deskripsiKegiatan;
  String? targetKegiatan;
  String? realisasiKegiatan;

  ActivityModel({
    this.selectedDate,
    this.deskripsiKegiatan,
    this.targetKegiatan,
    this.realisasiKegiatan,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      deskripsiKegiatan: json['deskripsi_kegiatan'],
      targetKegiatan: json['target_kegiatan'],
      realisasiKegiatan: json['realisasi_kegiatan'],
    );
  }

}