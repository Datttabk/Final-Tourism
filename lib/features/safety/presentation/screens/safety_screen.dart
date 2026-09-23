import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/repositories/local_safety_repository.dart';
import '../../domain/models/safety_contact.dart';

class SafetyScreen extends StatefulWidget {
  const SafetyScreen({super.key});

  @override
  State<SafetyScreen> createState() => _SafetyScreenState();
}

class _SafetyScreenState extends State<SafetyScreen> {
  final LocalSafetyRepository _repository = LocalSafetyRepository();
  List<SafetyContact> _contacts = [];
  List<SafetyGuideline> _guidelines = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final contacts = await _repository.getContacts();
    final guidelines = await _repository.getGuidelines();
    if (!mounted) return;
    setState(() {
      _contacts = contacts;
      _guidelines = guidelines;
      _isLoading = false;
    });
  }

  void _triggerCall(SafetyContact contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.phone_forwarded, color: AppColors.primary),
            const SizedBox(width: 8),
            const Text('Emergency Call', style: AppTextStyles.title),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Call ${contact.title} at:',
              style: AppTextStyles.bodySecondary,
            ),
            const SizedBox(height: 8),
            Text(
              contact.phoneNumber,
              style: AppTextStyles.headline.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              contact.serviceDescription,
              style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Dialing ${contact.phoneNumber} (${contact.title})...',
                  ),
                  backgroundColor: AppColors.primaryDark,
                ),
              );
            },
            icon: const Icon(Icons.call, size: 16),
            label: const Text('Dial Now'),
          ),
        ],
      ),
    );
  }

  void _navigateToFacility(SafetyContact contact) {
    if (contact.coordinates == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Routing directions to ${contact.title} (${contact.coordinates})...',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryEmergency = _contacts
        .where((c) => c.category == EmergencyCategory.national)
        .firstOrNull;
    final otherContacts = _contacts
        .where((c) => c.category != EmergencyCategory.national)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Safety & Emergency', style: AppTextStyles.headline),
            Text(
              'Emergency services & traveler assistance in Vijayapura',
              style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            )
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                // Hero 112 National Emergency Card
                if (primaryEmergency != null) ...[
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFB3261E), Color(0xFF8C1D18)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFB3261E).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                '24/7 TOLL FREE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.shield,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'National Emergency Number',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '112',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          primaryEmergency.serviceDescription,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => _triggerCall(primaryEmergency),
                          icon: const Icon(
                            Icons.phone,
                            color: Color(0xFFB3261E),
                            size: 18,
                          ),
                          label: const Text(
                            'One-Tap Emergency Call 112',
                            style: TextStyle(
                              color: Color(0xFFB3261E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: const Size.fromHeight(46),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Emergency Numbers Section
                const Text('Emergency Hotlines', style: AppTextStyles.title),
                const SizedBox(height: 10),
                ...otherContacts.map(
                  (contact) => _ContactCard(
                    contact: contact,
                    onCall: () => _triggerCall(contact),
                    onNavigate: contact.coordinates != null
                        ? () => _navigateToFacility(contact)
                        : null,
                  ),
                ),

                const SizedBox(height: 24),

                // Traveler Safety Guidelines
                const Text('Traveler Safety Tips', style: AppTextStyles.title),
                const SizedBox(height: 10),
                ..._guidelines.map(
                  (guideline) => _GuidelineCard(guideline: guideline),
                ),
              ],
            ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final SafetyContact contact;
  final VoidCallback onCall;
  final VoidCallback? onNavigate;

  const _ContactCard({
    required this.contact,
    required this.onCall,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                contact.category.icon,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.title,
                    style: AppTextStyles.label.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    contact.serviceDescription,
                    style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        contact.phoneNumber,
                        style: AppTextStyles.title.copyWith(
                          fontSize: 15,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      if (contact.isAvailable24x7) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            '24/7',
                            style: TextStyle(
                              color: AppColors.success,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                IconButton.filledTonal(
                  onPressed: onCall,
                  icon: const Icon(Icons.call, size: 18),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                    foregroundColor: AppColors.primaryDark,
                  ),
                ),
                if (onNavigate != null) ...[
                  const SizedBox(height: 4),
                  IconButton.outlined(
                    onPressed: onNavigate,
                    icon: const Icon(Icons.directions, size: 18),
                    style: IconButton.styleFrom(
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GuidelineCard extends StatelessWidget {
  final SafetyGuideline guideline;

  const _GuidelineCard({required this.guideline});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(guideline.icon, size: 22, color: AppColors.accentGold),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  guideline.title,
                  style: AppTextStyles.label.copyWith(fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  guideline.description,
                  style: AppTextStyles.bodySecondary.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
