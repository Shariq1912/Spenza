import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCTreiYuXpFSi2ILLRCUh7LzM-fx5g4XrY",
            authDomain: "spenzabeta-74e04.firebaseapp.com",
            projectId: "spenzabeta-74e04",
            storageBucket: "spenzabeta-74e04.appspot.com",
            messagingSenderId: "928248104131",
            appId: "1:928248104131:web:54533997c75f2cb8950e76"));
  } else {
    await Firebase.initializeApp();
  }
}
