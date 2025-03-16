import 'package:flutter/material.dart';

class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    required this.submit,
    required this.isLogin,
    required this.isAuthenticating,
  });

  final void Function() submit;
  final bool isLogin;
  final bool isAuthenticating;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: submit,
      child: Container(
        width: 370,
        height: 75,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: isAuthenticating
            ? CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
            )
            : Text(
                isLogin ? 'Login' : 'Sign Up',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
