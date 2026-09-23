import 'package:flutter/material.dart';

import 'place.dart';

/// Localized descriptive content for places across all 8 supported languages.
///
/// Follows deterministic curated localizations with safe English fallback.
class PlaceLocalizations {
  static const Map<String, Map<String, Map<String, String>>> _data = {
    'gol_gumbaz': {
      'en': {
        'shortDescription': 'Mausoleum of Mohammed Adil Shah featuring the world-famous Whispering Gallery.',
        'historicalOverview': 'Gol Gumbaz is the most famous monument in Vijayapura. It is the tomb of Mohammed Adil Shah (ruled 1627–1657). It is the second largest dome ever built, next in size only to St Peter’s Basilica in Rome. A particular attraction in this monument is the central chamber, where every sound is echoed seven times. Another attraction at the Gol Gumbaz is the Whispering Gallery, where even minute sounds can be hear clearly 37 metres away. Gol Gumbaz complex includes a mosque, a Naqqar Khana (a hall for the trumpeters) (now it is used as museum) and the ruins of guest houses. Its vast dome is said to be the Second Largest Dome, unsupported by pillars, in the world, after St. Peter’s in the Vatican City of Rome.It is constructed in such a way that even a pin drop can be heard distinctly from across a space of 38 m, in the Whispering Gallery. The acoustics here are such that any sound made is said to be repeated 10 times over. In the surrounding ornamental gardens is an archeological museum.',
        'ticketPriceInfo': 'ASI Entry Ticket (Indian: ₹25, Foreigner: ₹300; subject to official ASI revisions)',
        'suggestedDuration': '1.5 - 2 Hours',
      },
      'kn': {
        'shortDescription': 'ಜಗತ್ಪ್ರಸಿದ್ಧ ಪಿಸುಗುಟ್ಟುವ ಗ್ಯಾಲರಿಯನ್ನು ಹೊಂದಿರುವ ಮುಹಮ್ಮದ್ ಆದಿಲ್ ಶಾ ಅವರ ಭವ್ಯ ಸಮಾಧಿ.',
        'historicalOverview': 'ಕ್ರಿ.ಶ. 1656 ರಲ್ಲಿ ದಾಬುಲ್‌ನ ವಾಸ್ತುಶಿಲ್ಪಿ ಯಾಖೂತ್ ನಿರ್ಮಿಸಿದ ಗೋಲ್ ಗುಂಬಜ್, ಬಿಜಾಪುರದ ಸುಲ್ತಾನ್ ಮುಹಮ್ಮದ್ ಆದಿಲ್ ಶಾ ಅವರ ಭವ್ಯ ಸಮಾಧಿಯಾಗಿದೆ. ಇದರ ವೃತ್ತಾಕಾರದ ಗುಮ್ಮಟವು ಜಗತ್ತಿನಲ್ಲೇ ಅತಿ ದೊಡ್ಡ ಕಂಬಗಳಿಲ್ಲದ ಸ್ವತಂತ್ರ ಗುಮ್ಮಟಗಳಲ್ಲಿ ಒಂದಾಗಿದ್ದು, ಸುಮಾರು 44 ಮೀಟರ್ ಬಾಹ್ಯ ವ್ಯಾಸವನ್ನು ಹೊಂದಿದೆ. ಗುಮ್ಮಟದ ಒಳಭಾಗದಲ್ಲಿ ಪ್ರಸಿದ್ಧ ಪಿಸುಗುಟ್ಟುವ ಮೊಗಸಾಲೆ (ವಿಸ್ಪರಿಂಗ್ ಗ್ಯಾಲರಿ) ಇದ್ದು, ಇಲ್ಲಿ ಸಣ್ಣ ಧ್ವನಿಯೂ ಹಲವು ಬಾರಿ ಪ್ರತಿಧ್ವನಿಸುತ್ತದೆ.',
        'ticketPriceInfo':
            'ಎಎಸ್‌ಐ ಪ್ರವೇಶ ಟಿಕೆಟ್ (ಭಾರತೀಯರಿಗೆ: ₹25, ವಿದೇಶಿಯರಿಗೆ: ₹300)',
        'suggestedDuration': '1.5 - 2 ಗಂಟೆಗಳು',
      },
      'hi': {
        'shortDescription': 'विश्व प्रसिद्ध फुसफुसाती गैलरी (व्हिस्परिंग गैलरी) से युक्त मोहम्मद आदिल शाह का मकबरा।',
        'historicalOverview': '1656 में दाबुल के वास्तुकार याकूत द्वारा निर्मित गोल गुंबज बीजापुर के सुल्तान मोहम्मद आदिल शाह का मकबरा है। इसका गोलाकार गुंबद दुनिया के सबसे बड़े स्तंभ-रहित गुंबदों में से एक है, जिसका बाहरी व्यास लगभग 44 मीटर है। गुंबद कक्ष के भीतर प्रसिद्ध व्हिस्परिंग गैलरी है, जहाँ धीमी सी फुसफुसाहट भी कई बार गूँजती है।',
        'ticketPriceInfo': 'एएसआई प्रवेश टिकट (भारतीय: ₹25, विदेशी: ₹300)',
        'suggestedDuration': '1.5 - 2 घंटे',
      },
      'mr': {
        'shortDescription': 'जगप्रसिद्ध कुजबुजणाऱ्या गॅलरीचे (व्हिस्परिंग गॅलरी) वैशिष्ट्य असलेली मोहम्मद आदिल शाह यांची समाधी.',
        'historicalOverview': '1656 मध्ये दाबूलचे वास्तुविशारद याकूत यांनी बांधलेला गोल घुमट हा विजापूरचे सुलतान मोहम्मद आदिल शाह यांचा मकबरा आहे. याचा गोलाकार घुमट जगातील सर्वात मोठ्या खांबविरहित घुमटांपैकी एक आहे, ज्याचा बाह्य व्यास सुमारे 44 मीटर आहे. घुमटाच्या आत प्रसिद्ध व्हिस्परिंग गॅलरी आहे, जेथे हलकासा आवाजही अनेक वेळा प्रतिध्वनित होतो.',
        'ticketPriceInfo': 'एएसआय प्रवेश तिकीट (भारतीय: ₹25, परदेशी: ₹300)',
        'suggestedDuration': '1.5 - 2 तास',
      },
      'te': {
        'shortDescription': 'ప్రపంచ ప్రసిద్ధి చెందిన విస్పరింగ్ గ్యాలరీ కలిగిన మహమ్మద్ ఆదిల్ షా సమాధి మందిరం.',
        'historicalOverview': '1656 లో దాబుల్ వాస్తుశిల్పి యాకూత్ చేత నిర్మించబడిన గోల్ గుంబజ్, బీజాపూర్ సుల్తాన్ మహమ్మద్ ఆదిల్ షా సమాధి. దీని గుండ్రని గుమ్మటం ప్రపంచంలోనే అతిపెద్ద స్తంభరహిత గుమ్మటాలలో ఒకటిగా నిలుస్తుంది. గుమ్మటం లోపల ప్రసిద్ధ విస్పరింగ్ గ్యాలరీ ఉంది, ఇక్కడ చిన్న గుసగుస కూడా అనేక సార్లు ప్రతిధ్వనిస్తుంది.',
        'ticketPriceInfo':
            'ASI ప్రవేశ టికెట్ (భారతీయులకు: ₹25, విదేశీయులకు: ₹300)',
        'suggestedDuration': '1.5 - 2 గంటలు',
      },
      'ta': {
        'shortDescription': 'உலகப் புகழ்பெற்ற விஸ்பரிங் கேலரியைக் கொண்ட முகமது அதில் ஷாவின் பிரம்மாண்ட கல்லறை.',
        'historicalOverview': '1656 இல் தாபுல் கட்டிடக் கலைஞர் யாகூத்தால் கட்டப்பட்ட கோல் கும்பாஸ், பிஜப்பூர் சுல்தான் முகமது அதில் ஷாவின் கல்லறை ஆகும். இதன் வட்ட வடிவ குவிமாடம் தூண்களற்ற உலகின் மிகப்பெரிய குவிமாடங்களில் ஒன்றாகும். இதன் உட்பகுதியில் புகழ்பெற்ற முணுமுணுக்கும் கூடம் உள்ளது, அங்கு மிக மெல்லிய ஒலியும் பல முறை எதிரொலிக்கும்.',
        'ticketPriceInfo':
            'ASI நுழைவுச் சீட்டு (இந்தியர்: ₹25, வெளிநாட்டவர்: ₹300)',
        'suggestedDuration': '1.5 - 2 மணிநேரம்',
      },
      'ml': {
        'shortDescription': 'ലോകപ്രശസ്തമായ വിസ്പറിംഗ് ഗാലറിയുള്ള മുഹമ്മദ് ആദിൽ ഷായുടെ സ്മാരക ശവകുടീരം.',
        'historicalOverview': '1656-ൽ ദാബുളിലെ ശില്പി യാഖൂത് നിർമ്മിച്ച ഗോൽ ഗുംബസ്, ബിജാപൂർ സുൽത്താൻ മുഹമ്മദ് ആദിൽ ഷായുടെ ശവകുടീരമാണ്. ഏകദേശം 44 മീറ്റർ വ്യാസമുള്ള ഇതിന്റെ താഴികക്കുടം തൂണുകളില്ലാത്ത ലോകത്തിലെ ഏറ്റവും വലിയ താഴികക്കുടങ്ങളിലൊന്നാണ്. ചെറിയ ശബ്ദം പോലും പലതവണ പ്രതിധ്വനിക്കുന്ന വിസ്പറിംഗ് ഗാലറി ഇതിനകത്താണ്.',
        'ticketPriceInfo':
            'ASI പ്രവേശന ടിക്കറ്റ് (ഇന്ത്യക്കാർക്ക്: ₹25, വിദേശികൾക്ക്: ₹300)',
        'suggestedDuration': '1.5 - 2 മണിക്കൂർ',
      },
      'kok': {
        'shortDescription': 'जगप्रसिद्ध कुजबूज दालन (व्हिस्परिंग गॅलरी) आशिल्लो महंमद आदिल शाह हांचो मकबरो.',
        'historicalOverview': '१६५६ वर्सा दाबुलच्या वास्तुकार याकूत हाणें बांदिल्लो गोल घुमट हो विजापुरचो सुलतान महंमद आदिल शाह हांचो मकबरो. हाचो वाटकुळो घुमट जगांतल्या खांबे नाशिल्ल्या व्हडल्या घुमटां मदलो एक आसा. घुमटाच्या भितर फामाद व्हिस्परिंग गॅलरी आसा, जंय ल्हान सो आवाज लेगीत जायते फावटीं घुमतात.',
        'ticketPriceInfo': 'एएसआय प्रवेश तिकीट (भारतीय: ₹25, विदेशी: ₹300)',
        'suggestedDuration': '१.५ - २ वरां',
      },
    },
    'ibrahim_rauza': {
      'en': {
        'shortDescription': 'The "Taj Mahal of the Deccan", famed for exquisite minarets and stone lattice carvings.',
        'historicalOverview': 'On the western outskirts of the city, lies this exquisite group of buildings containing the twin edifices of the sepulcher of Ibrahim Adil Shah and a mosque. Adorned by slender minarets at each corner, of the utmost elegance and delicacy, fine stone filigree and decorative work. The Ibrahim Rouza is rated as on one of the most beautifully proportioned Islamic monuments in India and an inspiration for the Taj Mahal. The mosque is also a beautiful edifice with five grand arches, ornamented by carved medallions and hanging stone chains. Built on a high stone terrace, the monuments are framed by a lofty tower, ornamented with four graceful minarets, approached by a path through formal gardens.',
        'ticketPriceInfo': 'ASI Ticket Applicable',
        'suggestedDuration': '1 - 1.5 Hours',
      },
      'kn': {
        'shortDescription': 'ಸುಂದರ ಮಿನಾರಗಳು ಹಾಗೂ ನಯವಾದ ಕಲ್ಲಿನ ಕೆತ್ತನೆಗಳಿಗೆ ಹೆಸರಾದ "ದಖ್ಖನ್‌ನ ತಾಜ್ ಮಹಲ್".',
        'historicalOverview': 'ಇಬ್ರಾಹಿಂ ಆದಿಲ್ ಶಾ II (1580-1627) ತನ್ನ ರಾಣಿ ತಾಜ್ ಸುಲ್ತಾನಾ ಹಾಗೂ ತನಗಾಗಿ ನಿರ್ಮಿಸಿದ ಈ ಸಂಕೀರ್ಣವು ಉದ್ಯಾನವನಗಳ ನಡುವೆ ಎತ್ತರದ ಜಗುಲಿಯ ಮೇಲೆ ನೆಲೆಸಿದ ಸಮಾಧಿ ಮತ್ತು ಮಸೀದಿಯನ್ನು ಒಳಗೊಂಡಿದೆ. ನಯವಾದ ಕಲ್ಲಿನ ಜಾಲಂಧ್ರಗಳು, ತೂಗಾಡುವ ಕಲ್ಲಿನ ಸರಪಳಿಗಳು ಮತ್ತು ಪರ್ಷಿಯನ್ ಲಿಪಿಯ ಕುರಾನ್ ಶಾಸನಗಳು ದಖ್ಖನ್ ವಾಸ್ತುಶಿಲ್ಪದ ಅತ್ಯುನ್ನತ ಕಲೆಯಾಗಿದೆ.',
        'ticketPriceInfo': 'ಎಎಸ್‌ಐ ಪ್ರವೇಶ ಶುಲ್ಕ ಅನ್ವಯಿಸುತ್ತದೆ',
        'suggestedDuration': '1 - 1.5 ಗಂಟೆಗಳು',
      },
      'hi': {
        'shortDescription': 'उत्कृष्ट मीनारों और नक्काशीदार जालीदार पत्थरों के लिए प्रसिद्ध "दक्कन का ताजमहल"।',
        'historicalOverview': 'इब्राहिम आदिल शाह द्वितीय (1580-1627) द्वारा अपनी बेगम ताज सुल्ताना और बाद में स्वयं के लिए निर्मित इस परिसर में एक ऊँचे चबूतरे पर स्थित मकबरा और मस्जिद शामिल हैं। नक्काशीदार पत्थर की जालियाँ, लटकती पत्थर की जंजीरें और फारसी सुलेख दक्कनी वास्तुकला की पराकाष्ठा हैं।',
        'ticketPriceInfo': 'एएसआई टिकट लागू',
        'suggestedDuration': '1 - 1.5 घंटे',
      },
      'mr': {
        'shortDescription': 'उत्कृष्ट मिनार आणि दगडी नक्षीकामासाठी प्रसिद्ध असलेला "दख्खनचा ताजमहाल".',
        'historicalOverview': 'इब्राहिम आदिल शाह दुसरा (1580-1627) यांनी आपली राणी ताज सुलताना आणि नंतर स्वतःसाठी बांधलेल्या या संकुलात बागांच्या मधोमध एका उंच ओट्यावर मकबरा आणि मशीद आहे. नाजूक दगडी जाळ्या, लटकणाऱ्या दगडी साखळ्या आणि पर्शियन सुलेखन ही दख्खनी वास्तुकलेची अत्युच्च निर्मिती मानली जाते.',
        'ticketPriceInfo': 'एएसआय तिकीट लागू',
        'suggestedDuration': '1 - 1.5 तास',
      },
      'te': {
        'shortDescription': 'అద్భుతమైన మినార్లు, రాతి చెక్కడాలతో ప్రసిద్ధి చెందిన "దక్కన్ తాజ్ మహల్".',
        'historicalOverview': 'రెండవ ఇబ్రహీం ఆదిల్ షా తన రాణి తాజ్ సుల్తానా కొరకు, తరువాత తన కొరకు నిర్మించిన ఈ సముదాయంలో ఎత్తైన వేదికపై సమాధి, మసీదు ఉన్నాయి. రాతి జాలీ కిటికీలు, రాతి గొలుసులు దక్కన్ వాస్తుకళా నైపుణ్యానికి ప్రతీక.',
        'ticketPriceInfo': 'ASI ప్రవేశ రుసుము వర్తిస్తుంది',
        'suggestedDuration': '1 - 1.5 గంటలు',
      },
      'ta': {
        'shortDescription': 'அற்புதமான மினாரட்டுகள் மற்றும் கல் செதுக்கல்களுக்குப் புகழ்பெற்ற "தக்காணத்தின் தாஜ்மஹால்".',
        'historicalOverview': 'இரண்டாம் இப்ராஹிம் அதில் ஷா தனது ராணி தாஜ் சுல்தானாவுக்காகவும் பின்னர்த் தனக்காகவும் கட்டிய இத்தொகுப்பில் அழகிய கல்லறை மற்றும் பள்ளிவாசல் உள்ளன. நுண்ணிய கல் வேலைப்பாடுகள் மற்றும் பாரசீகக் கல்வெட்டுகள் தக்காணக் கட்டிடக்கலையின் உச்சமாகும்.',
        'ticketPriceInfo': 'ASI நுழைவுச் சீட்டு பொருந்தும்',
        'suggestedDuration': '1 - 1.5 மணிநேரம்',
      },
      'ml': {
        'shortDescription': 'വിശിഷ്ടമായ മിനാരങ്ങളാലും ശിലാ കൊത്തുപണികളാലും പ്രശസ്തമായ "ഡെക്കാന്റെ താജ്മഹൽ".',
        'historicalOverview': 'ഇബ്രാഹിം ആദിൽ ഷാ രണ്ടാമൻ തന്റെ രാജ്ഞി താജ് സുൽത്താനയ്ക്കും തനിക്കുമായി നിർമ്മിച്ച ഈ സമുച്ചയത്തിൽ ഒരു ശവകുടീരവും പള്ളിയും ഉൾപ്പെടുന്നു. സൂക്ഷ്മമായ കല്ല് കൊത്തുപണികളും ശൃംഖലകളും ഡെക്കാൻ വാസ്തുവിദ്യയുടെ വിസ്മയമാണ്.',
        'ticketPriceInfo': 'ASI ടിക്കറ്റ് ബാധകം',
        'suggestedDuration': '1 - 1.5 മണിക്കൂർ',
      },
      'kok': {
        'shortDescription': 'सोबीत मिनार आनी फातरांच्या नक्षीकामा खातीर फामाद आशिल्लो "दख्खनचो ताजमहाल".',
        'historicalOverview': 'इब्राहिम आदिल शाह दुसरो हाणें आपली राणी ताज सुलताना आनी उपरांत स्वता खातीर बांदिल्ल्या ह्या संकुलांत मकबरो आनी मशीद आसा. नाजूक फातराच्यो जाळ्यो, लोंबत्यो सांखळ्यो आनी पर्शियन सुलेखन दख्खनी वास्तुकलेचो अप्रतिम नमुनो आसा.',
        'ticketPriceInfo': 'एएसआय तिकीट लागू',
        'suggestedDuration': '१ - १.५ वरां',
      },
    },
    'bara_kaman': {
      'en': {
        'shortDescription': 'Unfinished 12-arched open-air mausoleum of Ali Adil Shah II against the open sky.',
        'historicalOverview': 'Almost in the centre of the city, and to the north-west of the citadel, is a large square building, roofless and with unfinished arches in dark basalt. This is the tomb of Ali Adil Shah II (1656-72). Probably begun on his accession to the throne in 1656 and intended to rival Gol Gumbaz, the tomb of his father, Muhammad Adil Shah. The building was conceived on a magnificent scale but was destined never to be completed. The platform is 20 feet high. This great elevated basement, on which the arches of this unfinished structure stand, is 215 feet square, while that of the Gol Gumbaz is 158 feet square. In the centre, on a raised platform, are the tomb stones of Ali Adil Shah II and some of his family members, the graves being in the crypt below, which is entered by a door on the east side. The whole structure with the lofty basement would, if it had been completed, have been a most graceful monument in Vijayapura.\nThe building is well maintained with a beautiful garden around the monument. It is called BARA KAMAN by the people.',
        'ticketPriceInfo': 'Free Entry (Protected Monument)',
        'suggestedDuration': '45 Minutes',
      },
      'kn': {
        'shortDescription': 'ಮುಕ್ತ ಆಕಾಶದ ಹಿನ್ನೆಲೆಯಲ್ಲಿ ನಿಂತಿರುವ ಅಲಿ ಆದಿಲ್ ಶಾ II ರ ಅಪೂರ್ಣ 12-ಕಮಾನುಗಳ ಭವ್ಯ ಸಮಾಧಿ.',
        'historicalOverview': 'ಬಾರಾ ಕಮಾನ್ (ಹನ್ನೆರಡು ಕಮಾನುಗಳು) ಕ್ರಿ.ಶ. 1672 ರಲ್ಲಿ ಅಲಿ ಆದಿಲ್ ಶಾ II ರ ಕಾಲದಲ್ಲಿ ಎಲ್ಲಾ ಕಟ್ಟಡಗಳಿಗಿಂತ ಎತ್ತರವಾಗಿರಬೇಕೆಂದು ಯೋಜಿಸಲಾದ ಭವ್ಯ ಸಮಾಧಿ. ಐತಿಹಾಸಿಕ ನಂಬಿಕೆಯ ಪ್ರಕಾರ, ಕಮಾನುಗಳ ಛಾವಣಿ ಪೂರ್ಣಗೊಳ್ಳುವ ಮೊದಲೇ ಕೆಲಸ ಸ್ಥಗಿತಗೊಂಡಿತು. ಇದು ಇಂದಿಗೂ ಆಕಾಶದೆತ್ತರಕ್ಕೆ ನಿಂತಿರುವ ಸುಂದರ ಕಲ್ಲಿನ ಕಮಾನುಗಳ ಸಾಲಾಗಿ ಪ್ರವಾಸಿಗರನ್ನು ಆಕರ್ಷಿಸುತ್ತದೆ.',
        'ticketPriceInfo': 'ಉಚಿತ ಪ್ರವೇಶ (ಸಂರಕ್ಷಿತ ಸ್ಮಾರಕ)',
        'suggestedDuration': '45 ನಿಮಿಷಗಳು',
      },
      'hi': {
        'shortDescription': 'खुले आसमान के नीचे स्थित अली आदिल शाह द्वितीय का अधूरा 12-मेहराबों वाला भव्य मकबरा।',
        'historicalOverview': 'बारा कमान (अर्थात बारह मेहराबें) 1672 में अली आदिल शाह द्वितीय द्वारा एक भव्य मकबरे के रूप में परिकल्पित किया गया था। ऐतिहासिक परंपरा के अनुसार, मेहराबों की छत बनने से पहले ही निर्माण रुक गया, जिससे आसमान को छूती हुई पत्थर के मेहराबों की यह आकर्षक श्रृंखला आज भी पर्यटकों को विस्मित करती है।',
        'ticketPriceInfo': 'निःशुल्क प्रवेश (संरक्षित स्मारक)',
        'suggestedDuration': '45 मिनट',
      },
      'mr': {
        'shortDescription': 'उघड्या आकाशाखाली उभा असलेला अली आदिल शाह दुसरा यांचा अपूर्ण १२ कमानींचा भव्य मकबरा.',
        'historicalOverview': 'बारा कमान (म्हणजे बारा कमानी) 1672 मध्ये अली आदिल शाह दुसरा यांनी एक भव्य मकबरा म्हणून उभारण्यास घेतला होता. ऐतिहासिक माहितीनुसार, कमानींचे छत पूर्ण होण्याआधीच काम थांबले, ज्यामुळे आकाशाला गवसणी घालणाऱ्या दगडी कमानींची ही आकर्षक रचना निर्माण झाली.',
        'ticketPriceInfo': 'मोफत प्रवेश (संरक्षित स्मारक)',
        'suggestedDuration': '45 मिनिटे',
      },
      'te': {
        'shortDescription': 'తెరిచిన ఆకాశం క్రింద ఉన్న రెండవ అలీ ఆదిల్ షా అసంపూర్ణ 12-తోరణాల సమాధి మందిరం.',
        'historicalOverview': 'బారా కమాన్ (అనగా పన్నెండు తోరణాలు) 1672 లో రెండవ అలీ ఆదిల్ షా చేత ప్రతిష్టాత్మకంగా ప్రారంభించబడింది. పైకప్పు పూర్తికాకముందే నిర్మాణం నిలిచిపోవడంతో, రాతి తోరణాల ఈ అద్భుత దృశ్యం నేటికీ నిలిచి ఉంది.',
        'ticketPriceInfo': 'ఉచిత ప్రవేశం (రక్షిత స్మారకం)',
        'suggestedDuration': '45 నిమిషాలు',
      },
      'ta': {
        'shortDescription': 'திறந்த வானத்தின் கீழ் அமைந்துள்ள இரண்டாம் அலி அதில் ஷாவின் முழுமையடையாத 12 வளைவு கல்லறை.',
        'historicalOverview': 'பாரா கமான் (பன்னிரண்டு வளைவுகள்) 1672 இல் இரண்டாம் அலி அதில் ஷாவால் தொடங்கப்பட்டது. வளைவுகளின் மேல் கூரை அமைக்கப்படும் முன்பே வேலை நிறுத்தப்பட்டதால், கம்பீரமான கல் வளைவுகள் வானத்தை நோக்கியபடி காட்சி தருகின்றன.',
        'ticketPriceInfo': 'இலவச அனுமதி (பாதுகாக்கப்பட்ட நினைவுச்சின்னம்)',
        'suggestedDuration': '45 நிமிடங்கள்',
      },
      'ml': {
        'shortDescription': 'തുറന്ന ആകാശത്തിന് കീഴിൽ സ്ഥിതിചെയ്യുന്ന അലി ആദിൽ ഷാ രണ്ടാമന്റെ അപൂർണ്ണമായ 12 കമാനങ്ങളുടെ ശവകുടീരം.',
        'historicalOverview': '1672-ൽ അലി ആദിൽ ഷാ രണ്ടാമൻ വിഭാവനം ചെയ്ത ബારા കമാൻ (പന്ത്രണ്ട് കമാനങ്ങൾ) ഒരു വലിയ ശവകുടീരമായിരുന്നു. മേൽക്കൂര പൂർത്തിയാകുന്നതിന് മുൻപ് നിർമ്മാണം നിലച്ചതിനാൽ, കല്ലിൽ തീർത്ത ഈ ഗംഭീര കമാനങ്ങൾ ആകാശത്തേക്ക് തലയുയർത്തി നിൽക്കുന്നു.',
        'ticketPriceInfo': 'സൗജന്യ പ്രവേശനം (സംരക്ഷിത സ്മാരകം)',
        'suggestedDuration': '45 മിനിറ്റ്',
      },
      'kok': {
        'shortDescription': 'उघड्या मळबा खाला उबो आशिल्लो अली आदिल शाह दुसरो हांचो अपूर्ण १२ कमानींचो मकबरो.',
        'historicalOverview': 'बारा कमान (बारा कमानी) १६७२ वर्सा अली आदिल शाह दुसरो हाणें एक व्हड मकबरो म्हूण बांदपाक सुरवात केल्ली. इतिहास सांगता त्या प्रमाण, छत पुराय जावंचे पयलींच काम थांबिल्ल्यान, फातराच्यो ह्यो देखणी कमानी तश्योच उरल्यात.',
        'ticketPriceInfo': 'फुकट प्रवेश (संरक्षित स्मारक)',
        'suggestedDuration': '४५ मिण्टां',
      },
    },
    'basavanagudi': {
      'en': {
        'shortDescription': 'Sacred shrine dedicated to 12th-century philosopher and social reformer Lord Basaveshwara.',
        'historicalOverview': 'Basavanagudi in Vijayapura honors Jagadjyoti Basaveshwara, the 12th-century philosopher, statesman, and social reformer who pioneered the Vachana movement and established the Anubhava Mantapa. The temple serves as an enduring spiritual and cultural sanctuary for devotees and visitors across Karnataka.',
        'ticketPriceInfo': 'Free Entry',
        'suggestedDuration': '45 Minutes',
      },
      'kn': {
        'shortDescription': '12 ನೇ ಶತಮಾನದ ದಾರ್ಶನಿಕ ಮತ್ತು ಸಮಾಜ ಸುಧಾರಕ ಜಗದ್ಜ್ಯೋತಿ ಬಸವೇಶ್ವರರಿಗೆ ಸಮರ್ಪಿತವಾದ ಪವಿತ್ರ ಕ್ಷೇತ್ರ.',
        'historicalOverview': 'ವಿಜಯಪುರದ ಬಸವನಗುಡಿಯು ವಚನ ಚಳವಳಿಯ ಪ್ರವರ್ತಕ ಹಾಗೂ ಅನುಭವ ಮಂಟಪವನ್ನು ಸ್ಥಾಪಿಸಿದ 12ನೇ ಶತಮಾನದ ಮಹಾನ್ ದಾರ್ಶನಿಕ, ಸಮಾಜ ಸುಧಾರಕ ಜಗದ್ಜ್ಯೋತಿ ಬಸವೇಶ್ವರರಿಗೆ ಗೌರವ ಸಲ್ಲಿಸುತ್ತದೆ. ಈ ದೇವಾಲಯವು ಭಕ್ತಾದಿಗಳಿಗೆ ಮತ್ತು ಪ್ರವಾಸಿಗರಿಗೆ ಆಧ್ಯಾತ್ಮಿಕ ಹಾಗೂ ಸಾಂಸ್ಕೃತಿಕ ಕೇಂದ್ರವಾಗಿದೆ.',
        'ticketPriceInfo': 'ಉಚಿತ ಪ್ರವೇಶ',
        'suggestedDuration': '45 ನಿಮಿಷಗಳು',
      },
      'hi': {
        'shortDescription': '12वीं सदी के दार्शनिक और समाज सुधारक जगद्गुरु बसवेश्वर को समर्पित पवित्र मंदिर।',
        'historicalOverview': 'विजयपुरा का बासवानागुड़ी 12वीं सदी के महान दार्शनिक, राजनेता और समाज सुधारक जगद्गुरु बसवेश्वर का सम्मान करता है, जिन्होंने वचन आंदोलन का नेतृत्व किया और अनुभव मंतप की स्थापना की। यह मंदिर श्रद्धालुओं के लिए एक प्रमुख आध्यात्मिक केंद्र है।',
        'ticketPriceInfo': 'निःशुल्क प्रवेश',
        'suggestedDuration': '45 मिनट',
      },
      'mr': {
        'shortDescription': '१२ व्या शतकातील तत्त्वज्ञ आणि समाजसुधारक महात्मा बसवेश्वर यांना समर्पित पवित्र मंदिर.',
        'historicalOverview': 'विजापूरचे बसवनगुडी हे १२व्या शतकातील तत्त्वज्ञ, मुत्सद्दी आणि समाजसुधारक महात्मा बसवेश्वर यांचे स्मरण करते, ज्यांनी वचन चळवळ सुरू केली आणि अनुभव मंटपाची स्थापना केली. हे मंदिर भक्तांसाठी एक पवित्र आध्यात्मिक केंद्र आहे.',
        'ticketPriceInfo': 'मोफत प्रवेश',
        'suggestedDuration': '45 मिनिटे',
      },
      'te': {
        'shortDescription': '12వ శతాబ్దపు తత్వవేత్త, సంఘ సంస్కర్త బసవేశ్వరునికి అంకితం చేయబడిన పవిత్ర మందిరం.',
        'historicalOverview': 'విజయపురలోని బసవనగుడి 12వ శతాబ్దపు తత్వవేత్త, వచన ఉద్యమ ప్రవర్తకుడు, అనుభవ మంటప స్థాపకుడు జగద్జ్యోతి బసవేశ్వరునికి నివాళి అర్పిస్తుంది. ఈ ఆలయం భక్తులకు పవిత్ర ఆధ్యాత్మిక కేంద్రం.',
        'ticketPriceInfo': 'ఉచిత ప్రవేశం',
        'suggestedDuration': '45 నిమిషాలు',
      },
      'ta': {
        'shortDescription': '12 ஆம் நூற்றாண்டு தத்துவஞானியும் சமூக சீர்திருத்தவாதியுமான பசவேஸ்வரருக்கு அர்ப்பணிக்கப்பட்ட புண்ணிய தலம்.',
        'historicalOverview': 'விஜயபுராவின் பசவனகுடி 12 ஆம் நூற்றாண்டின் தத்துவஞானியும் அனுபவ மண்டபத்தை நிறுவியவருமான ஜகத்குரு பசவேஸ்வரரின் நினைவாக அமைந்துள்ளது. இக்கோயில் பக்தர்களுக்கு ஒரு சிறந்த ஆன்மீக மையமாகும்.',
        'ticketPriceInfo': 'இலவச அனுமதி',
        'suggestedDuration': '45 நிமிடங்கள்',
      },
      'ml': {
        'shortDescription': 'പന്ത്രണ്ടാം നൂറ്റാണ്ടിലെ തത്ത്വചിന്തകനും സാമൂഹിക പരിഷ്കർത്താവുമായ ബസവേശ്വരന് സമർപ്പിച്ചിരിക്കുന്ന പുണ്യക്ഷേത്രം.',
        'historicalOverview': 'വചന പ്രസ്ഥാനത്തിന് തുടക്കം കുറിക്കുകയും അനുഭവ മണ്ഡപം സ്ഥാപിക്കുകയും ചെയ്ത ജഗദ്ജ്യോതി ബസവേശ്വരനെ ആദരിക്കുന്ന ക്ഷേത്രമാണിത്. കർണാടകയിലെ ഭക്തർക്കും സന്ദർശകർക്കും ആത്മീയ അഭയകേന്ദ്രമാണിത്.',
        'ticketPriceInfo': 'സൗജന്യ പ്രവേശനം',
        'suggestedDuration': '45 മിനിറ്റ്',
      },
      'kok': {
        'shortDescription': '१२ व्या शतकांतले विचारवंत आनी समाजसुदारक बसवेश्वरांक ओंपिल्लें पवित्र देवूळ.',
        'historicalOverview': 'विजापुरचें बसवनगुडी १२व्या शतकांतले विचारवंत आनी समाजसुदारक जगद्ज्योती बसवेश्वर हांकां मान दिता, ज्यांनी वचन चळवळ सुरू केली आनी अनुभव मंटपाची थापणूक केली. हें देवूळ भाविकां खातीर एक पवित्र आध्यात्मिक केंद्र आसा.',
        'ticketPriceInfo': 'फुकट प्रवेश',
        'suggestedDuration': '४५ मिण्टां',
      },
    },
    'mehtar_mahal': {
      'en': {
        'shortDescription': 'Intricately carved Adil Shahi ornamental gateway and mosque with exquisite stone filigree.',
        'historicalOverview': 'Constructed around 1620 during the reign of Ibrahim Adil Shah II, Mehtar Mahal is celebrated as an architectural gem of Bijapur. The three-storey stone gateway features stone brackets, delicate balcony carvings, and minarets with stone filigree that appear as though wrought by ivory carvers rather than stonemasons.',
        'ticketPriceInfo': 'Free Entry (Protected Monument)',
        'suggestedDuration': '30 Minutes',
      },
      'kn': {
        'shortDescription': 'ಸೂಕ್ಷ್ಮ ಕಲ್ಲಿನ ಕೆತ್ತನೆ ಮತ್ತು ಕಲಾತ್ಮಕ ಮಿನಾರಗಳನ್ನು ಹೊಂದಿರುವ ಅದ್ಭುತ ಆದಿಲ್ ಶಾಹಿ ಸ್ಮಾರಕ.',
        'historicalOverview': 'ಇಬ್ರಾಹಿಂ ಆದಿಲ್ ಶಾ II ರ ಆಳ್ವಿಕೆಯಲ್ಲಿ ಕ್ರಿ.ಶ. 1620 ರಲ್ಲಿ ನಿರ್ಮಿಸಲಾದ ಮೆಹ್ತರ್ ಮಹಲ್ ಬಿಜಾಪುರದ ಅತ್ಯಂತ ಸೂಕ್ಷ್ಮ ಕೆತ್ತನೆಯ ವಾಸ್ತುಶಿಲ್ಪವಾಗಿದೆ. ಇದರ ಮೂರು ಅಂತಸ್ತಿನ ಪ್ರವೇಶ ದ್ವಾರ, ಬಾಲ್ಕನಿ ಕೆತ್ತನೆಗಳು ಮತ್ತು ಮಿನಾರಗಳು ಮರದ ಅಥವಾ ದಂತದ ಕೆತ್ತನೆಯಂತೆ ಅದ್ಭುತವಾಗಿವೆ.',
        'ticketPriceInfo': 'ಉಚಿತ ಪ್ರವೇಶ (ರಕ್ಷಿತ ಸ್ಮಾರಕ)',
        'suggestedDuration': '30 ನಿಮಿಷಗಳು',
      },
    },
    'almatti_dam': {
      'en': {
        'shortDescription': 'Spectacular dam on Krishna River featuring Mughal & Rock gardens and musical laser fountain show.',
        'historicalOverview': 'The Almatti Dam is a dam project on the Krishna River in North Karnataka, India which was completed in July 2005. The annual electric output of the dam is 713,000,000 kilowatts (KW). The Almatti Dam is the main reservoir of the Upper Krishna Irrigation Project; the 290 megawatt (MW) power project is located on the right side of the Almatti Dam. The facility uses vertical kaplan turbines: five 55MW generators and one 15MW generator. During the initial stages of the project, estimated costs were projected as Rs.1470 crores, but following the transfer of project’s management to the Karnataka Power Corporation Limited (KPCL), the estimated cost was reduced by over fifty percent to Rs.674 crores. The KPCL eventually completed the project at an even lower cost of Rs.520 crores.The entire dam was finished in less than forty months, with construction ending in July 2005. The dam is located on the edge of Vijayapura and Bagalkot districts.\n\nDistance from Vijayapura to Almatti Picnic Spot is 60 KM\n\n1. Lal Bahaduur Shashtri Dam, Almatti\n2. Mughal Garden\n3. Rock Garden\n4. Japanese Garden Lake (Boating Facility)\n5. Musical Fountain',
        'ticketPriceInfo':
            'Entry Ticket: Adults ₹20, Children ₹10; Musical Fountain: ₹30',
        'suggestedDuration': '2 - 3 Hours',
      },
      'kn': {
        'shortDescription': 'ಕೃಷ್ಣಾ ನದಿಗೆ ನಿರ್ಮಿಸಲಾದ ಬೃಹತ್ ಆಣೆಕಟ್ಟು, ಸುಂದರ ಉದ್ಯಾನವನಗಳು ಮತ್ತು ಸಂಗೀತ ಕಾರಂಜಿ ಲೇಸರ್ ಶೋ.',
        'historicalOverview': 'ಲಾಲ್ ಬಹದ್ದೂರ್ ಶಾಸ್ತ್ರಿ ಸಾಗರ (ಆಲಮಟ್ಟಿ ಅಣೆಕಟ್ಟು) ವಿಜಯಪುರ ಜಿಲ್ಲೆಯ ಪ್ರಮುಖ ಆಕರ್ಷಣೆಯಾಗಿದೆ. ಇಲ್ಲಿನ ವಿಶಾಲ ಮೊಘಲ್ ಉದ್ಯಾನ, ರಾಕ್ ಗಾರ್ಡನ್, ದೋಣಿ ವಿಹಾರ ಮತ್ತು ಸಂಜೆಯ ಸಂಗೀತ ನೃತ್ಯ ಕಾರಂಜಿ ಲೇಸರ್ ಪ್ರದರ್ಶನ ಪ್ರವಾಸಿಗರನ್ನು ಆಕರ್ಷಿಸುತ್ತದೆ.',
        'ticketPriceInfo':
            'ಪ್ರವೇಶ ಶುಲ್ಕ: ಹಿರಿಯರಿಗೆ ₹20, ಮಕ್ಕಳಿಗೆ ₹10; ಸಂಗೀತ ಕಾರಂಜಿ: ₹30',
        'suggestedDuration': '2 - 3 ಗಂಟೆಗಳು',
      },
    },
    'archaeological_museum': {
      'en': {
        'shortDescription': 'ASI heritage museum in the Naqqar Khana displaying medieval arms, inscriptions, and Adil Shahi artifacts.',
        'historicalOverview': 'Housed within the historic Naqqar Khana facing the majestic Gol Gumbaz, this ASI museum was established in 1892. It exhibits a remarkable collection of Adil Shahi stone inscriptions in Arabic and Persian, ancient coins, miniature paintings, medieval weaponry, and sculptural treasures from across North Karnataka.',
        'ticketPriceInfo': 'Included with Gol Gumbaz ASI entry ticket',
        'suggestedDuration': '45 Minutes',
      },
      'kn': {
        'shortDescription': 'ಗೋಲ್ ಗುಂಬಜ್ ಆವರಣದಲ್ಲಿರುವ ಪುರಾತತ್ವ ವಸ್ತುಸಂಗ್ರಹಾಲಯ, ಐತಿಹಾಸಿಕ ಶಾಸನಗಳು ಮತ್ತು ಆದಿಲ್ ಶಾಹಿ ಪ್ರಾಚೀನ ವಸ್ತುಗಳು.',
        'historicalOverview': 'ಗೋಲ್ ಗುಂಬಜ್ ಮುಂಭಾಗದ ನಖಾರ್ ಖಾನಾದಲ್ಲಿ 1892 ರಲ್ಲಿ ಸ್ಥಾಪಿಸಲಾದ ಎಎಸ್‌ಐ ಮ್ಯೂಸಿಯಂ, ಆದಿಲ್ ಶಾಹಿ ಕಾಲದ ಅರೇಬಿಕ್ ಮತ್ತು ಪರ್ಷಿಯನ್ ಕಲ್ಲಿನ ಶಾಸನಗಳು, ನಾಣ್ಯಗಳು, ಹಳೆಯ ಆಯುಧಗಳು ಮತ್ತು ಶಿಲ್ಪಕಲೆಗಳನ್ನು ಒಳಗೊಂಡಿದೆ.',
        'ticketPriceInfo': 'ಗೋಲ್ ಗುಂಬಜ್ ಎಎಸ್‌ಐ ಟಿಕೆಟ್‌ನೊಂದಿಗೆ ಒಳಗೊಂಡಿದೆ',
        'suggestedDuration': '45 ನಿಮಿಷಗಳು',
      },
    },
  };

  static String _normalizeId(String id) {
    switch (id) {
      case 'shivagiri':
        return 'shivgiri';
      case 'bara_kamaan':
        return 'bara_kaman';
      case 'upli_buruz':
        return 'upli_burj';
      case 'basavana_bagewadi':
        return 'basavanagudi';
      default:
        return id;
    }
  }

  /// Returns localized [Place] with translations applied for [locale].
  /// Falls back safely to English and original values if translation is absent.
  static Place localize(Place place, Locale locale) {
    final normId = _normalizeId(place.id);
    final placeMap =
        _data[place.id] ??
        _data[normId] ??
        (normId == 'basavanagudi' ? _data['basavana_bagewadi'] : null) ??
        (normId == 'bara_kaman' ? _data['bara_kamaan'] : null);
    if (placeMap == null) return place;

    final langCode = locale.languageCode;
    final localizedFields = placeMap[langCode] ?? placeMap['en'];
    if (localizedFields == null) return place;

    return place.copyWith(
      shortDescription:
          localizedFields['shortDescription'] ?? place.shortDescription,
      historicalOverview:
          localizedFields['historicalOverview'] ?? place.historicalOverview,
      ticketPriceInfo:
          localizedFields['ticketPriceInfo'] ?? place.ticketPriceInfo,
      suggestedDuration:
          localizedFields['suggestedDuration'] ?? place.suggestedDuration,
    );
  }
}

extension PlaceLocalizedExtension on Place {
  Place localized(Locale locale) => PlaceLocalizations.localize(this, locale);
}
