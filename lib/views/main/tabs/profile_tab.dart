// Profile Tab

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/bloc/auth/auth_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_event.dart';
import 'package:stay_travel_v3/bloc/auth/auth_state.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/utils/routes.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.white,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Skeletonizer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.5),
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.grey3,
                              radius: 64,
                            ),
                            SizedBox(width: 20),
                            SizedBox(
                                width: 200,
                                child: Text(
                                  'Matvey Lazarev',
                                  style: AppTextStyles.headerStyle,
                                ))
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Настройки аккаунта',
                              style: AppTextStyles.subheaderBoldStyle),
                          CustomButton.icon(
                            text: 'Персональная информация',
                            icon: Icons.person_outline_outlined,
                            backgroundColor: AppColors.grey,
                            onPressed: () {},
                          ),
                          CustomButton.icon(
                            text: 'Уведомления',
                            icon: Icons.notifications_outlined,
                            backgroundColor: AppColors.grey,
                            onPressed: () {},
                          ),
                          CustomButton.icon(
                            text: 'Приватность',
                            icon: Icons.privacy_tip_outlined,
                            backgroundColor: AppColors.grey,
                            onPressed: () {},
                          ),
                          const Text(
                            'Поддержка',
                            style: AppTextStyles.subheaderBoldStyle,
                          ),
                          CustomButton.header(
                            header: 'Центр безопасности',
                            text:
                                'Получите поддержку, инструменты и информацию, необходимые вам для обеспечения безопасности',
                            icon: Icons.safety_check_outlined,
                            width: MediaQuery.sizeOf(context).width - 15,
                            height: 94,
                            backgroundColor: AppColors.grey,
                            margin: 4,
                            onPressed: () {},
                          ),
                          CustomButton.header(
                            header: 'Контакты поддержки',
                            text: 'Сообщите нашей команде о ваших проблемах',
                            icon: Icons.support_agent_outlined,
                            width: MediaQuery.sizeOf(context).width - 15,
                            height: 75,
                            backgroundColor: AppColors.grey,
                            margin: 4,
                            onPressed: () {},
                          ),
                          const SizedBox(height: 25),
                          CustomButton.normal(
                            text: 'Выйти из аккаунта',
                            mainAxisAlignment: MainAxisAlignment.center,
                            onPressed: () {
                              context.read<AuthBloc>().add(LogoutEvent());
                              Navigator.pushReplacementNamed(
                                  context, Routes.mainPage);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          if (state is AuthAuthenticated) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.5),
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
                slivers: [
                   SliverToBoxAdapter(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColors.grey3,
                            radius: 64,
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                              width: 200,
                              child: Text(
                                '${state.user.firstname} ${state.user.lastname}',
                                style: AppTextStyles.headerStyle,
                              ))
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Настройки аккаунта',
                            style: AppTextStyles.subheaderBoldStyle),
                        CustomButton.icon(
                          text: 'Персональная информация',
                          icon: Icons.person_outline_outlined,
                          //width: MediaQuery.sizeOf(context).width - 32,
                          backgroundColor: AppColors.grey,
                          onPressed: () {},
                        ),
                        CustomButton.icon(
                          text: 'Уведомления',
                          icon: Icons.notifications_outlined,
                          //width: MediaQuery.sizeOf(context).width - 32,
                          backgroundColor: AppColors.grey,
                          onPressed: () {},
                        ),
                        CustomButton.icon(
                          text: 'Приватность',
                          icon: Icons.privacy_tip_outlined,
                          //width: MediaQuery.sizeOf(context).width - 32,
                          backgroundColor: AppColors.grey,
                          onPressed: () {},
                        ),
                        const Text(
                          'Поддержка',
                          style: AppTextStyles.subheaderBoldStyle,
                        ),
                        CustomButton.header(
                          header: 'Центр безопасности',
                          text:
                              'Получите поддержку, инструменты и информацию, необходимые вам для обеспечения безопасности',
                          icon: Icons.safety_check_outlined,
                          width: MediaQuery.sizeOf(context).width - 15,
                          height: 94,
                          backgroundColor: AppColors.grey,
                          margin: 4,
                          onPressed: () {},
                        ),
                        CustomButton.header(
                          header: 'Контакты поддержки',
                          text: 'Сообщите нашей команде о ваших проблемах',
                          icon: Icons.support_agent_outlined,
                          width: MediaQuery.sizeOf(context).width - 15,
                          height: 75,
                          backgroundColor: AppColors.grey,
                          margin: 4,
                          onPressed: () {},
                        ),
                        const SizedBox(height: 25),
                        CustomButton.normal(
                          text: 'Выйти из аккаунта',
                          mainAxisAlignment: MainAxisAlignment.center,
                          onPressed: () {
                            context.read<AuthBloc>().add(LogoutEvent());
                            Navigator.pushReplacementNamed(
                                context, Routes.mainPage);
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          if (state is AuthError) {
            return Center(
              child: Text(state.message),
            );
          }
          
          return Container();
        },
      ),
    );
  }
}
