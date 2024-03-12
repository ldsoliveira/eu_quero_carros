import 'package:flutter/material.dart';

class HomePageBodyLoading extends StatelessWidget {
  const HomePageBodyLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
