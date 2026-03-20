import 'package:flutter/material.dart';
import 'package:omni_book/providers/booking_provider.dart';
import 'package:omni_book/widgets/slot_tile.dart';
import 'package:provider/provider.dart';
import '../summary/summary_screen.dart';

class SlotScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<BookingProvider>(context);

    List<DateTime> slots = [];
    DateTime start = DateTime(2026, 1, 1, 9, 0);

    for (int i = 0; i < 18; i++) {
      slots.add(start.add(Duration(minutes: 30 * i)));
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      //  AppBar
      appBar: AppBar(title: Text("Select Slot"), centerTitle: true),

      body: GridView.builder(
        padding: EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: slots.length,
        itemBuilder: (_, i) {
          DateTime t = slots[i];

          //  Availability logic (MAIN PART)
          bool available = p.isSlotAvailable(t);

          return SlotTile(
            time: t,
            available: p.isSlotAvailable(t),
            spots: p.getAvailableCount(t),
            isBooked: p.isBooked(t),
            //
            onTap: () {
              if (!p.isSlotAvailable(t)) return;

              p.selectSlot(t);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SummaryScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
