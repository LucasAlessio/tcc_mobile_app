import 'package:flutter/material.dart';

class ErrorCallout extends StatelessWidget {
  final String title;
  final String message;

  const ErrorCallout({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [0.02, 0.02],
              colors: [
                Theme.of(context).colorScheme.error,
                Colors.white,
              ],
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(6.0),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.error_outline_outlined,
                  size: 32,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(message),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
