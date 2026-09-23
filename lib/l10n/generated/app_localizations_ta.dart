// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get navHome => 'முகப்பு';

  @override
  String get navExplore => 'ஆராய்க';

  @override
  String get navPlans => 'திட்டங்கள்';

  @override
  String get navDiscover => 'கண்டறிக';

  @override
  String get navSafety => 'பாதுகாப்பு';

  @override
  String homeGreeting(String name) {
    return 'வணக்கம், $name';
  }

  @override
  String get homeTagline => 'விஜயபுராவின் வரலாற்று பாரம்பரியத்தை கண்டறியுங்கள்';

  @override
  String get homeExploreDetails => 'விவரங்களை ஆராய்க';

  @override
  String get homeExploreVijayapura => 'விஜயபுராவை ஆராய்க';

  @override
  String get homeExploreSubtitle =>
      'தக்காண கட்டிடக்கலை, புனித ஆலயங்கள் மற்றும் வரலாற்று நினைவுச் சின்னங்கள்.';

  @override
  String get homePlanYourVisit => 'உங்கள் பயணத்தைத் திட்டமிடுங்கள்';

  @override
  String get homePlanSubtitle =>
      'வரலாற்றுப் பயணிகளுக்காக வடிவமைக்கப்பட்ட பயணத்திட்டங்கள்';

  @override
  String get homeDiscoverLocal => 'உள்ளூர் சிறப்புகள்';

  @override
  String get homeDiscoverSubtitle =>
      'பாரம்பரிய தங்குமிடங்கள், வட கர்நாடக உணவு மற்றும் வழிகாட்டிகள்';

  @override
  String get homeViewAllPlans => 'அனைத்து திட்டங்களையும் காண்க';

  @override
  String get homeDiscoverMore => 'மேலும் அறியுங்கள்';

  @override
  String get homeChooseLanguage => 'உங்கள் மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get homeChooseLanguageSubtitle =>
      'உங்களுக்கு விருப்பமான மொழியில் விஜயபுராவை ஆராயுங்கள்.';

  @override
  String get homeChangeLanguage => 'மொழியை மாற்றுக';

  @override
  String get homeDefaultUser => 'பயணி';

  @override
  String get selectPreferredLanguage => 'விருப்பமான மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get selectLanguageSubtitle =>
      'உண்மையான உள்ளூர் அனுபவத்திற்கு உங்கள் மொழியைத் தேர்ந்தெடுக்கவும்';

  @override
  String get signIn => 'உள்நுழைக';

  @override
  String get signUp => 'பதிவு செய்க';

  @override
  String get createAccount => 'கணக்கை உருவாக்குக';

  @override
  String get welcomeBack => 'மீண்டும் நல்வரவு';

  @override
  String get welcomeBackSubtitle =>
      'உங்கள் பயணத் திட்டங்களை அணுக உள்நுழையவும்.';

  @override
  String get createAccountSubtitle =>
      'நினைவுச் சின்னங்களையும் வழிகளையும் ஆராய இணையுங்கள்.';

  @override
  String get email => 'மின்னஞ்சல்';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get password => 'கடவுச்சொல்';

  @override
  String get passwordHint => 'கடவுச்சொல்லை உள்ளிடவும்';

  @override
  String get confirmPassword => 'கடவுச்சொல்லை உறுதிப்படுத்தவும்';

  @override
  String get confirmPasswordHint => 'கடவுச்சொல்லை மீண்டும் உள்ளிடவும்';

  @override
  String get fullName => 'முழு பெயர்';

  @override
  String get fullNameHint => 'தர்ஷன் குமார்';

  @override
  String get forgotPassword => 'கடவுச்சொல் மறந்துவிட்டதா?';

  @override
  String get forgotPasswordTitle => 'கடவுச்சொல்லை மீட்டமைக்கவும்';

  @override
  String get forgotPasswordSubtitle =>
      'பதிவுசெய்த மின்னஞ்சலை உள்ளிடவும், இணைப்பு அனுப்புகிறோம்.';

  @override
  String get sendResetLink => 'இணைப்பை அனுப்புக';

  @override
  String get backToSignIn => 'உள்நுழைவுக்குத் திரும்புக';

  @override
  String get dontHaveAccount => 'கணக்கு இல்லையா?';

  @override
  String get alreadyHaveAccount => 'ஏற்கனவே கணக்கு உள்ளதா?';

  @override
  String get orContinueWith => 'அல்லது இதனுடன் தொடரவும்';

  @override
  String get continueWithGoogle => 'Google உடன் தொடரவும்';

  @override
  String get accountCreatedSuccess => 'கணக்கு வெற்றிகரமாக உருவாக்கப்பட்டது!';

  @override
  String get passwordResetSent =>
      'கடவுச்சொல் மீட்டமைப்பு இணைப்பு மின்னஞ்சலுக்கு அனுப்பப்பட்டது.';

  @override
  String get invalidEmail => 'சரியான மின்னஞ்சலை உள்ளிடவும்.';

  @override
  String get passwordTooShort =>
      'கடவுச்சொல் குறைந்தது 6 எழுத்துகள் இருக்க வேண்டும்.';

  @override
  String get passwordsDoNotMatch => 'கடவுச்சொற்கள் பொருந்தவில்லை.';

  @override
  String get nameRequired => 'உங்கள் பெயரை உள்ளிடவும்.';

  @override
  String get authError =>
      'உள்நுழைவு தோல்வியடைந்தது. விவரங்களைச் சரிபார்க்கவும்.';

  @override
  String get exploreTitle => 'விஜயபுரா ஆய்வு';

  @override
  String get exploreSubtitle =>
      'வரலாற்றுச் சின்னங்கள், மசூதிகள், கோயில்கள் மற்றும் கோட்டைகள்';

  @override
  String get searchPlaces => 'இடங்களைத் தேடுங்கள்...';

  @override
  String get allPlaces => 'அனைத்து இடங்கள்';

  @override
  String get mausoleums => 'மசூதிகள் & கல்லறைகள்';

  @override
  String get monuments => 'நினைவுச் சின்னங்கள்';

  @override
  String get historicForts => 'வரலாற்று கோட்டைகள்';

  @override
  String get religiousSites => 'புனித தலங்கள்';

  @override
  String get historyOverview => 'வரலாற்று பின்னணி';

  @override
  String get visitorInfo => 'பார்வையாளர் தகவல்';

  @override
  String get timings => 'பார்வை நேரம்';

  @override
  String get entryFee => 'நுழைவுக் கட்டணம்';

  @override
  String get suggestedDuration => 'பரிந்துரைக்கப்பட்ட நேரம்';

  @override
  String get location => 'இடம்';

  @override
  String get navigate => 'வழிகாட்டுதல்';

  @override
  String get nearbyAttractions => 'அருகிலுள்ள இடங்கள்';

  @override
  String get nearbyFood => 'அருகிலுள்ள உணவகங்கள்';

  @override
  String get nearbyStays => 'அருகிலுள்ள தங்குமிடங்கள்';

  @override
  String get noPlacesFound => 'இடங்கள் எதுவும் கிடைக்கவில்லை.';

  @override
  String get travelPlansTitle => 'பயணத் திட்டங்கள்';

  @override
  String get travelPlansSubtitle =>
      'விஜயபுராவின் அதிகாரப்பூர்வ பாரம்பரிய பயண வழிகாட்டி';

  @override
  String get oneDayPlan => '1 நாள்';

  @override
  String get twoDayPlan1 => '2 நாட்கள் (பகுதி 1)';

  @override
  String get twoDayPlan2 => '2 நாட்கள் (பகுதி 2)';

  @override
  String get threeDayPlan => '3 நாட்கள்';

  @override
  String get openRoute => 'வழியைப் பார்க்க';

  @override
  String get stops => 'நிறுத்தங்கள்';

  @override
  String get duration => 'கால அளவு';

  @override
  String get totalDistance => 'மொத்த தூரம்';

  @override
  String get day1 => 'நாள் 1';

  @override
  String get day2 => 'நாள் 2';

  @override
  String get day3 => 'நாள் 3';

  @override
  String get discoverTitle => 'விஜயபுரா கண்டறிக';

  @override
  String get discoverSubtitle =>
      'ஹோட்டல்கள், பாரம்பரிய உணவு, சந்தைகள் மற்றும் வழிகாட்டிகள்';

  @override
  String get hotelsAndStay => 'ஹோட்டல்கள் & தங்குமிடம்';

  @override
  String get localCuisine => 'உள்ளூர் உணவு';

  @override
  String get bazaarsAndCraft => 'சந்தைகள் & கைவினைப் பொருட்கள்';

  @override
  String get touristGuides => 'சுற்றுலா வழிகாட்டிகள்';

  @override
  String get searchHotels => 'ஹோட்டல் பெயர் அல்லது இடத்தை தேடுக...';

  @override
  String get searchDishes => 'உணவு வகைகளைத் தேடுக...';

  @override
  String get searchBazaars => 'சந்தைகள் அல்லது கைவினைகளைத் தேடுக...';

  @override
  String get searchGuides => 'வழிகாட்டி பெயர் அல்லது மொழியைத் தேடுக...';

  @override
  String get googleMaps => 'கூகிள் மேப்ஸ்';

  @override
  String get directions => 'திசைகள்';

  @override
  String get approximateLocation => 'தோராயமான இடம்';

  @override
  String get locationNavComingSoon => 'வழிகாட்டுதல் விரைவில் வரும்';

  @override
  String get call => 'அழைக்க';

  @override
  String get dialNow => 'இப்போதே அழைக்க';

  @override
  String get copy => 'நகலெடு';

  @override
  String get experience => 'அனுபவம்';

  @override
  String get languagesSpoken => 'பேசும் மொழிகள்';

  @override
  String get contactNumber => 'தொடர்பு எண்';

  @override
  String get traditionalBazaars =>
      'பாரம்பரிய சந்தைகள் மற்றும் வர்த்தக மையங்கள்';

  @override
  String get traditionalCrafts =>
      'பாரம்பரிய கைவினைப் பொருட்கள் மற்றும் சிறப்புப் பொருட்கள்';

  @override
  String get commonHubs => 'ஆராய்வதற்கான முக்கிய மையங்கள்';

  @override
  String get all => 'அனைத்தும்';

  @override
  String get markets => 'சந்தைகள்';

  @override
  String get crafts => 'கைவினை';

  @override
  String get safetyTitle => 'பாதுகாப்பு & அவசர சேவை';

  @override
  String get safetySubtitle =>
      'விஜயபுராவில் அவசர சேவைகள் மற்றும் சுற்றுலாப் பயணி உதவி';

  @override
  String get emergencyAssistance => 'அவசர உதவி';

  @override
  String get emergencySubtitle =>
      'சரிபார்க்கப்பட்ட அவசர சேவைகளுக்கான நேரடித் தொடர்பு';

  @override
  String get allEmergencies => 'அனைத்து அவசர சேவைகள்';

  @override
  String get ambulance => 'ஆம்புலன்ஸ்';

  @override
  String get police => 'காவல்துறை';

  @override
  String get fire => 'தீயணைப்புத் துறை';

  @override
  String get womenHelpline => 'பெண்கள் உதவி எண்';

  @override
  String get touristAssistance => 'சுற்றுலா உதவி எண்';

  @override
  String get emergencyGuidelines => 'பாதுகாப்பு வழிகாட்டுதல்கள்';

  @override
  String get profileTitle => 'சுயவிவரம்';

  @override
  String get profileSubtitle =>
      'உங்கள் கணக்கு மற்றும் விருப்பங்களை நிர்வகிக்கவும்';

  @override
  String get accountDetails => 'கணக்கு விவரங்கள்';

  @override
  String get languagePreference => 'மொழி விருப்பம்';

  @override
  String get signOut => 'வெளியேறுக';

  @override
  String get version => 'பதிப்பு';

  @override
  String get aboutApp => 'விஜயபுரா சுற்றுலா செயலி பற்றி';

  @override
  String get cancel => 'ரத்து செய்க';

  @override
  String get close => 'மூடுக';

  @override
  String get ok => 'சரி';

  @override
  String get copiedToClipboard => 'கிளிப்போர்டில் நகலெடுக்கப்பட்டது!';

  @override
  String get clearSearch => 'தேடலை அழிக்கவும்';

  @override
  String get noResultsFound => 'முடிவுகள் எதுவும் இல்லை.';
}
