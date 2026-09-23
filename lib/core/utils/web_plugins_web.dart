// ignore_for_file: type=lint
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';

bool _registered = false;

void registerWebPlugins() {
  if (_registered) return;
  _registered = true;
  try {
    final Registrar registrar = webPluginRegistrar;
    FirebaseAuthWeb.registerWith(registrar);
    FirebaseCoreWeb.registerWith(registrar);
    SharedPreferencesPlugin.registerWith(registrar);
  } catch (e) {
    // Ignore if already registered by generated plugin registrant
  }
}
