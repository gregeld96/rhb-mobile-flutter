import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HotlineSuccess extends StatelessWidget {
  HotlineSuccess({
    @required this.userPhone,
    @required this.userFullName,
    @required this.userEmail,
    @required this.hotlineAddress,
    @required this.hotlineCity,
    @required this.hotlineCodePost,
    @required this.hotlineNumber,
    @required this.section,
  });

  final String userPhone;
  final String userFullName;
  final String userEmail;
  final String hotlineAddress;
  final String hotlineCity;
  final String hotlineCodePost;
  final String hotlineNumber;
  final String section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          RehobotGeneralText(
            title:
                'Kami akan menjadwalkan reminder pada H-7, H-3, H-1 sebelum jadwal $section melalui:',
            alignment: Alignment.centerLeft,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/phone-number-icon.svg',
                  width: 20,
                  height: 20,
                  alignment: Alignment.centerLeft,
                  color: RehobotThemes.indigoRehobot,
                ),
                SizedBox(
                  width: 14,
                ),
                RehobotGeneralText(
                  title: '$userPhone ($userFullName)',
                  alignment: Alignment.centerLeft,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              left: 10,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/email-icon.svg',
                  width: 17,
                  height: 17,
                  alignment: Alignment.centerLeft,
                  color: RehobotThemes.indigoRehobot,
                ),
                SizedBox(
                  width: 10,
                ),
                RehobotGeneralText(
                  title: userEmail,
                  alignment: Alignment.centerLeft,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
          if (section == 'pembaptisan')
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: RehobotGeneralText(
                title:
                    'Anda perlu mengirimkan dokumen berupa pas foto 3x4 (2 lembar) ke setpus untuk keperluan akta baptis. (batas pengumpulan H+7 setelah form diisi)',
                alignment: Alignment.centerLeft,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          if (section != 'pembaptisan')
            SizedBox(
              height: 15,
            ),
          RehobotGeneralText(
            title:
                'Dan untuk pengiriman dokumen hasil dari kegiatan $section di alamat:',
            alignment: Alignment.centerLeft,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/location-pin-icon.svg',
                  width: 20,
                  height: 20,
                  alignment: Alignment.centerLeft,
                  color: RehobotThemes.indigoRehobot,
                ),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: RehobotGeneralText(
                    title: '$hotlineAddress, $hotlineCity, $hotlineCodePost',
                    alignment: Alignment.centerLeft,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
              left: 10,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/hotline-icon.svg',
                  width: 17,
                  height: 17,
                  alignment: Alignment.centerLeft,
                  color: RehobotThemes.indigoRehobot,
                ),
                SizedBox(
                  width: 10,
                ),
                RehobotGeneralText(
                  title: hotlineNumber,
                  alignment: Alignment.centerLeft,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
