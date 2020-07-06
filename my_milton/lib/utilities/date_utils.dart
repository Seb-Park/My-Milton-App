class DateUtilities {
  static String weekdayFromInt(int dayNo) {
    switch (dayNo) {
      case 1:
        {
          return "Monday";
        }
        break;

      case 2:
        {
          return "Tuesday";
        }
        break;

      case 3:
        {
          return "Wednesday";
        }

      case 4:
        {
          return "Thursday";
        }

      case 5:
        {
          return "Friday";
        }

      case 6:
        {
          return "Saturday";
        }

      default:
        {
          return "Sunday";
        }
        break;
    }
  }

  static String monthNameFromInt(int monthNo) {
    switch (monthNo) {
      case 1:
        {
          return "January";
        }
        break;

      case 2:
        {
          return "February";
        }
        break;

      case 3:
        {
          return "March";
        }
        break;

      case 4:
        {
          return "April";
        }
        break;

      case 5:
        {
          return "May";
        }
        break;

      case 6:
        {
          return "June";
        }
        break;

      case 7:
        {
          return "July";
        }
        break;

      case 8:
        {
          return "August";
        }
        break;

      case 9:
        {
          return "September";
        }
        break;
      case 10:
        {
          return "October";
        }
        break;

      case 11:
        {
          return "November";
        }
        break;

      default:
        {
          return "December";
        }
        break;
    }
  }

  static String todayOrYesterday(int today, int dayInQuestion) {
    if (dayInQuestion == today) {
      return "Today";
    } else {
      return "Yesterday";
    }
  }
}