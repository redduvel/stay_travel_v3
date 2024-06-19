import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/colors.dart';

class BookingStatus {
  final int id;
  final String name;
  final String UIName;
  final Color color;

  BookingStatus(this.color, {required this.id, required this.name, required this.UIName});


  static List<BookingStatus> bookingStatuses = [
    BookingStatus(id: 0, name: "active", UIName: "Активные", AppColors.activeBooking),
    BookingStatus(id: 0, name: "waiting", UIName: "В ожидании", AppColors.waitingBooking),
    BookingStatus(id: 0, name: "notApproved", UIName: "Неодобренные", AppColors.notApprovedBooking),
    BookingStatus(id: 0, name: "completed ", UIName: "Завершенные", AppColors.completedBooking)
  ];
}