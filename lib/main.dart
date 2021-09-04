import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_app1/constants.dart';
import 'package:flutter_app1/src/models/cart_entry.dart';
import 'package:flutter_app1/src/models/user.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'src/app.dart';

Box cartEntriesBox;
Box userBox;

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  var appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(CartEntryAdapter());
  Hive.registerAdapter(UserAdapter());
  cartEntriesBox = await Hive.openBox('my_cartBox');
  userBox = await Hive.openBox('my_userBox');

  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(
    AppConstants.ONESIGNAL_APP_ID,
  ); // OneSignal.shared.(OSNotificationDisplayType.notification);

  OneSignal.shared
      .setSubscriptionObserver((OSSubscriptionStateChanges changes) async {
    // will be called whenever the subscription changes
    //(ie. user gets registered with OneSignal and gets a user ID)
    var status = await OneSignal.shared.getDeviceState();
    // if (status.subscriptionStatus.subscribed) {
    //   String onesignalUserId = status.subscriptionStatus.userId;
    //   print('Player ID: ' + onesignalUserId);
    // }
  });

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  await OneSignal.shared
      .promptUserForPushNotificationPermission(fallbackToSettings: true);
  await Firebase.initializeApp();
  runApp(RestartWidget(child: MyApp()));
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: KeyedSubtree(child: widget.child, key: key));
    /* return KeyedSubtree(
      key: key,
      child: widget.child,
    );*/
  }
}
