class BookingStatus {
  final int id;
  final String name;
  final String UIName;

  BookingStatus({required this.id, required this.name, required this.UIName});


  static List<BookingStatus> bookingStatuses = [
    BookingStatus(id: 0, name: "actived", UIName: "Активные"),
    BookingStatus(id: 0, name: "waiting", UIName: "В ожидании"),
    BookingStatus(id: 0, name: "notApproved", UIName: "Неодобренные"),
    BookingStatus(id: 0, name: "completed ", UIName: "Завершенные")
  ];
}