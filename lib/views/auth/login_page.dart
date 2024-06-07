import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_event.dart';
import 'package:stay_travel_v3/bloc/auth/auth_state.dart';
import 'package:stay_travel_v3/utils/routes.dart';

import '../../themes/colors.dart';
import '../../themes/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailOrNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              if (state.user.isBusinessman) {
                Navigator.pushReplacementNamed(
                    context, Routes.mainPageBusinessMan);
              } else {
                Navigator.pushReplacementNamed(context, Routes.mainPage);
              }
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
              ));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 50)),
                  const SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Text('Войти', style: AppTextStyles.headerStyle),
                        Text(
                          'Войдите в свою учетную запись, указав номер телефона или адрес электронной почты.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.subheaderBoldStyle,
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const Text(
                          '',
                          style: AppTextStyles.titleTextStyle,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailOrNumberController,
                          decoration:
                              textFieldDecoration('Номер телефона или почта'),
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: _passwordController,
                          decoration: textFieldDecoration('Пароль'),
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          obscureText: true,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 40),
                        CustomButton.load(
                          backgroundColor: AppColors.orange,
                          width: 500,
                          mainAxisAlignment: MainAxisAlignment.center,
                          margin: 5,
                          onPressed: () {
                            final email = _emailOrNumberController.text;
                            final password = _passwordController.text;
                            context
                                .read<AuthBloc>()
                                .add(LoginEvent(email, password));
                          },
                          widget: state is AuthLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  "Войти",
                                  style: AppTextStyles.titleTextStyle
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                        ),
                        CustomButton.normal(
                          text: 'Назад',
                          backgroundColor: AppColors.grey,
                          width: 500,
                          mainAxisAlignment: MainAxisAlignment.center,
                          margin: 5,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
