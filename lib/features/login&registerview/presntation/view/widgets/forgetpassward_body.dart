import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/utiles/colors.dart';
import 'package:graduation/core/utiles/path.dart';
import 'package:graduation/core/utiles/snakeBar.dart';
import 'package:graduation/core/utiles/styles.dart';
import 'package:graduation/core/widgets/custom_button.dart';
import 'package:graduation/core/widgets/custom_text_form_feild.dart';
import 'package:graduation/features/login&registerview/presntation/manager/forget_cubit/forget_cubit.dart';
import 'package:graduation/features/login&registerview/presntation/view/widgets/text_login_intro.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPasswardViewBody extends StatefulWidget {
  const ForgetPasswardViewBody({super.key});

  @override
  State<ForgetPasswardViewBody> createState() => _ForgetPasswardViewBodyState();
}

class _ForgetPasswardViewBodyState extends State<ForgetPasswardViewBody> {
  final GlobalKey<FormState> key = GlobalKey();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController univesityController = TextEditingController();
  String? sCode;
  String? email;
  String? id;
  bool islooded = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetCubit(),
      child: BlocConsumer<ForgetCubit, ForgetCubitState>(
        listener: (context, state) {
          if (state is ForgetCubitLooding) {
            islooded = true;
          } else if (state is ForgetCubitSuccess) {
            islooded = false;
            if (state.data == true) {
              GoRouter.of(context).push('/LoginViwe');
              showSnakbar(context, 'New PASSWORD is your ID');
            } else {
              showSnakbar(context, 'wrong s_code or e-mail or ID_N');
            }
          } else if (state is ForgetCubitfailuer) {
            islooded = false;
            showSnakbar(context, 'wrong in server');
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: islooded,
            child: Form(
              key: key,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(AssetsPath.logo),
                        const SizedBox(
                          height: 48,
                        ),
                        CustomTextFormFeild(
                            controller: codeController,
                            onchanged: (data) {
                              sCode = data;
                            },
                            label: const Text('Student code(Required)'),
                            color: AppColors.kGray,
                            hintText: 'Student code(Required)'),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormFeild(
                            controller: idController,
                            onchanged: (data) {
                              id = data;
                            },
                            keyboardType: TextInputType.number,
                            label: const Text('ID Number(Required)'),
                            color: AppColors.kGray,
                            hintText: 'ID Number(Required)'),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormFeild(
                            controller: univesityController,
                            onchanged: (data) {
                              email = data;
                            },
                            label: const Text('University Email(Required)'),
                            color: AppColors.kGray,
                            hintText: 'University Email(Required)'),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'Your passward will be sent to your mail',
                          style: Styles.textstyle16.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.kPrimary,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomButton(
                            textColor: AppColors.kLightColor,
                            fontsize: 16,
                            theText: 'Send',
                            onpressed: () {
                              if (key.currentState!.validate()) {
                                BlocProvider.of<ForgetCubit>(context)
                                    .forgetPassword(
                                        studintCode: sCode!,
                                        id: id!,
                                        email: email!);
                                codeController.clear();
                                idController.clear();
                                univesityController.clear();
                              }
                            },
                            backgroundColor: AppColors.kPrimary),
                        const SizedBox(
                          height: 16,
                        ),
                        const TextLoginIntro()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
