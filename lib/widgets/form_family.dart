import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/upload_file.dart';
import 'package:rhb_mobile_flutter/widgets/text_field.dart';
import 'package:intl/intl.dart';
import 'package:rhb_mobile_flutter/models/utils/picked-file.dart';

typedef Change = void Function(String value);
typedef FilePick = void Function(PickFile data);

class FamilyForm extends StatelessWidget {
  FamilyForm({
    @required this.onChange,
    @required this.name,
    @required this.birthPlace,
    @required this.bod,
    @required this.gender,
    @required this.dateFormat,
    @required this.section,
    @required this.dropdownOnChange,
    this.filePick,
    this.file,
  });

  final Function onChange;
  final TextEditingController name;
  final TextEditingController birthPlace;
  final TextEditingController bod;
  final String section;
  final String gender;
  final String dateFormat;
  final Change dropdownOnChange;
  final PickFile file;
  final FilePick filePick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RehobotTextField(
          hintText: 'Nama Lengkap*',
          capitalization: TextCapitalization.sentences,
          validator: (val) {},
          controller: name,
          onChanged: onChange,
        ),
        Row(
          children: [
            Expanded(
              child: RehobotTextField(
                hintText: 'Tempat Lahir*',
                capitalization: TextCapitalization.sentences,
                validator: (val) {},
                controller: birthPlace,
                onChanged: onChange,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              flex: 1,
              child: DateTimeField(
                onChanged: onChange,
                controller: bod,
                style: TextStyle(
                  color: RehobotThemes.indigoRehobot,
                ),
                format: DateFormat(dateFormat),
                onShowPicker: (context, currentValue) async {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2100));
                },
                decoration: InputDecoration(
                  hintText: 'DD/MM/YYYY',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today_sharp,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: gender == '' ? null : gender,
                hint: Text(
                  'Jenis Kelamin',
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
                  dropdownOnChange(value);
                },
                items: <String>['Laki-laki', 'Perempuan']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        section == 'add'
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: RehobotFileUpload(
                  file: file,
                  title: 'Upload Akta Lahir*',
                  filePicked: (value) {
                    filePick(value);
                  },
                ),
              )
            : Container(),
      ],
    );
  }
}
