import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        child: CustomScrollView(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 50)
            ),
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    'Войти',
                    style: AppTextStyles.headerStyle
                  ),
                  Text(
                    'Войдите в свою учетную запись, указав номер телефона или адрес электронной почты.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subheaderBoldStyle
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
                    decoration: textFieldDecoration('Номер телефона или почта'),
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
                  CustomButton.normal(
                    text: 'Войти',
                    backgroundColor: AppColors.orange,
                    width: 500,
                    mainAxisAlignment: MainAxisAlignment.center,
                    margin: 5,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.mainPage);
                      //TODO
                      //логика входа
                    }, 
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
        ),
      ),
    );
  }
}