// Registration Page

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:stay_travel_v3/bloc/auth/auth_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_event.dart';
import 'package:stay_travel_v3/bloc/auth/auth_state.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/routes.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/input_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailOrNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  int userType = 0;

  int currentStep = 0;
  bool isSignup = false;


  void registration() {
    if (currentStep == 0) {
      // Validate password and repeat password
      if (_passwordController.text != _repeatPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пароли не совпадают')),
        );
        return;
      }

      if (_emailOrNumberController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _repeatPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пожалуйста, заполните все поля')),
        );
        return;
      }

      setState(() {
        currentStep = currentStep + 1;
      });
    } else if (currentStep == 1) {
      if (_firstNameController.text.isEmpty ||
          _lastNameController.text.isEmpty ||
          _userNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пожалуйста, заполните все поля')),
        );
        return;
      }
      setState(() {
        currentStep = currentStep + 1;
      });
    } else if (currentStep == 2) {

      if (userType == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пожалуйста выберете тип аккаунта.'))
        );

        return;
      }
      final Map<String, dynamic> userData = {
        'emailOrNumber': _emailOrNumberController.text,
        'password': _passwordController.text,
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'username': _userNameController.text,
        'featured_hotels': [],
        'date_of_birth': DateTime.now().toIso8601String(),
        'isBusinessman': userType == 2 ? true : false
      };

      context.read<AuthBloc>().add(RegisterEvent(userData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
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
        builder: (context, state) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomScrollView(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 50),
                ),
                const SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Text('Регистрация', style: AppTextStyles.headerStyle),
                      Text(
                          'Нам понадобится Ваш номер телефона или электронная почта и ФИО. Остальные данные Вы сможете заполнить позже.',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.subheaderBoldStyle),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Theme(
                    data: ThemeData(
                        colorScheme:
                            const ColorScheme.light(primary: AppColors.orange)),
                    child: Column(
                      children: [
                        const Text(''),
                        Stepper(
                          type: StepperType.vertical,
                          currentStep: currentStep,
                          onStepContinue: () {},
                          onStepCancel: () {},
                          onStepTapped: (value) {
                            setState(() {
                              currentStep = value;
                            });
                          },
                          controlsBuilder: (context, controls) {
                            return Row(
                              children: [
                                CustomButton.load(
                                  widget: state is AuthLoading ? const LoadingIndicator(indicatorType: Indicator.ballSpinFadeLoader) : const Text('Далее'),
                                  backgroundColor: AppColors.orange,
                                  width: 75,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  onPressed: () async => registration()
                                ),
                                const SizedBox(width: 10),
                                CustomButton.normal(
                                  text: 'Назад',
                                  backgroundColor: AppColors.orange,
                                  width: 75,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  onPressed: () {
                                    if (currentStep == 0) {
                                      setState(() {
                                        Navigator.pushReplacementNamed(context, Routes.startPage);
                                      });
                                    }else{
                                      setState(() {
                                        currentStep = currentStep - 1;
                                      });
                                    }
                                  },
                                )
                              ],
                            );
                          },
                          steps: [
                            // Step one
                            Step(
                                title: const Text(
                                  'Данные аккаунта',
                                  style: AppTextStyles.subheaderBoldStyle,
                                ),
                                isActive: currentStep >= 0,
                                content: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _emailOrNumberController,
                                        decoration: textFieldDecoration(
                                            'Номер телефона или почта'),
                                        textAlign: TextAlign.left,
                                        textAlignVertical: TextAlignVertical.center,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        controller: _passwordController,
                                        decoration: textFieldDecoration(
                                            'Придумайте пароль'),
                                        textAlign: TextAlign.left,
                                        textAlignVertical: TextAlignVertical.center,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        controller: _repeatPasswordController,
                                        decoration: textFieldDecoration(
                                            'Повторите Ваш пароль'),
                                        textAlign: TextAlign.left,
                                        textAlignVertical: TextAlignVertical.center,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                )),
                            // Step two
                            Step(
                              isActive: currentStep >= 1,
                                title: const Text(
                                  'Личная информация',
                                  style: AppTextStyles.subheaderBoldStyle,
                                ),
                                content: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      TextFormField(
                                        controller: _firstNameController,
                                        decoration: textFieldDecoration('Имя'),
                                        textAlign: TextAlign.left,
                                        textAlignVertical: TextAlignVertical.center,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 15),
                                      TextFormField(
                                        controller: _lastNameController,
                                        decoration: textFieldDecoration('Фамилия'),
                                        textAlign: TextAlign.left,
                                        textAlignVertical: TextAlignVertical.center,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 15),
                                      TextFormField(
                                        controller: _userNameController,
                                        decoration:
                                            textFieldDecoration('Имя пользователя'),
                                        textAlign: TextAlign.left,
                                        textAlignVertical: TextAlignVertical.center,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                )),
                            // Step three
                            Step(
                              isActive: currentStep == 2,
                              title: const Text('Как Вы будете использовать приложение?', style: AppTextStyles.subheaderBoldStyle,), 
                              content: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    Column(
                                      children: [
                                        ListTile(
                                          title: InkWell(
                                            onTap: () {
                                              setState(() {
                                                userType = 1;
                                              });
                                            },
                                            child: const Text('Я путешественник.')),
                                          leading: Radio<int>(
                                            value: 1, 
                                            groupValue: userType, 
                                            onChanged: (value) {
                                              setState(() {
                                                userType = value!;
                                              });
                                            }
                                          ),
                                        ),
                                        ListTile(
                                          title: InkWell(
                                            onTap: () {
                                              setState(() {
                                                userType = 2;
                                              });
                                            },
                                            child: const Text('Я предприниматель.')),
                                          leading: Radio<int>(
                                            value: 2,
                                            groupValue: userType,
                                            onChanged: (value) {
                                              setState(() {
                                                userType = value!;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                            )
                            )
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
