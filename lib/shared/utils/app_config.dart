import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AppConfig {
  const AppConfig._();

  static const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
  static const supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static bool get hasSupabaseConfig {
    return supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
  }
}

class FirebaseConfig {
  const FirebaseConfig._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      TargetPlatform.macOS => throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for macos - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      ),
      TargetPlatform.windows => throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for windows - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      ),
      TargetPlatform.linux => throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for linux - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      ),
      _ => throw UnsupportedError(
        'DefaultFirebaseOptions are not supported for this platform.',
      ),
    };
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: String.fromEnvironment('FIREBASE_ANDROID_API_KEY'),
    appId: String.fromEnvironment('FIREBASE_ANDROID_APP_ID'),
    messagingSenderId: String.fromEnvironment(
      'FIREBASE_ANDROID_MESSAGING_SENDER_ID',
    ),
    projectId: String.fromEnvironment('FIREBASE_ANDROID_PROJECT_ID'),
    storageBucket: String.fromEnvironment('FIREBASE_ANDROID_STORAGE_BUCKET'),
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: String.fromEnvironment('FIREBASE_IOS_API_KEY'),
    appId: String.fromEnvironment('FIREBASE_IOS_APP_ID'),
    messagingSenderId: String.fromEnvironment(
      'FIREBASE_IOS_MESSAGING_SENDER_ID',
    ),
    projectId: String.fromEnvironment('FIREBASE_IOS_PROJECT_ID'),
    storageBucket: String.fromEnvironment('FIREBASE_IOS_STORAGE_BUCKET'),
    androidClientId: String.fromEnvironment('FIREBASE_IOS_ANDROID_CLIENT_ID'),
    iosClientId: String.fromEnvironment('FIREBASE_IOS_IOS_CLIENT_ID'),
    iosBundleId: String.fromEnvironment('FIREBASE_IOS_IOS_BUNCLE_ID'),
  );
}
