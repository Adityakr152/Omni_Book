import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/booking_provider.dart';
import '../../slot/slot_screen.dart';


class ServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<BookingProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      //  Modern AppBar
      appBar: AppBar(
        title: Text("Select Services"),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
      ),

      body: Column(
        children: [

          // 🔹 Service List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: p.services.length,
              itemBuilder: (_, i) {
                var s = p.services[i];
                bool isSelected = p.selected.contains(s);

                return GestureDetector(
                  onTap: () => p.toggle(s),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),

                    child: Row(
                      children: [

                        //  Icon
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.spa, color: Colors.blue),
                        ),

                        SizedBox(width: 12),

                        // 🔹 Service Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${s.duration} mins",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),

                        // 🔹 Price
                        Text(
                          "₹${s.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        SizedBox(width: 10),

                        //  Checkbox style
                        Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: isSelected ? Colors.blue : Colors.grey,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          //  Bottom Summary Panel
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                //  Time & Price Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total Time",
                            style: TextStyle(color: Colors.grey)),
                        Text("${p.totalDuration} mins",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Total Price",
                            style: TextStyle(color: Colors.grey)),
                        Text("₹${p.totalPrice}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 15),

                //  Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: p.totalDuration == 0
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SlotScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}