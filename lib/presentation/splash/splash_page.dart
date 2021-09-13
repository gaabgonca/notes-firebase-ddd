import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_firebase_ddd/application/auth/auth_bloc.dart';
import 'package:notes_firebase_ddd/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:notes_firebase_ddd/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.map(
            authenticated: (_) {
              AutoRouter.of(context).replace(const NotesOverviewPageRoute());
            },
            initial: (_) {},
            unauthenticated: (_) {
              AutoRouter.of(context).replace(const SignInPageRoute());
            },
          );
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
