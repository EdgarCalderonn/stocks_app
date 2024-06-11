import 'package:flutter/material.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({
    super.key,
    required this.retryFunction,
    this.customMessage = 'An error has occurred. \nPlease try again',
  });

  final String customMessage;
  final Function() retryFunction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            customMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 15),
          IconButton(
            onPressed: () {
              retryFunction();
            },
            icon: const Icon(
              Icons.autorenew,
              size: 50,
            ),
          )
        ],
      ),
    );
  }
}
