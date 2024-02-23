import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/utiles/colors.dart';
import 'package:graduation/core/utiles/path.dart';
import 'package:graduation/core/utiles/snakeBar.dart';
import 'package:graduation/core/widgets/custom_button.dart';
import 'package:graduation/core/widgets/custom_text_form_feild.dart';
import 'package:graduation/features/login&registerview/presntation/manager/signup_cubit/cubit/signup_cubit.dart';
import 'package:graduation/features/login&registerview/presntation/view/login-view.dart';
import 'package:graduation/features/login&registerview/presntation/view/widgets/custom_textfeild_passward.dart';
import 'package:graduation/features/login&registerview/presntation/view/widgets/text_login_intro.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerpass = TextEditingController();
  bool lood = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          // if (state is LogInCubitSucssess) {
          //   lood = false;
          //   if (state.data == true) {
          //     GoRouter.of(context).push('/customnavbar');
          //   } else {
          //     showSnakbar(context, 'wrong password or e-mail');
          //   }
          // } else if (state is LogInCubitFailuer) {
          //   lood = false;
          //   showSnakbar(context, 'wrong from server');
          // } else if (state is LogInCubitLooding) {
          //   lood = true;
          // }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: lood,
            child: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 70,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(AssetsPath.logo),
                        const SizedBox(
                          height: 48,
                        ),
                        CustomTextFormFeild(
                            controller: controllerFirstName,
                            keyboardType: TextInputType.name,
                            label: const Text('First Name'),
                            onchanged: (data) {
                              BlocProvider.of<SignupCubit>(context).firstName =
                                  data;
                            },
                            color: AppColors.kGray,
                            hintText: 'First Name'),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormFeild(
                            controller: controllerLastName,
                            keyboardType: TextInputType.name,
                            label: const Text('Last Name'),
                            onchanged: (data) {
                              BlocProvider.of<SignupCubit>(context).lastName =
                                  data;
                            },
                            color: AppColors.kGray,
                            hintText: 'Last Name'),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFormFeild(
                            controller: controllerEmail,
                            keyboardType: TextInputType.emailAddress,
                            label: const Text('E-mail(Required)'),
                            onchanged: (data) {
                              BlocProvider.of<SignupCubit>(context).email =
                                  data;
                            },
                            color: AppColors.kGray,
                            hintText: 'E-mail(Required)'),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomTextFeildPassward(
                          controller: controllerpass,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        CustomButton(
                            textColor: AppColors.kLightColor,
                            fontsize: 16,
                            theText: 'Create New Account',
                            onpressed: () async {
                              if (formkey.currentState!.validate()) {
                                GoRouter.of(context).push('/customnavbar');
                                controllerEmail.clear();
                                controllerpass.clear();

                                //   BlocProvider.of<LogInCubit>(context)
                                //       .postPasswardAndEmail(
                                //     email: BlocProvider.of<LogInCubit>(context)
                                //         .email!,
                                //     password: BlocProvider.of<LogInCubit>(context)
                                //         .password!,
                                //   );
                              }
                            },
                            backgroundColor: AppColors.kPrimary),
                        const SizedBox(
                          height: 16,
                        ),
                        const TextLoginIntro(),
                        const SizedBox(
                          height: 100,
                        ),
                        const Text("Have an account already?",
                            style: TextStyle(
                                fontFamily: 'Poppins-Regular.ttf',
                                fontSize: 16)),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginView()));
                          },
                          child: const Text('Log in',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Bold.ttf',
                                  fontSize: 16,
                                  color: AppColors.kPrimary)),
                        ),
                        const SizedBox(
                          height: 22,
                        )
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
