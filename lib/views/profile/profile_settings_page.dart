// Profile Settings Page
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stay_travel_v3/bloc/auth/auth_bloc.dart';
import 'package:stay_travel_v3/bloc/auth/auth_event.dart';
import 'package:stay_travel_v3/bloc/auth/auth_state.dart';
import 'package:stay_travel_v3/bloc/user/user_bloc.dart';
import 'package:stay_travel_v3/bloc/user/user_event.dart';
import 'package:stay_travel_v3/bloc/user/user_state.dart';
import 'package:stay_travel_v3/models/user.dart';
import 'package:stay_travel_v3/themes/colors.dart';
import 'package:stay_travel_v3/themes/text_styles.dart';
import 'package:stay_travel_v3/widgets/custom_button.dart';
import 'package:stay_travel_v3/widgets/input_field.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  late User oldUser;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();

  DateTime _dateOfBirth = DateTime.now();
  late var formattedDate;

  late String photo = '';

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        File file = File(selectedImage.path);

        photo = base64Encode(file.readAsBytesSync());
      });
    }
  }

  void updateProfile() {
    try {
      final User updatedUser = User(
          id: oldUser.id,
          email: _emailController.text.isEmpty
              ? oldUser.email
              : _emailController.text,
          number: _numberController.text.isEmpty
              ? oldUser.number
              : _numberController.text,
          username: _userNameController.text.isEmpty
              ? oldUser.username
              : _userNameController.text,
          firstname: _firstNameController.text.isEmpty
              ? oldUser.firstname
              : _firstNameController.text,
          lastname: _lastNameController.text.isEmpty
              ? oldUser.lastname
              : _lastNameController.text,
          dateOfBirth: _dateOfBirth,
          avatar: photo.isEmpty ? oldUser.avatar : photo,
          dateOfRegistration: oldUser.dateOfRegistration,
          isBusinessman: oldUser.isBusinessman);

      context.read<UserBloc>().add(UserUpdate(user: updatedUser));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserUpdated) {
          context.read<AuthBloc>().add(CheckAuthEvent());
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Редактирование'),
            centerTitle: true,
            actions: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserUpdating) {
                    return const LoadingIndicator(
                        indicatorType: Indicator.ballSpinFadeLoader);
                  } else {
                    return IconButton(
                        onPressed: () {
                          updateProfile();
                        },
                        icon: const Icon(Icons.save));
                  }
                },
              )
            ],
          ),
          body: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, userState) {
                if (state is AuthLoading) {
                  Skeletonizer(
                    child: Padding(padding: const EdgeInsets.all(7.5), child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        const SliverToBoxAdapter(
                          child: Text(
                            'Данные аккаунта',
                            style: AppTextStyles.subheaderBoldStyle,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: TextFormField(
                            decoration:
                                textFieldDecoration('email').copyWith(
                              prefixIcon: const Icon(Icons.email),
                              prefixIconColor: AppColors.orange2,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: TextFormField(
                            decoration: textFieldDecoration('number')
                                .copyWith(
                              prefixIcon: const Icon(Icons.phone),
                              prefixIconColor: AppColors.orange2,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: TextFormField(
                            decoration:
                                textFieldDecoration('username').copyWith(
                              prefixIcon: const Icon(Icons.alternate_email),
                              prefixIconColor: AppColors.orange2,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Text(
                            'Личные данные',
                            style: AppTextStyles.subheaderBoldStyle,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  decoration:
                                      textFieldDecoration('first name'),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  decoration:
                                      textFieldDecoration('last name'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: TextFormField(
                              decoration:
                                  textFieldDecoration(formattedDate).copyWith(
                                      prefixIcon: const Icon(Icons.date_range),
                                      hintText: formattedDate,
                                      prefixIconColor: AppColors.orange2,
                                      suffixIcon: const IconButton(
                                          icon: Icon(Icons.edit),
                                          onPressed: null))),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Text(
                            'Смена пароля',
                            style: AppTextStyles.subheaderBoldStyle,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 3,
                                  child: TextFormField(
                                    decoration:
                                        textFieldDecoration('Старый пароль'),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  flex: 3,
                                  child: TextFormField(
                                    decoration:
                                        textFieldDecoration('Новый пароль'),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              const Flexible(
                                  flex: 1,
                                  child: CustomButton.load(
                                    widget: Icon(
                                            Icons.check,
                                            color: AppColors.background,
                                          ),
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    onPressed: null
                                  ))
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Text(
                            'Фото профиля',
                            style: AppTextStyles.subheaderBoldStyle,
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              gradient: LinearGradient(
                                colors: [Color(0xfffd8112), Color(0xff0085ca)],
                                stops: [0, 1],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.edit,
                                    size: 32,
                                    color: Colors.transparent,
                                  )),
                              const Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                    radius: 80,
                                    backgroundColor: AppColors.grey,
                                    ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _pickImage();
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 32,
                                    color: AppColors.background,
                                  ))
                            ],
                          ),
                        ))
                      ],
                    ),),
                  );
                }

                if (state is AuthAuthenticated) {
                  _dateOfBirth = state.user.dateOfBirth;
                  formattedDate = DateFormat('d-MMM-yy').format(_dateOfBirth);
                  oldUser = state.user;
      
                  return Padding(
                    padding: const EdgeInsets.all(7.5),
                    child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        const SliverToBoxAdapter(
                          child: Text(
                            'Данные аккаунта',
                            style: AppTextStyles.subheaderBoldStyle,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: TextFormField(
                            controller: _emailController,
                            decoration:
                                textFieldDecoration(state.user.email).copyWith(
                              prefixIcon: const Icon(Icons.email),
                              prefixIconColor: AppColors.orange2,
                            ),
                            enabled: state.user.email.isEmpty,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: TextFormField(
                            controller: _numberController,
                            decoration: textFieldDecoration(
                                    state.user.number.isEmpty
                                        ? 'Номер телефона'
                                        : state.user.number)
                                .copyWith(
                              prefixIcon: const Icon(Icons.phone),
                              prefixIconColor: AppColors.orange2,
                            ),
                            keyboardType: TextInputType.phone,
                            enabled: state.user.number.isEmpty,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: TextFormField(
                            controller: _userNameController,
                            decoration:
                                textFieldDecoration(state.user.username).copyWith(
                              prefixIcon: const Icon(Icons.alternate_email),
                              prefixIconColor: AppColors.orange2,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Text(
                            'Личные данные',
                            style: AppTextStyles.subheaderBoldStyle,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  controller: _firstNameController,
                                  decoration:
                                      textFieldDecoration(state.user.firstname),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  controller: _lastNameController,
                                  decoration:
                                      textFieldDecoration(state.user.lastname),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: TextFormField(
                              decoration:
                                  textFieldDecoration(formattedDate).copyWith(
                                      prefixIcon: const Icon(Icons.date_range),
                                      hintText: formattedDate,
                                      prefixIconColor: AppColors.orange2,
                                      suffixIcon: IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () async {
                                            await showDatePicker(
                                              context: context,
                                              initialDate: _dateOfBirth,
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2025),
                                            ).then((selectedDate) {
                                              if (selectedDate != null) {
                                                setState(() {
                                                  _dateOfBirth = selectedDate;
                                                  formattedDate =
                                                      DateFormat('d-MMM-yyyy')
                                                          .format(selectedDate);
                                                });
                                              }
                                            });
                                          }))),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Text(
                            'Смена пароля',
                            style: AppTextStyles.subheaderBoldStyle,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: _oldPasswordController,
                                    obscureText: true,
                                    decoration:
                                        textFieldDecoration('Старый пароль'),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  flex: 3,
                                  child: TextFormField(
                                    controller: _newPasswordController,
                                    obscureText: true,
                                    decoration:
                                        textFieldDecoration('Новый пароль'),
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  flex: 1,
                                  child: CustomButton.load(
                                    widget: userState is UserUpdating
                                        ? const LoadingIndicator(
                                            indicatorType:
                                                Indicator.ballSpinFadeLoader)
                                        : const Icon(
                                            Icons.check,
                                            color: AppColors.background,
                                          ),
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    onPressed: () {
                                      context.read<UserBloc>().add(
                                          UserUpdatePassword(
                                              old_password:
                                                  _oldPasswordController.text,
                                              new_password:
                                                  _newPasswordController.text));
                                    },
                                  ))
                            ],
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 10,
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Text(
                            'Фото профиля',
                            style: AppTextStyles.subheaderBoldStyle,
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: Container(
                          width: double.infinity,
                          height: 200,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              gradient: LinearGradient(
                                colors: [Color(0xfffd8112), Color(0xff0085ca)],
                                stops: [0, 1],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.edit,
                                    size: 32,
                                    color: Colors.transparent,
                                  )),
                              Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                    radius: 80,
                                    backgroundColor: AppColors.grey,
                                    backgroundImage: state.user.avatar != null
                                        ? MemoryImage(
                                            base64Decode(state.user.avatar!),
                                          )
                                        : photo != ''
                                            ? MemoryImage(base64Decode(photo))
                                            : null),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _pickImage();
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 32,
                                    color: AppColors.background,
                                  ))
                            ],
                          ),
                        ))
                      ],
                    ),
                  );
                }
      
                return const SizedBox.shrink();
              },
            );
          })),
    );
  }
}
