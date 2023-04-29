import 'package:flutter/material.dart';

class ErrorEntityWidget extends StatelessWidget {
  final String message;
  final VoidCallback onButtonPressed;
  const ErrorEntityWidget({
    super.key,
    required this.message,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 200,
            child: TextButton(
              style: TextButton.styleFrom(
                elevation: 0,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: onButtonPressed,
              child: const Text(
                'Try again',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
