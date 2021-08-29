class DateFormat {
  String backToFront(date) {
    var temp = DateTime.parse(date);
    return "${temp.day}/${temp.month}/${temp.year}";
  }

  String frontParse(date) {
    var temp = date.split('/');
    return "${temp[2]}-${temp[1]}-${temp[0]} 00:00:00.000Z";
  }
}
