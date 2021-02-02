import 'package:flutter/material.dart';

class ColorsState {
  static Color colorPrimary = HexColor("#f37429");
  static Color colorPrimaryBlue = HexColor("#0066B3");
  static Color colorPrimaryRed = HexColor("#DD0E04");
  static Color colorPrimaryGreen = HexColor("#79C141");
  static Color colorPrimarylightBlue = HexColor("#7CB5EC");
  static Color colorPrimarybackground = HexColor("#F6F6F6");
  static Color colorPrimaryyellow = HexColor("#FDFFA9");

  //background
  static Color backgroundColor = HexColor("#7C94A6");
  static Color catatan = HexColor("#F2CC91");
  static Color appointment = HexColor("#F2CC91");
  static Color apoteker = HexColor("#8D90D9");
  static Color supplier = HexColor("#F2C3C2");
  static Color tekniker = HexColor("#74A6A1");
  static Color resep = HexColor("#A67D7C");
  static Color lainnya = HexColor("#869FB3");
  static Color nearbyapotek = HexColor("#A68F6C");
  static Color nearbyklinik = HexColor("#82A674");
  static Color kategori_semua = HexColor("#B6D8F2");
  static Color kategori_mulut = HexColor("#74A6A1");
  static Color kategori_farmasi = HexColor("#A67D7C");
  static Color kategori_umum = HexColor("#F2CC91");
  static Color tgl_artikel = HexColor("#B4B4B4");
  static Color referensi_bg = HexColor("#F2F2F2");
  static Color referensi_text = HexColor("#74A6A1");

  static Color appointment_teks = HexColor("#736045");


  static Color colorAccent = HexColor("#f47128");
  static Color colorWhite = HexColor("#FFFFFF");
  static Color colorBlack = HexColor("#000000");
  static Color colorRed = HexColor("#EC262F");
  static Color bgDefault = HexColor("#EEEEEE");
  static Color colorLine = HexColor("#E3E3E3");
  static Color notificationDateBackground = HexColor("#ECECEC");
  static Color colorDarkGrey = HexColor("#707070");
  static Color colorRating = HexColor("#C5CA16");
  static Color greyBright = HexColor("#EBEBEB");
  static Color eventGrey1 = HexColor("#F4F4F4");
  static Color eventGrey2 = HexColor("#F0F0F0");
  static Color eventGrey3 = HexColor("#707070");
  static Color eventGrey4 = HexColor("#B5B4B4");
  static Color eventGrey5 = HexColor("#DDDDDD");
  static Color eventGrey6 = HexColor("#E9E9E9");
  static Color eventBlue = HexColor("#2456D4");
  static Color eventGreen = HexColor("#5DD285");
  static Color productFilterGrey = HexColor("#F5F4F2");
  static Color orange = HexColor("FDE1CA");
  static Color colorGoogle = HexColor("E85148");
  static Color colorFacebook = HexColor("3B5998");
  static Color darkOrange = HexColor("#f1974d");
  static Color shopGrey1 = HexColor("#F6F6F6");
  static Color shopGrey2 = HexColor("#B1B1B1");
  static Color shopGrey3 = HexColor("#DADADA");
  static Color shopGrey4 = HexColor("#717171");
  static Color shopGrey5 = HexColor("#525252");
  static Color shopGrey6 = HexColor("#D4D4D4");
  static Color shopGrey7 = HexColor("#DDDDDD");
  static Color shopGrey8 = HexColor("#B3B3B3");
  static Color shopGrey9 = HexColor("#6A6A6A");
  static Color shopGrey10 = HexColor("#EFEFEF");
  static Color shopGrey11 = HexColor("#7F7F7F");
  static Color shopGrey12 = HexColor("#C4C4C4");
  static Color shopGrey13 = HexColor("#FAFAFA");
  static Color shopGrey14 = HexColor("#979797");
  static Color shopGrey15 = HexColor("#F3F3F3");
  static Color shopOrange = HexColor("#F75A2C");
  static Color shopPurple = HexColor("#FD7EE1");
  static Color shopRose = HexColor("#F4DFCA");
  static Color shopRose2 = HexColor("#FDD8B9");
  static Color shopGold = HexColor("#F9D207");
  static Color shopOrange2 = HexColor("#F57F17");
  static Color shopOrange3 = HexColor("#E77C30");
  static Color shopOrange4 = HexColor("#F58A1F");
  static Color shopRed = HexColor("#FF0200");
  static Color reportGrey = HexColor("#F0F0F0");
  static Color reportGrey2 = HexColor("#A5A5A5");
  static Color moreMenuGradient1 = HexColor("#F09819");
  static Color moreMenuGradient2 = HexColor("#FF5858");
  static Color moreMenuGrey = HexColor("#F8F8F8");

  static MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}