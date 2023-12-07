
 DateTime parseDate(String dateString) {
  // Define a map to convert month abbreviations to month numbers
  const monthNumbers = {
    'Jan': '01', 'Feb': '02', 'Mar': '03', 'Apr': '04', 'May': '05', 'Jun': '06',
    'Jul': '07', 'Aug': '08', 'Sep': '09', 'Oct': '10', 'Nov': '11', 'Dec': '12',
  };

  // Extract the day, month abbreviation, and year from the dateString
  final day = dateString.substring(0, 2);
  final monthAbbr = dateString.substring(2, 5);
  final year = dateString.substring(5);

  // Convert the month abbreviation to a number
  final month = monthNumbers[monthAbbr];

  // Construct the date in YYYY-MM-DD format
  final formattedDate = '20$year-$month-$day';

  // Parse the formatted date string into a DateTime object
  return DateTime.parse(formattedDate);
}