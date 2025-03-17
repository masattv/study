class Memo {
  String title;
  String detail;
  DateTime cteatedDate;
  DateTime? updatedDate;

  Memo(
      {required this.title,
      required this.detail,
      required this.cteatedDate,
      this.updatedDate});
}
