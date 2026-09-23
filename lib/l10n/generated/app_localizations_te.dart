// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get navHome => 'హోమ్';

  @override
  String get navExplore => 'అన్వేషించండి';

  @override
  String get navPlans => 'ప్రణాళికలు';

  @override
  String get navDiscover => 'డిస్కవర్';

  @override
  String get navSafety => 'భద్రత';

  @override
  String homeGreeting(String name) {
    return 'నమస్కారం, $name';
  }

  @override
  String get homeTagline => 'విజయపుర చారిత్రక వారసత్వాన్ని అన్వేషించండి';

  @override
  String get homeExploreDetails => 'వివరాలను అన్వేషించండి';

  @override
  String get homeExploreVijayapura => 'విజయపురను అన్వేషించండి';

  @override
  String get homeExploreSubtitle =>
      'దక్కన్ వాస్తుశిల్పం, పవిత్ర దేవాలయాలు మరియు చారిత్రక కట్టడాలు.';

  @override
  String get homePlanYourVisit => 'మీ పర్యటనను ప్లాన్ చేసుకోండి';

  @override
  String get homePlanSubtitle =>
      'వారసత్వ ప్రేమికుల కోసం రూపొందించిన ప్రయాణ ప్రణాళికలు';

  @override
  String get homeDiscoverLocal => 'స్థానిక ప్రత్యేకతలు';

  @override
  String get homeDiscoverSubtitle =>
      'చారిత్రక బసలు, ఉత్తర కర్ణాటక వంటకాలు మరియు అధికారిక గైడ్లు';

  @override
  String get homeViewAllPlans => 'అన్ని ప్రణాళికలు చూడండి';

  @override
  String get homeDiscoverMore => 'మరిన్ని తెలుసుకోండి';

  @override
  String get homeChooseLanguage => 'మీ భాషను ఎంచుకోండి';

  @override
  String get homeChooseLanguageSubtitle =>
      'మీకు నచ్చిన భాషలో విజయపురను అన్వేషించండి.';

  @override
  String get homeChangeLanguage => 'భాషను మార్చండి';

  @override
  String get homeDefaultUser => 'యాత్రికులు';

  @override
  String get selectPreferredLanguage => 'ఇష్టపడే భాషను ఎంచుకోండి';

  @override
  String get selectLanguageSubtitle => 'స్థానిక అనుభవం కోసం మీ భాషను ఎంచుకోండి';

  @override
  String get signIn => 'సైన్ ఇన్';

  @override
  String get signUp => 'సైన్ అప్';

  @override
  String get createAccount => 'ఖాతాను సృష్టించండి';

  @override
  String get welcomeBack => 'పునఃస్వాగతం';

  @override
  String get welcomeBackSubtitle =>
      'మీ ప్రయాణ ప్రణాళికలను చూడటానికి సైన్ ఇన్ చేయండి.';

  @override
  String get createAccountSubtitle =>
      'చారిత్రక కట్టడాలను అన్వేషించడానికి చేరండి.';

  @override
  String get email => 'ఇమెయిల్';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get password => 'పాస్‌వర్డ్';

  @override
  String get passwordHint => 'పాస్‌వర్డ్ నమోదు చేయండి';

  @override
  String get confirmPassword => 'పాస్‌వర్డ్ నిర్ధారించండి';

  @override
  String get confirmPasswordHint => 'పాస్‌వర్డ్ మళ్లీ నమోదు చేయండి';

  @override
  String get fullName => 'పూర్తి పేరు';

  @override
  String get fullNameHint => 'దర్శన్ కుమార్';

  @override
  String get forgotPassword => 'పాస్‌వర్డ్ మర్చిపోయారా?';

  @override
  String get forgotPasswordTitle => 'పాస్‌వర్డ్ రీసెట్ చేయండి';

  @override
  String get forgotPasswordSubtitle =>
      'మీ నమోదిత ఇమెయిల్ నమోదు చేయండి, రీసెట్ లింక్ పంపుతాము.';

  @override
  String get sendResetLink => 'రీసెట్ లింక్ పంపండి';

  @override
  String get backToSignIn => 'సైన్ ఇన్ కు తిరిగి వెళ్లండి';

  @override
  String get dontHaveAccount => 'ఖాతా లేదా?';

  @override
  String get alreadyHaveAccount => 'ఇప్పటికే ఖాతా ఉందా?';

  @override
  String get orContinueWith => 'లేదా దీనితో కొనసాగించండి';

  @override
  String get continueWithGoogle => 'Google తో కొనసాగించండి';

  @override
  String get accountCreatedSuccess => 'ఖాతా విజయవంతంగా సృష్టించబడింది!';

  @override
  String get passwordResetSent =>
      'పాస్‌వర్డ్ రీసెట్ లింక్ మీ ఇమెయిల్‌కు పంపబడింది.';

  @override
  String get invalidEmail => 'చెల్లుబాటు అయ్యే ఇమెయిల్ నమోదు చేయండి.';

  @override
  String get passwordTooShort => 'పాస్‌వర్డ్ కనీసం 6 అక్షరాలు ఉండాలి.';

  @override
  String get passwordsDoNotMatch => 'పాస్‌వర్డ్‌లు సరిపోలడం లేదు.';

  @override
  String get nameRequired => 'దయచేసి మీ పేరును నమోదు చేయండి.';

  @override
  String get authError => 'ధృవీకరణ విఫలమైంది. దయచేసి వివరాలను తనిఖీ చేయండి.';

  @override
  String get exploreTitle => 'విజయపుర అన్వేషణ';

  @override
  String get exploreSubtitle =>
      'చారిత్రక కట్టడాలు, మసీదులు, దేవాలయాలు మరియు కోటలు';

  @override
  String get searchPlaces => 'స్థలాలను శోధించండి...';

  @override
  String get allPlaces => 'అన్ని స్థలాలు';

  @override
  String get mausoleums => 'సమాధులు';

  @override
  String get monuments => 'స్మారకాలు';

  @override
  String get historicForts => 'చారిత్రక కోటలు';

  @override
  String get religiousSites => 'ధార్మిక ప్రదేశాలు';

  @override
  String get historyOverview => 'చారిత్రక నేపథ్యం';

  @override
  String get visitorInfo => 'సందర్శకుల సమాచారం';

  @override
  String get timings => 'సందర్శన సమయాలు';

  @override
  String get entryFee => 'ప్రవేశ రుసుము';

  @override
  String get suggestedDuration => 'సిఫార్సు చేయబడిన సమయం';

  @override
  String get location => 'స్థానం';

  @override
  String get navigate => 'మార్గదర్శనం';

  @override
  String get nearbyAttractions => 'సమీప ఆకర్షణలు';

  @override
  String get nearbyFood => 'సమీప ఆహారం';

  @override
  String get nearbyStays => 'సమీప బసలు';

  @override
  String get noPlacesFound => 'ఎటువంటి స్థలాలు కనుగొనబడలేదు.';

  @override
  String get travelPlansTitle => 'ప్రయాణ ప్రణాళికలు';

  @override
  String get travelPlansSubtitle => 'విజయపుర అధికారిక వారసత్వ ప్రయాణ మార్గాలు';

  @override
  String get oneDayPlan => '1 రోజు';

  @override
  String get twoDayPlan1 => '2 రోజులు (ప్లాన్ 1)';

  @override
  String get twoDayPlan2 => '2 రోజులు (ప్లాన్ 2)';

  @override
  String get threeDayPlan => '3 రోజులు';

  @override
  String get openRoute => 'మార్గాన్ని చూడండి';

  @override
  String get stops => 'స్టాప్‌లు';

  @override
  String get duration => 'వ్యవధి';

  @override
  String get totalDistance => 'మొత్తం దూరం';

  @override
  String get day1 => 'రోజు 1';

  @override
  String get day2 => 'రోజు 2';

  @override
  String get day3 => 'రోజు 3';

  @override
  String get discoverTitle => 'విజయపుర డిస్కవర్';

  @override
  String get discoverSubtitle =>
      'హోటళ్ళు, స్థానిక వంటకాలు, బజార్లు మరియు గైడ్లు';

  @override
  String get hotelsAndStay => 'హోటళ్ళు & బస';

  @override
  String get localCuisine => 'స్థానిక వంటకాలు';

  @override
  String get bazaarsAndCraft => 'బజార్లు & హస్తకళలు';

  @override
  String get touristGuides => 'టూరిస్ట్ గైడ్లు';

  @override
  String get searchHotels => 'హోటల్ పేరు లేదా స్థానాన్ని శోధించండి...';

  @override
  String get searchDishes => 'వంటకాలు శోధించండి...';

  @override
  String get searchBazaars => 'బజార్లు లేదా కళలను శోధించండి...';

  @override
  String get searchGuides => 'గైడ్ పేరు లేదా భాషను శోధించండి...';

  @override
  String get googleMaps => 'గూగుల్ మ్యాప్స్';

  @override
  String get directions => 'దిశలు';

  @override
  String get approximateLocation => 'సుమారు స్థానం';

  @override
  String get locationNavComingSoon => 'స్థాన నావిగేషన్ త్వరలో రానుంది';

  @override
  String get call => 'కాల్ చేయండి';

  @override
  String get dialNow => 'ఇప్పుడే కాల్ చేయండి';

  @override
  String get copy => 'కాపీ చేయండి';

  @override
  String get experience => 'అనుభవం';

  @override
  String get languagesSpoken => 'మాట్లాడే భాషలు';

  @override
  String get contactNumber => 'సంప్రదింపు నంబర్';

  @override
  String get traditionalBazaars => 'సాంప్రదాయ బజార్లు మరియు మార్కెట్లు';

  @override
  String get traditionalCrafts => 'సాంప్రదాయ హస్తకళలు మరియు ప్రాంతీయ వస్తువులు';

  @override
  String get commonHubs => 'అన్వేషించడానికి ముఖ్య కేంద్రాలు';

  @override
  String get all => 'అన్ని';

  @override
  String get markets => 'మార్కెట్లు';

  @override
  String get crafts => 'హస్తకళలు';

  @override
  String get safetyTitle => 'భద్రత & అత్యవసర సేవలు';

  @override
  String get safetySubtitle => 'విజయపురలో అత్యవసర సేవలు మరియు ప్రయాణీకుల సహాయం';

  @override
  String get emergencyAssistance => 'అత్యవసర సహాయం';

  @override
  String get emergencySubtitle => 'ధృవీకరించబడిన అత్యవసర సేవల తక్షణ సంప్రదింపు';

  @override
  String get allEmergencies => 'అన్ని అత్యవసరాలు';

  @override
  String get ambulance => 'అంబులెన్స్';

  @override
  String get police => 'పోలీస్';

  @override
  String get fire => 'అగ్నిమాపక';

  @override
  String get womenHelpline => 'మహిళా హెల్ప్‌లైన్';

  @override
  String get touristAssistance => 'టూరిస్ట్ హెల్ప్‌లైన్';

  @override
  String get emergencyGuidelines => 'భద్రతా మార్గదర్శకాలు';

  @override
  String get profileTitle => 'ప్రొఫైల్';

  @override
  String get profileSubtitle => 'మీ ఖాతా మరియు ప్రాధాన్యతలను నిర్వహించండి';

  @override
  String get accountDetails => 'ఖాతా వివరాలు';

  @override
  String get languagePreference => 'భాషా ప్రాధాన్యత';

  @override
  String get signOut => 'సైన్ అవుట్';

  @override
  String get version => 'వెర్షన్';

  @override
  String get aboutApp => 'విజయపుర పర్యాటక యాప్ గురించి';

  @override
  String get cancel => 'రద్దు చేయండి';

  @override
  String get close => 'మూసివేయండి';

  @override
  String get ok => 'సరే';

  @override
  String get copiedToClipboard => 'క్లిప్‌బోర్డ్‌కు కాపీ చేయబడింది!';

  @override
  String get clearSearch => 'శోధనను క్లియర్ చేయండి';

  @override
  String get noResultsFound => 'ఎటువంటి ఫలితాలు కనుగొనబడలేదు.';
}
