class UserHelper {
  getCurrentDate(String userBirthday) {
    var date = new DateTime.now().toString();
    var userBirth = DateTime.parse(userBirthday);
    var currentDate = DateTime.parse(date);

    var userFormated = "${userBirth.day}-${userBirth.month}";
    var formattedDate = "${currentDate.day}-${currentDate.month}";

    if (userFormated == formattedDate) {
      return true;
    } else {
      return false;
    }
  }
}
