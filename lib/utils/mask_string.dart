extension MaskStringExtension on String {
  String maskString(
      {int start = 3, int end = 8, String maskChar = '*'}) {
    if (start < 0 || end >= length || start >= end) {
      throw RangeError('Invalid start and end indices');
    }
    String maskedPart = substring(start, end)
        .replaceAll(RegExp(r'.'), maskChar);
    return replaceRange(start, end, maskedPart);
  }
}