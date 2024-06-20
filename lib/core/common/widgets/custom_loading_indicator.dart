import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            shape: BoxShape.rectangle,
          ),
          child: const Center(
            child: CupertinoActivityIndicator(),
          ),
        ),
      ],
    );
  }
}
