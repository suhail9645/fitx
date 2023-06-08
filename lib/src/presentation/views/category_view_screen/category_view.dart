import 'package:flutter/material.dart';

class CategoryViewPage extends StatelessWidget {
  const CategoryViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
          child: Center(
        child: Text('CategoryViewPage'),
      )),
    );
  }
}
