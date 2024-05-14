// Registration Page
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';

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

  int currentStep = 0;
  bool isSignup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      currentStep: 0,
                      onStepContinue: () {},
                      onStepCancel: () {},
                      onStepTapped: (value) {},
                      controlsBuilder: (context, controls) {
                        return Row(
                          children: [
                            !isSignup
                                ? CustomButton.normal(
                                    text: 'Далее',
                                    backgroundColor: AppColors.orange,
                                    width: 75,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    onPressed: () async {})
                                : const CircularProgressIndicator(),
                            const SizedBox(width: 10),
                            CustomButton.normal(
                              text: 'Назад',
                              backgroundColor: AppColors.orange,
                              width: 75,
                              mainAxisAlignment: MainAxisAlignment.center,
                              onPressed: () {},
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
                            isActive: currentStep >= 1,
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
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
