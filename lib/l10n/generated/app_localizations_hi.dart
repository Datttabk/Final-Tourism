// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get navHome => 'मुखपृष्ठ';

  @override
  String get navExplore => 'अन्वेषण';

  @override
  String get navPlans => 'यात्रा योजनाएँ';

  @override
  String get navDiscover => 'खोजें';

  @override
  String get navSafety => 'सुरक्षा';

  @override
  String homeGreeting(String name) {
    return 'नमस्कार, $name';
  }

  @override
  String get homeTagline => 'विजयपुर की ऐतिहासिक धरोहर की खोज करें';

  @override
  String get homeExploreDetails => 'विवरण देखें';

  @override
  String get homeExploreVijayapura => 'विजयपुर का अन्वेषण करें';

  @override
  String get homeExploreSubtitle =>
      'दक्कन वास्तुकला, पवित्र मंदिर और ऐतिहासिक स्मारक।';

  @override
  String get homePlanYourVisit => 'अपनी यात्रा की योजना बनाएं';

  @override
  String get homePlanSubtitle =>
      'विरासत प्रेमियों के लिए तैयार की गई यात्रा योजनाएं';

  @override
  String get homeDiscoverLocal => 'स्थानीय आकर्षण';

  @override
  String get homeDiscoverSubtitle =>
      'पारंपरिक प्रवास, उत्तर कर्नाटक व्यंजन और आधिकारिक गाइड';

  @override
  String get homeViewAllPlans => 'सभी योजनाएं देखें';

  @override
  String get homeDiscoverMore => 'और अधिक खोजें';

  @override
  String get homeChooseLanguage => 'अपनी भाषा चुनें';

  @override
  String get homeChooseLanguageSubtitle =>
      'अपनी पसंदीदा भाषा में विजयपुर का अन्वेषण करें।';

  @override
  String get homeChangeLanguage => 'भाषा बदलें';

  @override
  String get homeDefaultUser => 'यात्री';

  @override
  String get selectPreferredLanguage => 'पसंदीदा भाषा चुनें';

  @override
  String get selectLanguageSubtitle =>
      'प्रामाणिक स्थानीय अनुभव के लिए अपनी भाषा का चयन करें';

  @override
  String get signIn => 'साइन इन';

  @override
  String get signUp => 'साइन अप';

  @override
  String get createAccount => 'खाता बनाएं';

  @override
  String get welcomeBack => 'वापसी पर स्वागत है';

  @override
  String get welcomeBackSubtitle =>
      'अपनी यात्रा योजनाओं और सहेजे गए स्थानों तक पहुंचने के लिए साइन इन करें।';

  @override
  String get createAccountSubtitle =>
      'स्मारकों और यात्रा मार्गों का अन्वेषण करने के लिए जुड़ें।';

  @override
  String get email => 'ईमेल';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get password => 'पासवर्ड';

  @override
  String get passwordHint => 'अपना पासवर्ड दर्ज करें';

  @override
  String get confirmPassword => 'पासवर्ड की पुष्टि करें';

  @override
  String get confirmPasswordHint => 'अपना पासवर्ड पुनः दर्ज करें';

  @override
  String get fullName => 'पूरा नाम';

  @override
  String get fullNameHint => 'दर्शन कुमार';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get forgotPasswordTitle => 'पासवर्ड रीसेट करें';

  @override
  String get forgotPasswordSubtitle =>
      'अपना पंजीकृत ईमेल दर्ज करें, हम आपको रीसेट लिंक भेजेंगे।';

  @override
  String get sendResetLink => 'रीसेट लिंक भेजें';

  @override
  String get backToSignIn => 'साइन इन पर वापस जाएं';

  @override
  String get dontHaveAccount => 'खाता नहीं है?';

  @override
  String get alreadyHaveAccount => 'पहले से खाता है?';

  @override
  String get orContinueWith => 'या इसके साथ जारी रखें';

  @override
  String get continueWithGoogle => 'Google के साथ जारी रखें';

  @override
  String get accountCreatedSuccess => 'खाता सफलतापूर्वक बनाया गया!';

  @override
  String get passwordResetSent =>
      'पासवर्ड रीसेट लिंक आपके ईमेल पर भेजा गया है।';

  @override
  String get invalidEmail => 'कृपया एक मान्य ईमेल पता दर्ज करें।';

  @override
  String get passwordTooShort => 'पासवर्ड कम से कम 6 अक्षरों का होना चाहिए।';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड मेल नहीं खाते।';

  @override
  String get nameRequired => 'कृपया अपना नाम दर्ज करें।';

  @override
  String get authError => 'प्रमाणीकरण विफल रहा। कृपया अपने विवरण की जाँच करें।';

  @override
  String get exploreTitle => 'विजयपुर अन्वेषण';

  @override
  String get exploreSubtitle =>
      'ऐतिहासिक स्मारक, मस्जिदें, मंदिर और किले के अवशेष';

  @override
  String get searchPlaces => 'स्थानों को खोजें...';

  @override
  String get allPlaces => 'सभी स्थान';

  @override
  String get mausoleums => 'मकबरे';

  @override
  String get monuments => 'स्मारक';

  @override
  String get historicForts => 'ऐतिहासिक किले';

  @override
  String get religiousSites => 'धार्मिक स्थल';

  @override
  String get historyOverview => 'ऐतिहासिक विवरण';

  @override
  String get visitorInfo => 'आगंतुक जानकारी';

  @override
  String get timings => 'दर्शन का समय';

  @override
  String get entryFee => 'प्रवेश शुल्क';

  @override
  String get suggestedDuration => 'सुझाया गया समय';

  @override
  String get location => 'स्थान';

  @override
  String get navigate => 'मार्गदर्शन';

  @override
  String get nearbyAttractions => 'निकटवर्ती आकर्षण';

  @override
  String get nearbyFood => 'निकटवर्ती भोजन';

  @override
  String get nearbyStays => 'निकटवर्ती प्रवास';

  @override
  String get noPlacesFound => 'कोई स्थान नहीं मिला।';

  @override
  String get travelPlansTitle => 'तैयार यात्रा योजनाएं';

  @override
  String get travelPlansSubtitle =>
      'विजयपुर की आधिकारिक ऐतिहासिक यात्रा मार्गदर्शिका';

  @override
  String get oneDayPlan => '1 दिन';

  @override
  String get twoDayPlan1 => '2 दिन (योजना 1)';

  @override
  String get twoDayPlan2 => '2 दिन (योजना 2)';

  @override
  String get threeDayPlan => '3 दिन';

  @override
  String get openRoute => 'मार्ग देखें';

  @override
  String get stops => 'पड़ाव';

  @override
  String get duration => 'अवधि';

  @override
  String get totalDistance => 'कुल दूरी';

  @override
  String get day1 => 'दिन 1';

  @override
  String get day2 => 'दिन 2';

  @override
  String get day3 => 'दिन 3';

  @override
  String get discoverTitle => 'विजयपुर खोजें';

  @override
  String get discoverSubtitle => 'होटल, स्थानीय व्यंजन, बाज़ार और गाइड';

  @override
  String get hotelsAndStay => 'होटल और प्रवास';

  @override
  String get localCuisine => 'स्थानीय व्यंजन';

  @override
  String get bazaarsAndCraft => 'बाज़ार और हस्तशिल्प';

  @override
  String get touristGuides => 'पर्यटक गाइड';

  @override
  String get searchHotels => 'होटल का नाम या स्थान खोजें...';

  @override
  String get searchDishes => 'व्यंजन या खाद्य सामग्री खोजें...';

  @override
  String get searchBazaars => 'बाज़ार या शिल्प खोजें...';

  @override
  String get searchGuides => 'गाइड का नाम या भाषा खोजें...';

  @override
  String get googleMaps => 'गूगल मैप्स';

  @override
  String get directions => 'दिशा-निर्देश';

  @override
  String get approximateLocation => 'अनुमानित स्थान';

  @override
  String get locationNavComingSoon => 'स्थान नेविगेशन जल्द उपलब्ध होगा';

  @override
  String get call => 'कॉल करें';

  @override
  String get dialNow => 'अभी कॉल करें';

  @override
  String get copy => 'कॉपी करें';

  @override
  String get experience => 'अनुभव';

  @override
  String get languagesSpoken => 'बोली जाने वाली भाषाएँ';

  @override
  String get contactNumber => 'संपर्क नंबर';

  @override
  String get traditionalBazaars => 'पारंपरिक बाज़ार और वाणिज्यिक केंद्र';

  @override
  String get traditionalCrafts => 'पारंपरिक शिल्प और क्षेत्रीय विशेषताएं';

  @override
  String get commonHubs => 'अन्वेषण के लिए प्रमुख क्षेत्र';

  @override
  String get all => 'सभी';

  @override
  String get markets => 'बाज़ार';

  @override
  String get crafts => 'शिल्प';

  @override
  String get safetyTitle => 'सुरक्षा और आपातकालीन सेवा';

  @override
  String get safetySubtitle => 'विजयपुर में आपातकालीन सेवाएं और यात्री सहायता';

  @override
  String get emergencyAssistance => 'आपातकालीन सहायता';

  @override
  String get emergencySubtitle => 'सत्यापित आपातकालीन सेवाओं तक त्वरित पहुंच';

  @override
  String get allEmergencies => 'सभी आपातकालीन सेवाएं';

  @override
  String get ambulance => 'एम्बुलेंस';

  @override
  String get police => 'पुलिस';

  @override
  String get fire => 'दमकल';

  @override
  String get womenHelpline => 'महिला हेल्पलाइन';

  @override
  String get touristAssistance => 'पर्यटक हेल्पलाइन';

  @override
  String get emergencyGuidelines => 'आपातकालीन सुरक्षा दिशानिर्देश';

  @override
  String get profileTitle => 'प्रोफ़ाइल';

  @override
  String get profileSubtitle => 'अपना खाता और प्राथमिकताएं प्रबंधित करें';

  @override
  String get accountDetails => 'खाता विवरण';

  @override
  String get languagePreference => 'भाषा प्राथमिकता';

  @override
  String get signOut => 'साइन आउट';

  @override
  String get version => 'संस्करण';

  @override
  String get aboutApp => 'विजयपुर पर्यटन ऐप के बारे में';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get close => 'बंद करें';

  @override
  String get ok => 'ठीक है';

  @override
  String get copiedToClipboard => 'क्लिपबोर्ड पर कॉपी किया गया!';

  @override
  String get clearSearch => 'खोज साफ़ करें';

  @override
  String get noResultsFound => 'कोई परिणाम नहीं मिला।';
}
