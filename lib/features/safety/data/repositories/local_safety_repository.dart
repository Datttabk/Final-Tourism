import 'package:flutter/material.dart';

import '../../../../core/services/map_navigation_service.dart';
import '../../domain/models/safety_contact.dart';

class LocalSafetyRepository {
  static const List<SafetyContact> _emergencyContacts = [
    SafetyContact(
      id: 'emg_112',
      title: 'National Emergency Helpline',
      serviceDescription: 'Single emergency number across India for Police, Fire, and Ambulance.',
      phoneNumber: '112',
      category: EmergencyCategory.national,
      isAvailable24x7: true,
    ),
    SafetyContact(
      id: 'emg_police_100',
      title: 'Police Control Room (Vijayapura)',
      serviceDescription:
          'Immediate law enforcement dispatch and tourist safety assistance.',
      phoneNumber: '100',
      category: EmergencyCategory.police,
      isAvailable24x7: true,
    ),
    SafetyContact(
      id: 'emg_ambulance_108',
      title: 'Arogya Kavacha Medical Ambulance',
      serviceDescription:
          'Karnataka State rapid emergency medical and paramedical service.',
      phoneNumber: '108',
      category: EmergencyCategory.ambulance,
      isAvailable24x7: true,
    ),
    SafetyContact(
      id: 'emg_fire_101',
      title: 'Fire & Rescue Services',
      serviceDescription: 'Municipal fire protection and emergency rescue.',
      phoneNumber: '101',
      category: EmergencyCategory.fire,
      isAvailable24x7: true,
    ),
    SafetyContact(
      id: 'emg_women_1091',
      title: 'Women Helpline',
      serviceDescription: '24/7 toll-free crisis response and dedicated women traveler support.',
      phoneNumber: '1091',
      category: EmergencyCategory.police,
      isAvailable24x7: true,
    ),
    SafetyContact(
      id: 'fac_dist_hospital',
      title: 'District Government Civil Hospital',
      serviceDescription: 'Primary public healthcare institution with 24/7 casualty & emergency trauma ward.',
      phoneNumber: '08352-250000',
      category: EmergencyCategory.hospital,
      address: 'Solapur Road / Station Road, Vijayapura',
      coordinates: GeoCoordinates(latitude: 16.8320, longitude: 75.7280),
      isAvailable24x7: true,
    ),
    SafetyContact(
      id: 'fac_tourist_police',
      title: 'Tourist Police Help Desk (Gol Gumbaz)',
      serviceDescription: 'Dedicated tourism safety station assisting international & domestic visitors.',
      phoneNumber: '08352-251100',
      category: EmergencyCategory.touristHelp,
      address: 'Gol Gumbaz Monument Complex Entrance',
      coordinates: GeoCoordinates(latitude: 16.8304, longitude: 75.7355),
      isAvailable24x7: false,
    ),
  ];

  static const List<SafetyGuideline> _guidelines = [
    SafetyGuideline(
      title: 'Deccan Climate & Hydration',
      description: 'Temperatures in North Karnataka can rise significantly between 11 AM and 3 PM. Carry adequate drinking water, a hat, and sun protection when visiting open-air stone courtyards.',
      icon: Icons.wb_sunny_outlined,
    ),
    SafetyGuideline(
      title: 'ASI Monument Preservation',
      description: 'Gol Gumbaz and Ibrahim Rauza are protected national monuments under the Archaeological Survey of India. Writing on walls, drone flying without permit, and littering are strictly prohibited and penalised.',
      icon: Icons.account_balance_outlined,
    ),
    SafetyGuideline(
      title: 'Authorized Transport & Meters',
      description: 'Auto-rickshaws are abundant outside the railway station and bus terminals. Request meter fare or agree upon prevailing standard rates before starting your journey.',
      icon: Icons.local_taxi_outlined,
    ),
  ];

  Future<List<SafetyContact>> getContacts() async => _emergencyContacts;
  Future<List<SafetyGuideline>> getGuidelines() async => _guidelines;
}
