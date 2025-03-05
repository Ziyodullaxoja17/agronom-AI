import 'package:agronom_ai/controller/agro_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultAgroScreen extends StatelessWidget {
  const ResultAgroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the data fetching when the widget is built
    Future.microtask(() => context.read<AgroController>().resultAIModel());

    return Scaffold(
      body: Consumer<AgroController>(
        builder: (context, provider, child) {
          if (provider.isloading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.errorAiModel != null) {
            final error = provider.errorAiModel;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(error?.error?.toString() ?? "Unknown Error"),
                  Text(error?.message?.toString() ??
                      "No error message available"),
                ],
              ),
            );
          }

          if (provider.resultAiModel == null) {
            return const Center(
              child: Text("No Data Available"),
            );
          }

          return Center(
            child: Text("Result: ${provider.resultAiModel}"),
          );
        },
      ),
    );
  }
}
