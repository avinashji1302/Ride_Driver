import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/appstarts/view/welcome_screen.dart';
import 'package:app/screens/audio/viewmodel/audio_provider.dart';
import 'package:app/screens/auth/login/viewModel/login_provider.dart';
import 'package:app/screens/auth/register/viewModel/register_provider.dart';
import 'package:app/screens/chat/viewmodel/chat_provider.dart';
import 'package:app/screens/profile/view_model/upload_doc.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:app/screens/profile/view_model/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => UploadDocProvider()),
        ChangeNotifierProvider(create: (_) => LogoutProvider()),
        // ChangeNotifierProvider(create: (_) => DriverChatProvider.instance),
         ChangeNotifierProvider.value(value: DriverChatProvider.instance),
         ChangeNotifierProvider(create: (_) => AudioCallProvider()),
       
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Your App',

        theme: ThemeData(brightness: Brightness.light, useMaterial3: true),

        darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),

        home: const AuthCheck(),
      ),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final authStorage = AuthStorage();
      final accessToken = await authStorage.getAccessToken();

      debugPrint("📱 Access Token: $accessToken");

      setState(() {
        _isLoggedIn = accessToken != null && accessToken.isNotEmpty;
        _isLoading = true;

        if (_isLoggedIn) {
          debugPrint("inside :.......... ");
          // SocketService().connect(accessToken!);
        }
      });

      debugPrint(
        "✅ Login Status: ${_isLoggedIn ? 'Logged In' : 'Not Logged In'}",
      );

      _isLoading = false;
    } catch (e) {
      debugPrint("❌ Error checking login status: $e");
      setState(() {
        _isLoggedIn = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return const WelcomeScreen();
  }
}
