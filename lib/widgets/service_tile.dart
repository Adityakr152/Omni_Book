import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceTile extends StatelessWidget {
  final Service service;
  final bool selected;
  final VoidCallback onTap;

  ServiceTile({
    required this.service,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(service.name),
      subtitle: Text("${service.duration} min - ₹${service.price}"),
      value: selected,
      onChanged: (_) => onTap(),
    );
  }
}