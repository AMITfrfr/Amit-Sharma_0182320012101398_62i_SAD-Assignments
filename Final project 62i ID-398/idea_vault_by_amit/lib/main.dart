import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/auth_provider.dart';
import 'providers/idea_provider.dart';
import 'screens/auth_screen.dart';
import 'screens/idea_home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  await Supabase.initialize(
    url: 'https://hjeqjbtyvuzwivlqmknc.supabase.co',
    anonKey: 'sb_publishable_8eB6tzdhW_93tnZ9_e2Gqg_Nk3_evaR',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => IdeaProvider()),
      ],
      child: const IdeaVaultApp(),
    ),
  );
}

class IdeaVaultApp extends StatelessWidget {
  const IdeaVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IdeaVault',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (_, auth, __) =>
            auth.isLoggedIn ? IdeaHomeScreen() : const AuthScreen(),
      ),
    );
  }
}
