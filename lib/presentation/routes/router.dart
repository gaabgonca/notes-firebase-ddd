import 'package:auto_route/auto_route.dart';
import 'package:notes_firebase_ddd/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:notes_firebase_ddd/presentation/sign_in/sign_in_page.dart';
import 'package:notes_firebase_ddd/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage),
    AutoRoute(page: NotesOverviewPage)
  ],
)
class $AppRouter {}
