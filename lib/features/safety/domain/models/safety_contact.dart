import 'package:flutter/material.dart';

import '../../../../core/services/map_navigation_service.dart';

enum EmergencyCategory {
  national('National Emergency', Icons.emergency, true),
  police('Police Assistance', Icons.local_police, false),
  ambulance('Ambulance / Medical', Icons.medical_services, false),
  fire('Fire Service', Icons.local_fire_department, false),
  hospital('District Hospitals', Icons.local_hospital, false),
  touristHelp('Tourist Assistance', Icons.support_agent, false);

  final String title;
  final IconData icon;
  final bool isPrimary;
  const EmergencyCategory(this.title, this.icon, this.isPrimary);
}

class SafetyContact {
  final String id;
  final String title;
  final String serviceDescription;
  final String phoneNumber;
  final EmergencyCategory category;
  final String? address;
  final GeoCoordinates? coordinates;
  final bool isAvailable24x7;

  const SafetyContact({
    required this.id,
    required this.title,
    required this.serviceDescription,
    required this.phoneNumber,
    required this.category,
    this.address,
    this.coordinates,
    this.isAvailable24x7 = true,
  });
}

class SafetyGuideline {
  final String title;
  final String description;
  final IconData icon;

  const SafetyGuideline({
    required this.title,
    required this.description,
    required this.icon,
  });
}
