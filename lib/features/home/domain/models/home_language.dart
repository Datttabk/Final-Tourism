/// Available languages for Vijayapura Tourism.
///
/// Corresponds to Karnataka and its neighboring states:
/// - Karnataka -> Kannada
/// - Maharashtra -> Marathi
/// - Goa -> Konkani
/// - Telangana & Andhra Pradesh -> Telugu
/// - Tamil Nadu -> Tamil
/// - Kerala -> Malayalam
enum AppLanguage {
  english(
    code: 'en',
    displayName: 'English',
    nativeName: 'English',
    greetingPrefix: 'Namaskara',
    tagline: 'Discover the heritage of Vijayapura',
  ),
  kannada(
    code: 'kn',
    displayName: 'Kannada',
    nativeName: 'ಕನ್ನಡ',
    greetingPrefix: 'ನಮಸ್ಕಾರ',
    tagline: 'ವಿಜಯಪುರದ ಐತಿಹಾಸಿಕ ಪರಂಪರೆ',
  ),
  marathi(
    code: 'mr',
    displayName: 'Marathi',
    nativeName: 'मराठी',
    greetingPrefix: 'नमस्कार',
    tagline: 'विजापूरचा ऐतिहासिक वारसा',
  ),
  konkani(
    code: 'kok',
    displayName: 'Konkani',
    nativeName: 'कोंकणी',
    greetingPrefix: 'नमस्कार',
    tagline: 'विजापूरचो ऐतिहासिक दायज',
  ),
  telugu(
    code: 'te',
    displayName: 'Telugu',
    nativeName: 'తెలుగు',
    greetingPrefix: 'నమస్కారం',
    tagline: 'విజయపుర చారిత్రక వారసత్వం',
  ),
  tamil(
    code: 'ta',
    displayName: 'Tamil',
    nativeName: 'தமிழ்',
    greetingPrefix: 'வணக்கம்',
    tagline: 'விஜயபுராவின் வரலாற்று பாரம்பரியம்',
  ),
  malayalam(
    code: 'ml',
    displayName: 'Malayalam',
    nativeName: 'മലയാളം',
    greetingPrefix: 'നമസ്കാരം',
    tagline: 'വിജയപുരയുടെ പൈതൃകം',
  );

  final String code;
  final String displayName;
  final String nativeName;
  final String greetingPrefix;
  final String tagline;

  const AppLanguage({
    required this.code,
    required this.displayName,
    required this.nativeName,
    required this.greetingPrefix,
    required this.tagline,
  });
}
