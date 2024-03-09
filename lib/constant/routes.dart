import 'package:vechtrackapp/constant/kimports.dart';

Map<String, Widget Function(BuildContext)> myroutes = {
  nav.home: (context) {
    return MyApp();
  },
   nav.HomePage: (context) {
    return HomePage();
  },
};
