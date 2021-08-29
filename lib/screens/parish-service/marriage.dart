import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rhb_mobile_flutter/controllers/parish/marriage.dart';
import 'package:get/get.dart';
import 'package:rhb_mobile_flutter/models/parish-service/parish-data.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/button.dart';
import 'package:rhb_mobile_flutter/widgets/general_text.dart';
import 'package:rhb_mobile_flutter/widgets/text_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart' as flutterDate;
import 'package:rhb_mobile_flutter/helpers/date.dart' as formatDate;

class MarriageParishScreen extends StatelessWidget {
  final MarriageParishController controller =
      Get.put(MarriageParishController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MarriageParishController>(builder: (_) {
      if (_.listEvent.length < 1 || _.listEvent == null) {
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image(
                width: Get.context.width / 2,
                image: AssetImage(
                    'assets/images/no-schedule-registration-complete-img.png'),
              ),
              SizedBox(
                height: 10,
              ),
              RehobotGeneralText(
                title: 'Tidak ada jadwal BPN',
                alignment: Alignment.center,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                alignText: TextAlign.center,
              )
            ],
          ),
        );
      } else {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              RehobotGeneralText(
                title: 'Note:',
                alignment: Alignment.centerLeft,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  RehobotGeneralText(
                    title: '*',
                    alignment: Alignment.topCenter,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: RehobotGeneralText(
                      title:
                          'Tanggal pernikahan harus berjarak 3 bulan dari tanggal bimbingan pra-nikah, oleh karena itu tanggal pernikahan disesuaikan dengan tanggal bimbingan.',
                      alignment: Alignment.centerLeft,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              DropdownButton<String>(
                value: _.bpnDate,
                hint: Text(
                  'Bimbing Pra Nikah',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                isExpanded: true,
                style: const TextStyle(color: RehobotThemes.indigoRehobot),
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
                onChanged: (value) {
                  _.dropDownChange(value);
                },
                items:
                    _.listEvent.map<DropdownMenuItem<String>>((dynamic value) {
                  return DropdownMenuItem<String>(
                    value: value.bpnDate,
                    child: Text(
                        formatDate.DateFormat().backToFront(value.bpnDate)),
                  );
                }).toList(),
              ),
              DateTimeField(
                onChanged: (val) {
                  _.dateCheck();
                },
                controller: _.marriageDate,
                style: TextStyle(
                  color: RehobotThemes.indigoRehobot,
                  fontSize: 16,
                ),
                format: flutterDate.DateFormat('dd/MM/yyyy'),
                onShowPicker: (context, currentValue) async {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: DateTime.parse(_.bpnDate),
                      lastDate: DateTime(2100));
                },
                decoration: InputDecoration(
                  hintText: 'Pernikahan',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today_sharp,
                    size: 18,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              RehobotGeneralText(
                title: 'Nama Pasangan',
                alignment: Alignment.centerLeft,
                fontSize: 24,
                fontWeight: FontWeight.normal,
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                child: Column(
                  children: [
                    RehobotTextField(
                      hintText: 'Nama Pasangan Pria',
                      validator: (val) {},
                      controller: _.maleName,
                      onChanged: (val) {
                        _.checkValue();
                      },
                      inputAction: TextInputAction.next,
                    ),
                    RehobotTextField(
                      hintText: 'Nama Pasangan Wanita',
                      validator: (val) {},
                      controller: _.womanName,
                      onChanged: (val) {
                        _.checkValue();
                      },
                      inputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              RehobotButton().roundedButton(
                title: 'submit'.toUpperCase(),
                context: context,
                height: 10,
                widthDivider: 40,
                textColor: RehobotThemes.pageRehobot,
                buttonColor: _.isValid
                    ? RehobotThemes.activeRehobot
                    : RehobotThemes.inactiveRehobot,
                onPressed: _.isValid
                    ? () {
                        _.selectEvent();
                      }
                    : null,
              ),
              SizedBox(
                height: 25,
              )
            ],
          ),
        );
      }
    });
  }
}
