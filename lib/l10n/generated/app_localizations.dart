import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_kok.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
    Locale('kok'),
    Locale('ml'),
    Locale('mr'),
    Locale('ta'),
    Locale('te'),
  ];

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get navExplore;

  /// No description provided for @navPlans.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get navPlans;

  /// No description provided for @navDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get navDiscover;

  /// No description provided for @navSafety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get navSafety;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Namaskara, {name}'**
  String homeGreeting(String name);

  /// No description provided for @homeTagline.
  ///
  /// In en, this message translates to:
  /// **'Discover the heritage of Vijayapura'**
  String get homeTagline;

  /// No description provided for @homeExploreDetails.
  ///
  /// In en, this message translates to:
  /// **'Explore Details'**
  String get homeExploreDetails;

  /// No description provided for @homeExploreVijayapura.
  ///
  /// In en, this message translates to:
  /// **'Explore Vijayapura'**
  String get homeExploreVijayapura;

  /// No description provided for @homeExploreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Centuries of Deccan architecture, sacred temples & historic monuments.'**
  String get homeExploreSubtitle;

  /// No description provided for @homePlanYourVisit.
  ///
  /// In en, this message translates to:
  /// **'Plan Your Visit'**
  String get homePlanYourVisit;

  /// No description provided for @homePlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Curated multi-day itineraries for heritage explorers'**
  String get homePlanSubtitle;

  /// No description provided for @homeDiscoverLocal.
  ///
  /// In en, this message translates to:
  /// **'Discover Local'**
  String get homeDiscoverLocal;

  /// No description provided for @homeDiscoverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Heritage stays, North Karnataka cuisine & official guides'**
  String get homeDiscoverSubtitle;

  /// No description provided for @homeViewAllPlans.
  ///
  /// In en, this message translates to:
  /// **'View All Plans'**
  String get homeViewAllPlans;

  /// No description provided for @homeDiscoverMore.
  ///
  /// In en, this message translates to:
  /// **'Discover More'**
  String get homeDiscoverMore;

  /// No description provided for @homeChooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Language'**
  String get homeChooseLanguage;

  /// No description provided for @homeChooseLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Vijayapura in your preferred language.'**
  String get homeChooseLanguageSubtitle;

  /// No description provided for @homeChangeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get homeChangeLanguage;

  /// No description provided for @homeDefaultUser.
  ///
  /// In en, this message translates to:
  /// **'Traveller'**
  String get homeDefaultUser;

  /// No description provided for @selectPreferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Preferred Language'**
  String get selectPreferredLanguage;

  /// No description provided for @selectLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your language for an authentic local experience'**
  String get selectLanguageSubtitle;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// No description provided for @welcomeBackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to access your curated Vijayapura travel plans and saved places.'**
  String get welcomeBackSubtitle;

  /// No description provided for @createAccountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join Vijayapura Tourism to explore heritage monuments, curated routes & travel plans.'**
  String get createAccountSubtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get emailHint;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your password'**
  String get confirmPasswordHint;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Darshan Kumar'**
  String get fullNameHint;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email address and we will send you a password reset link.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @backToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Back to Sign In'**
  String get backToSignIn;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @accountCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully!'**
  String get accountCreatedSuccess;

  /// No description provided for @passwordResetSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset link sent to your email.'**
  String get passwordResetSent;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters.'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name.'**
  String get nameRequired;

  /// No description provided for @authError.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Please check your credentials.'**
  String get authError;

  /// No description provided for @exploreTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Vijayapura'**
  String get exploreTitle;

  /// No description provided for @exploreSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Historic monuments, mosques, temples & citadel ruins'**
  String get exploreSubtitle;

  /// No description provided for @searchPlaces.
  ///
  /// In en, this message translates to:
  /// **'Search places by name, history...'**
  String get searchPlaces;

  /// No description provided for @allPlaces.
  ///
  /// In en, this message translates to:
  /// **'All Places'**
  String get allPlaces;

  /// No description provided for @mausoleums.
  ///
  /// In en, this message translates to:
  /// **'Mausoleums'**
  String get mausoleums;

  /// No description provided for @monuments.
  ///
  /// In en, this message translates to:
  /// **'Monuments'**
  String get monuments;

  /// No description provided for @historicForts.
  ///
  /// In en, this message translates to:
  /// **'Historic Forts'**
  String get historicForts;

  /// No description provided for @religiousSites.
  ///
  /// In en, this message translates to:
  /// **'Religious Sites'**
  String get religiousSites;

  /// No description provided for @historyOverview.
  ///
  /// In en, this message translates to:
  /// **'Historical Overview'**
  String get historyOverview;

  /// No description provided for @visitorInfo.
  ///
  /// In en, this message translates to:
  /// **'Visitor Information'**
  String get visitorInfo;

  /// No description provided for @timings.
  ///
  /// In en, this message translates to:
  /// **'Visiting Timings'**
  String get timings;

  /// No description provided for @entryFee.
  ///
  /// In en, this message translates to:
  /// **'Entry Fee'**
  String get entryFee;

  /// No description provided for @suggestedDuration.
  ///
  /// In en, this message translates to:
  /// **'Suggested Duration'**
  String get suggestedDuration;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @navigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigate;

  /// No description provided for @nearbyAttractions.
  ///
  /// In en, this message translates to:
  /// **'Nearby Attractions'**
  String get nearbyAttractions;

  /// No description provided for @nearbyFood.
  ///
  /// In en, this message translates to:
  /// **'Nearby Food'**
  String get nearbyFood;

  /// No description provided for @nearbyStays.
  ///
  /// In en, this message translates to:
  /// **'Nearby Stays'**
  String get nearbyStays;

  /// No description provided for @noPlacesFound.
  ///
  /// In en, this message translates to:
  /// **'No places found matching your search.'**
  String get noPlacesFound;

  /// No description provided for @travelPlansTitle.
  ///
  /// In en, this message translates to:
  /// **'Travel Plans'**
  String get travelPlansTitle;

  /// No description provided for @travelPlansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Official heritage itineraries across Vijayapura'**
  String get travelPlansSubtitle;

  /// No description provided for @oneDayPlan.
  ///
  /// In en, this message translates to:
  /// **'1 Day'**
  String get oneDayPlan;

  /// No description provided for @twoDayPlan1.
  ///
  /// In en, this message translates to:
  /// **'2 Days I'**
  String get twoDayPlan1;

  /// No description provided for @twoDayPlan2.
  ///
  /// In en, this message translates to:
  /// **'2 Days II'**
  String get twoDayPlan2;

  /// No description provided for @threeDayPlan.
  ///
  /// In en, this message translates to:
  /// **'3 Days'**
  String get threeDayPlan;

  /// No description provided for @openRoute.
  ///
  /// In en, this message translates to:
  /// **'Open Route'**
  String get openRoute;

  /// No description provided for @stops.
  ///
  /// In en, this message translates to:
  /// **'Stops'**
  String get stops;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @totalDistance.
  ///
  /// In en, this message translates to:
  /// **'Total Distance'**
  String get totalDistance;

  /// No description provided for @day1.
  ///
  /// In en, this message translates to:
  /// **'DAY 1'**
  String get day1;

  /// No description provided for @day2.
  ///
  /// In en, this message translates to:
  /// **'DAY 2'**
  String get day2;

  /// No description provided for @day3.
  ///
  /// In en, this message translates to:
  /// **'DAY 3'**
  String get day3;

  /// No description provided for @discoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover Vijayapura'**
  String get discoverTitle;

  /// No description provided for @discoverSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Hotels, authentic cuisine, bazaars & guides'**
  String get discoverSubtitle;

  /// No description provided for @hotelsAndStay.
  ///
  /// In en, this message translates to:
  /// **'Hotels & Stay'**
  String get hotelsAndStay;

  /// No description provided for @localCuisine.
  ///
  /// In en, this message translates to:
  /// **'Local Cuisine'**
  String get localCuisine;

  /// No description provided for @bazaarsAndCraft.
  ///
  /// In en, this message translates to:
  /// **'Bazaars & Craft'**
  String get bazaarsAndCraft;

  /// No description provided for @touristGuides.
  ///
  /// In en, this message translates to:
  /// **'Tourist Guides'**
  String get touristGuides;

  /// No description provided for @searchHotels.
  ///
  /// In en, this message translates to:
  /// **'Search hotels by name or location...'**
  String get searchHotels;

  /// No description provided for @searchDishes.
  ///
  /// In en, this message translates to:
  /// **'Search dishes by name, type, or hubs...'**
  String get searchDishes;

  /// No description provided for @searchBazaars.
  ///
  /// In en, this message translates to:
  /// **'Search markets, crafts, or clusters...'**
  String get searchBazaars;

  /// No description provided for @searchGuides.
  ///
  /// In en, this message translates to:
  /// **'Search guides by name or language...'**
  String get searchGuides;

  /// No description provided for @googleMaps.
  ///
  /// In en, this message translates to:
  /// **'Google Maps'**
  String get googleMaps;

  /// No description provided for @directions.
  ///
  /// In en, this message translates to:
  /// **'Directions'**
  String get directions;

  /// No description provided for @approximateLocation.
  ///
  /// In en, this message translates to:
  /// **'Approximate'**
  String get approximateLocation;

  /// No description provided for @locationNavComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Location navigation coming soon'**
  String get locationNavComingSoon;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @dialNow.
  ///
  /// In en, this message translates to:
  /// **'Dial Now'**
  String get dialNow;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @languagesSpoken.
  ///
  /// In en, this message translates to:
  /// **'Languages Spoken'**
  String get languagesSpoken;

  /// No description provided for @contactNumber.
  ///
  /// In en, this message translates to:
  /// **'Contact Number'**
  String get contactNumber;

  /// No description provided for @traditionalBazaars.
  ///
  /// In en, this message translates to:
  /// **'Traditional Bazaars & Commercial Markets'**
  String get traditionalBazaars;

  /// No description provided for @traditionalCrafts.
  ///
  /// In en, this message translates to:
  /// **'Traditional Crafts & Regional Specialties'**
  String get traditionalCrafts;

  /// No description provided for @commonHubs.
  ///
  /// In en, this message translates to:
  /// **'Common Local Hubs & Areas to Explore'**
  String get commonHubs;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @markets.
  ///
  /// In en, this message translates to:
  /// **'Markets'**
  String get markets;

  /// No description provided for @crafts.
  ///
  /// In en, this message translates to:
  /// **'Crafts'**
  String get crafts;

  /// No description provided for @safetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Safety & Emergency'**
  String get safetyTitle;

  /// No description provided for @safetySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency services & traveler assistance in Vijayapura'**
  String get safetySubtitle;

  /// No description provided for @emergencyAssistance.
  ///
  /// In en, this message translates to:
  /// **'Emergency Assistance'**
  String get emergencyAssistance;

  /// No description provided for @emergencySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Immediate access to verified emergency response services'**
  String get emergencySubtitle;

  /// No description provided for @allEmergencies.
  ///
  /// In en, this message translates to:
  /// **'All Emergencies'**
  String get allEmergencies;

  /// No description provided for @ambulance.
  ///
  /// In en, this message translates to:
  /// **'Ambulance'**
  String get ambulance;

  /// No description provided for @police.
  ///
  /// In en, this message translates to:
  /// **'Police'**
  String get police;

  /// No description provided for @fire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get fire;

  /// No description provided for @womenHelpline.
  ///
  /// In en, this message translates to:
  /// **'Women Helpline'**
  String get womenHelpline;

  /// No description provided for @touristAssistance.
  ///
  /// In en, this message translates to:
  /// **'Tourist Assistance'**
  String get touristAssistance;

  /// No description provided for @emergencyGuidelines.
  ///
  /// In en, this message translates to:
  /// **'Emergency Safety Guidelines'**
  String get emergencyGuidelines;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your account, preferences & traveler settings'**
  String get profileSubtitle;

  /// No description provided for @accountDetails.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get accountDetails;

  /// No description provided for @languagePreference.
  ///
  /// In en, this message translates to:
  /// **'Language Preference'**
  String get languagePreference;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About Vijayapura Tourism'**
  String get aboutApp;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard!'**
  String get copiedToClipboard;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No matching results found.'**
  String get noResultsFound;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'en',
    'hi',
    'kn',
    'kok',
    'ml',
    'mr',
    'ta',
    'te',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'kok':
      return AppLocalizationsKok();
    case 'ml':
      return AppLocalizationsMl();
    case 'mr':
      return AppLocalizationsMr();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
