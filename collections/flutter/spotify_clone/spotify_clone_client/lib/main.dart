import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone_client/core/providers/current_user_notifier.dart';
import 'package:spotify_clone_client/core/theme/app_theme.dart';
import 'package:spotify_clone_client/features/auth/view/pages/signup.dart';
import 'package:spotify_clone_client/features/auth/viewmodel/auth_view_model.dart';
import 'package:spotify_clone_client/features/home/view/pages/upload_song_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ProviderContainer container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).validateAndGetToken();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    return MaterialApp(
      theme: AppTheme.darkThemeMode,
      home: currentUser != null ? UploadSongPage() : SignUp(),
    );
  }
}
