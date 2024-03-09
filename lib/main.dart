import 'package:vechtrackapp/constant/kimports.dart';
import 'package:vechtrackapp/repo/Services/getlocalpermission.dart';

void main() async {
  prefuncs();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return HomeBloc();
          },
        )
      ],
      child: MaterialApp(
        routes: myroutes,
        initialRoute: nav.home,
        theme: ThemeData.dark(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkinfo();
    super.initState();
  }

  void checkinfo() {
    WidgetsBinding.instance.addPostFrameCallback((dur) async {
      if (await getlocalpermission().getpermissions()) {
        Navigator.pushReplacementNamed(context, nav.HomePage);
      }
    });
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Kloader(),
    );
  }
}
