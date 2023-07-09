import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errorMessege;
  const ErrorText({super.key, required this.errorMessege});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessege),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final String errorMessege;
  const ErrorPage({super.key, required this.errorMessege});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorText(errorMessege: errorMessege),
    );
  }
}
