import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../models/booking_model.dart';

import '../utils/slot_utils.dart';

class BookingProvider extends ChangeNotifier {
  List<Service> services = [
    Service(name: "Haircut", duration: 30, price: 100),
    Service(name: "Beard", duration: 20, price: 80),
    Service(name: "Facial", duration: 60, price: 200),
  ];

  List<Service> selected = [];

  List<Booking> bookings = [
    Booking(
      counterId: 1,
      start: DateTime(2026, 1, 1, 10, 0),
      end: DateTime(2026, 1, 1, 11, 0),
    ),
    Booking(
      counterId: 2,
      start: DateTime(2026, 1, 1, 10, 30),
      end: DateTime(2026, 1, 1, 11, 30),
    ),
    Booking(
      counterId: 3,
      start: DateTime(2026, 1, 1, 9, 0),
      end: DateTime(2026, 1, 1, 10, 30),
    ),
  ];

  DateTime? selectedSlot;
  int? assignedCounter;

  void toggle(Service s) {
    selected.contains(s) ? selected.remove(s) : selected.add(s);
    notifyListeners();
  }

  int get totalDuration => selected.fold(0, (sum, s) => sum + s.duration);

  double get totalPrice => selected.fold(0, (sum, s) => sum + s.price);

  bool isSlotAvailable(DateTime startTime) {
    DateTime endTime = startTime.add(Duration(minutes: totalDuration));

    if (endTime.hour >= 18) return false;

    for (int counter = 1; counter <= 3; counter++) {
      bool overlap = bookings.any(
        (b) =>
            b.counterId == counter &&
            isOverlap(startTime, endTime, b.start, b.end),
      );

      if (!overlap) return true;
    }

    return false;
  }

  int getAvailableCount(DateTime startTime) {
    DateTime endTime = startTime.add(Duration(minutes: totalDuration));
    int free = 0;

    for (int counter = 1; counter <= 3; counter++) {
      bool overlap = bookings.any(
        (b) =>
            b.counterId == counter &&
            isOverlap(startTime, endTime, b.start, b.end),
      );

      if (!overlap) free++;
    }

    return free;
  }

  void selectSlot(DateTime time) {
    selectedSlot = time;

    for (int counter = 1; counter <= 3; counter++) {
      bool overlap = bookings.any(
        (b) =>
            b.counterId == counter &&
            isOverlap(
              time,
              time.add(Duration(minutes: totalDuration)),
              b.start,
              b.end,
            ),
      );

      if (!overlap) {
        assignedCounter = counter;
        break;
      }
    }

    notifyListeners();
  }

  void addBooking() {
    bookings.add(
      Booking(
        counterId: assignedCounter!,
        start: selectedSlot!,
        end: selectedSlot!.add(Duration(minutes: totalDuration)),
      ),
    );

    notifyListeners();
  }
  bool isBooked(DateTime slot) {
    DateTime end = slot.add(Duration(minutes: totalDuration));

    return bookings.any(
          (b) => isOverlap(slot, end, b.start, b.end),
    );
  }
}
