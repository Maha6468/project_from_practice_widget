import '../../firebase_options.dart';

await FirebaseNotification.instance.initializeApp();

await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);