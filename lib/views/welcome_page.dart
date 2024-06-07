// Welcome Page
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_event.dart';
import 'package:stay_travel_v3/bloc/auth/auth_state.dart';
import 'package:stay_travel_v3/bloc/server/server_bloc.dart';
import 'package:stay_travel_v3/bloc/server/server_event.dart';
import 'package:stay_travel_v3/bloc/server/server_state.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/routes.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    context.read<ServerBloc>().add(ServerStatusCheck());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<ServerBloc, ServerState>(
            listener: (context, state) {
              if (state is ServerAviable) {
                context.read<AuthBloc>().add((CheckAuthEvent()));
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                if (state.user.isBusinessman) {
                    Navigator.pushReplacementNamed(context, Routes.mainPageBusinessMan);
                } else {
                  Navigator.pushReplacementNamed(context, Routes.mainPage);
                }
              } else if (state is AuthError && state.type == AuthErrorType.outdatedSession) {
                  Navigator.pushReplacementNamed(context, Routes.mainPage);
              }
            },
          )
        ],
        child: BlocBuilder<ServerBloc, ServerState>(
          builder: (context, state) {
            if (state is ServerLoading) {
              return const Center(
                child: Center(
                  child: Text(
                    'StayTravel',
                    style: AppTextStyles.headerStyle,
                  ),
                ),
              );
            } else if (state is ServerNotAviable) {
              return const Center(
                child: Text('Нет подключения к интернету.'),
              );
            }
            return const Center(
                child: Center(
                  child: Text(
                    'StayTravel',
                    style: AppTextStyles.headerStyle,
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
