import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final subjectState = context.watch<HomeProvider>().state;
    final subjectProvider = context.read<HomeProvider>();

    return Placeholder();
  }
}
