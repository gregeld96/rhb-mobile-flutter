import 'package:flutter/material.dart';
import 'package:rhb_mobile_flutter/models/utils/address_model.dart';
import 'package:rhb_mobile_flutter/models/utils/picked-file.dart';
import 'package:rhb_mobile_flutter/utils/themes.dart';
import 'package:rhb_mobile_flutter/widgets/text_field.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:rhb_mobile_flutter/widgets/upload_file.dart';

typedef DropdownChange = void Function(String section, String value);
typedef FilePick = void Function(String belongs, PickFile data);

class PersonalForm extends StatelessWidget {
  PersonalForm({
    @required this.section,
    @required this.page,
    @required this.name,
    this.relation,
    @required this.gender,
    this.birthPlace,
    this.bod,
    this.occupation,
    this.email,
    @required this.phone,
    this.password,
    this.confirmPassword,
    @required this.addressInput,
    @required this.areaInput,
    @required this.address,
    @required this.provinces,
    @required this.cities,
    @required this.districts,
    @required this.subdistricts,
    @required this.codePost,
    @required this.onChanged,
    this.dateFormat,
    @required this.dropdownChange,
    this.filePick,
    this.file,
    this.readOnly,
    this.birthFile,
    this.baptismFile,
    this.identificationFile,
    this.familyFile,
  });

  final String section;
  final String page;
  final TextEditingController name;
  final TextEditingController relation;
  final String gender;
  final String occupation;
  final TextEditingController birthPlace;
  final TextEditingController bod;
  final TextEditingController email;
  final TextEditingController phone;
  final TextEditingController password;
  final TextEditingController confirmPassword;
  final TextEditingController addressInput;
  final TextEditingController areaInput;
  final Address address;
  final List<ProvinceResModel> provinces;
  final List<CityResModel> cities;
  final List<DistrictResModel> districts;
  final List<Kelurahan> subdistricts;
  final List<CodePost> codePost;
  final Function(dynamic) onChanged;
  final String dateFormat;
  final DropdownChange dropdownChange;
  final PickFile file;
  final PickFile birthFile;
  final PickFile baptismFile;
  final PickFile identificationFile;
  final PickFile familyFile;
  final FilePick filePick;
  final bool readOnly;

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
          onChanged: onChanged,
        ),
        if (section == 'personal')
          Row(
            children: [
              Expanded(
                child: RehobotTextField(
                  hintText: 'Tempat Lahir*',
                  capitalization: TextCapitalization.sentences,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: birthPlace,
                  onChanged: onChanged,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: DateTimeField(
                  onChanged: onChanged,
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
        if (section == 'other')
          RehobotTextField(
            hintText: 'Hubungan*',
            capitalization: TextCapitalization.sentences,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: relation,
            onChanged: onChanged,
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
                  dropdownChange('gender', value);
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
            if (section == 'personal')
              SizedBox(
                width: 10,
              ),
            if (section == 'personal')
              Expanded(
                child: DropdownButton<String>(
                  value: occupation == '' ? null : occupation,
                  hint: Text(
                    'Pekerjaan*',
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
                    dropdownChange('occupation', value);
                  },
                  items: <String>[
                    'Pegawai Negri',
                    'Pegawai Swasta',
                    'Pekerja Lepas',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
        RehobotTextField(
          hintText: 'Alamat Rumah*',
          validator: (val) {},
          controller: addressInput,
          onChanged: onChanged,
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: address.province,
                hint: Text(
                  'Provinsi*',
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
                  dropdownChange('province', value);
                },
                items: provinces
                    .map<DropdownMenuItem<String>>((ProvinceResModel value) {
                  return DropdownMenuItem<String>(
                    value: value.provinsi,
                    child: Text(value.provinsi),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButton<String>(
                value: address.city,
                hint: Text(
                  'Kota*',
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
                  dropdownChange('city', value);
                },
                items:
                    cities.map<DropdownMenuItem<String>>((CityResModel value) {
                  return DropdownMenuItem<String>(
                    value: value.kabupatenKota,
                    child: Text(value.kabupatenKota),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: address.district,
                hint: Text(
                  'Kecamatan*',
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
                  dropdownChange('district', value);
                },
                items: districts
                    .map<DropdownMenuItem<String>>((DistrictResModel value) {
                  return DropdownMenuItem<String>(
                    value: value.kecamatan,
                    child: Text(value.kecamatan),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: DropdownButton<String>(
                value: address.subdistrict,
                hint: Text(
                  'Kelurahan*',
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
                  dropdownChange('subdistrict', value);
                },
                items: subdistricts
                    .map<DropdownMenuItem<String>>((Kelurahan value) {
                  return DropdownMenuItem<String>(
                    value: value.kelurahan,
                    child: Text(value.kelurahan),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: address.codePost,
                hint: Text(
                  'Kode Pos*',
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
                  dropdownChange('codePost', value);
                },
                items: codePost.map<DropdownMenuItem<String>>((CodePost value) {
                  return DropdownMenuItem<String>(
                    value: value.kdPost,
                    child: Text(
                      value.kdPost,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: RehobotTextField(
                hintText: 'RT/RW',
                validator: (val) {},
                controller: areaInput,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
        RehobotTextField(
          hintText: 'No. Hp*',
          validator: (val) {},
          controller: phone,
          onChanged: onChanged,
          inputType: TextInputType.phone,
        ),
        if (section == 'personal')
          RehobotTextField(
            hintText: 'Email*',
            validator: (val) {},
            controller: email,
            readOnly: readOnly ?? false,
            onChanged: onChanged,
          ),
        if (page == 'register')
          Container(
            child: Column(
              children: [
                RehobotTextField(
                  hintText: 'Password*',
                  suffixIcon: true,
                  validator: (val) {},
                  controller: password,
                  onChanged: onChanged,
                ),
                RehobotTextField(
                  hintText: 'Ulangi Password',
                  suffixIcon: true,
                  validator: (val) {},
                  controller: confirmPassword,
                  onChanged: onChanged,
                ),
              ],
            ),
          ),
        SizedBox(
          height: 25,
        ),
        if (page == 'register')
          RehobotFileUpload(
            file: file,
            title: 'Upload KTP*',
            filePicked: (value) {
              filePick('ktp', value);
            },
          ),
        if (page == 'baptism')
          RehobotFileUpload(
            file: file,
            title: 'Upload Akta Lahir*',
            filePicked: (value) {
              filePick('akta-lahir', value);
            },
          ),
        if (page == 'marriage')
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: RehobotFileUpload(
                  file: birthFile,
                  title: 'Upload Akta Lahir*',
                  filePicked: (value) {
                    filePick('birth', value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: RehobotFileUpload(
                  file: familyFile,
                  title: 'Upload Kartu Keluarga*',
                  filePicked: (value) {
                    filePick('family', value);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: RehobotFileUpload(
                  file: identificationFile,
                  title: 'Upload KTP*',
                  filePicked: (value) {
                    filePick('identification', value);
                  },
                ),
              ),
              RehobotFileUpload(
                file: baptismFile,
                title: 'Upload Akta baptis*',
                filePicked: (value) {
                  filePick('baptism', value);
                },
              ),
            ],
          )
      ],
    );
  }
}
