import 'package:flutter/material.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import '../utils/routes.dart';
import '../widgets/custom_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

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
                  Text('StayTravel', style: AppTextStyles.headerStyle),
                  Text(
                      'Поиск и бронирование отелей. Поделитесь своим опытом и всегда оставайтесь путешественником.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.subheaderBoldStyle,
                      ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomButton.normal(
                    text: 'Присоединиться',
                    backgroundColor: AppColors.orange,
                    width: 500,
                    mainAxisAlignment: MainAxisAlignment.center,
                    margin: 25,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.registrationPage);
                    },
                  ),
                  CustomButton.normal(
                    text: 'Войти',
                    backgroundColor: AppColors.grey,
                    width: 500,
                    mainAxisAlignment: MainAxisAlignment.center,
                    margin: 5,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.loginPage);
                    },
                  ),
                  CustomButton.normal(
                    text: 'Помощь',
                    backgroundColor: AppColors.grey,
                    width: 500,
                    mainAxisAlignment: MainAxisAlignment.center,
                    margin: 5,
                    onPressed: () {
                      Navigator.pushNamed(context, '/help_view');
                    },
                  )
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: Text(
                  'Нажимая кнопку «Присоединиться», Вы соглашаетесь с нашими Условиями и с тем, что вы ознакомились с нашей Политикой использования данных, включая использование файлов cookie',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
