// Welcome Page  
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/server/server_bloc.dart';
import 'package:stay_travel_v3/bloc/server/server_event.dart';
import 'package:stay_travel_v3/bloc/server/server_state.dart';
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
      body: BlocBuilder<ServerBloc, ServerState>(
        builder: (context, state) {
          if (state is ServerLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ServerAviable) {
            Navigator.pushReplacementNamed(context, Routes.mainPage);
          } 
          else {
            return const Center(
              child: Text('Нет подключения к интернету'),
            );
          }
          return Container();
        },
      ),
    );
  }
}