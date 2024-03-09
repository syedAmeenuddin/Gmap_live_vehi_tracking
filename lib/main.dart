import 'package:vechtrackapp/constant/kimports.dart';

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
      Location location = Location();
      bool serviceenable = await location.serviceEnabled();
      if (serviceenable == false) {
        await location.requestService();
        await location.requestPermission();
      }

      if (serviceenable) {
        PermissionStatus permissionstatus = await location.hasPermission();
        if (permissionstatus == PermissionStatus.granted) {
          Navigator.pushReplacementNamed(context, nav.HomePage);
        }
      } else {
        if (serviceenable) {
          Navigator.pushReplacementNamed(context, nav.HomePage);
        } else {
          return;
        }
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
