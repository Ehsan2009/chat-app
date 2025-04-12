import 'package:chat_app/src/common_widgets/alert_dialog.dart';
import 'package:chat_app/src/common_widgets/responsive_center.dart';
import 'package:chat_app/src/constants/breakpoints.dart';
import 'package:chat_app/src/features/authentication/presentation/auth_controller.dart';
import 'package:chat_app/src/features/authentication/presentation/widgets/auth_mode_switch.dart';
import 'package:chat_app/src/features/authentication/presentation/widgets/auth_submit_button.dart';
import 'package:chat_app/src/common_widgets/custom_text_form_field.dart';
import 'package:chat_app/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  var enteredEmail = '';
  var enteredPassword = '';

  void submit() async {
    bool validate = formKey.currentState!.validate();

    if (!validate) {
      return;
    }

    formKey.currentState!.save();

    await ref
        .read(authControllerProvider.notifier)
        .authenticate(
          enteredEmail.trim(),
          enteredPassword.trim(),
          EmailPasswordSignInFormType.signIn,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    ref.listen<AsyncValue>(authControllerProvider, (_, state) {
      state.when(
        data: (_) {
          context.goNamed(AppRoute.chat.name);
        },
        loading: () {},
        error: (error, stackTrace) {
          if (mounted) {
            showAlertDialog(context: context, content: error.toString());
          }
        },
      );
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 24, left: 24),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // adding image
                    Image.asset(
                      'assets/images/chat.png',
                      width: 160,
                      color: Theme.of(context).colorScheme.secondary,
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Welcome back you\'ve been missed!',

                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),

                    const SizedBox(height: 24),

                    CustomTextFormField(
                      hintText: 'Email',
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredEmail = value!.trim();
                      },
                    ),

                    const SizedBox(height: 16),

                    CustomTextFormField(
                      hintText: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value.trim().length < 6) {
                          return 'Please enter a valid password with atleast 6 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        enteredPassword = value!;
                      },
                    ),

                    const SizedBox(height: 8),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // submit button
                    AuthSubmitButton(
                      submit: submit,
                      title: 'Login',
                      isAuthenticating: authState.isLoading,
                    ),

                    const SizedBox(height: 20),

                    // switching between login and sign up modes
                    AuthModeSwitch(
                      onTap: () {
                        context.goNamed(AppRoute.register.name);
                      },
                      isLogin: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
