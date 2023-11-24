import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/business_logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:crm/presentations/routes/routes.dart';
import 'package:crm/utils/constants/api_constants.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:crm/utils/constants/image_strings.dart';
import 'package:crm/utils/constants/texts.dart';
import 'package:quickalert/quickalert.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthLoginError) {
            context.pop();
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: state.error,
                animType: QuickAlertAnimType.slideInUp);
          }
          if (state is AuthLoginLoading) {
            QuickAlert.show(
              context: context,
              headerBackgroundColor: TColors.tPrimaryColor,
              type: QuickAlertType.loading,
              barrierDismissible: false,
            );
          }
          if (state is AuthLoginSuccess) {
            context.pop();
            await QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                animType: QuickAlertAnimType.slideInDown,
                autoCloseDuration: const Duration(seconds: 1));
            TLocalStorage.saveString(tokenKey, state.userToken.accessToken);
            if (!context.mounted) return;
            context.pushReplacementNamed(RouteNames.tabBox);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(TImages.background),
              fit: BoxFit.fill,
            ),
          ),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PageTitle(text: TTexts.login),
                  const Gap(20),
                  const NickTextField(),
                  const Gap(20),
                  const PasswordTextField(),
                  const Gap(20),
                  LoginButton(
                    formKey: formKey,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final nickName = context.read<AuthBloc>().nicknameController.text;
                        final password = context.read<AuthBloc>().passwordController.text;
                        context
                            .read<AuthBloc>()
                            .add(AuthLogin(login: nickName, password: password));
                        // context.pushReplacementNamed(RouteNames.tabBox);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PageTitle extends StatelessWidget {
  final String text;

  const PageTitle({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headlineLarge
            ?.copyWith(fontWeight: FontWeight.w800, color: Colors.black),
      ),
    );
  }
}

class NickTextField extends StatelessWidget {
  const NickTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: context.read<AuthBloc>().nicknameController,
      decoration: InputDecoration(hintText: TTexts.nick),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: context.read<AuthBloc>().passwordController,
      obscureText: !context.watch<VisiblePasswordBloc>().passwordVisible,
      decoration: InputDecoration(
        hintText: TTexts.password,


        suffixIcon: IconButton(
          icon: Icon(
            context.watch<VisiblePasswordBloc>().passwordVisible
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: () {
            context.read<VisiblePasswordBloc>().togglePasswordVisibility();
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return TTexts.nickValidate;
        }
        return null;
      },
    );
    // GlobalTextField(
    //   hintText: TTexts.password,
    //   validator: TValidator.validatePassword,
    //   controller: context.read<AuthBloc>().passwordController,
    //   obscureText: true,
    // );
  }
}

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onPressed;

  const LoginButton({required this.formKey, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    // i want to convert button child to circular indicator when form is loading
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        child: const Text(TTexts.login),
      ),
    );
  }
}

class VisiblePasswordBloc with ChangeNotifier {
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}
