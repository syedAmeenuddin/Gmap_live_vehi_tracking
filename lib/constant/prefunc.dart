
import 'package:vechtrackapp/constant/kimports.dart';

Future prefuncs() async{
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}