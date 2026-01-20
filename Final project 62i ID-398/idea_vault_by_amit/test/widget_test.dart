import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:idea_vault_by_amit/main.dart';
import 'package:idea_vault_by_amit/providers/auth_provider.dart';
import 'package:idea_vault_by_amit/providers/idea_provider.dart';

void main() {
  testWidgets('App shows login or idea screen', (WidgetTester tester) async {
    
    await Supabase.initialize(
      url: 'https://hjeqjbtyvuzwivlqmknc.supabase.co',
      anonKey: 'sb_publishable_8eB6tzdhW_93tnZ9_e2Gqg_Nk3_evaR',
    );

   
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => IdeaProvider()),
        ],
        child: IdeaVaultApp(),
      ),
    );

    await tester.pumpAndSettle();

    
    expect(find.text('Login / Register'), findsOneWidget);

    
    expect(find.byType(FloatingActionButton), findsNothing);
  });
}

