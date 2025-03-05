import 'package:agronom_ai/controller/agro_controller.dart';
import 'package:agronom_ai/presentation/screens/result_agro_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainAgroScreen extends StatelessWidget {
  const MainAgroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AgroController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Hello Agro AI",
              style: TextStyle(fontSize: 20),
            ),
            centerTitle: true,
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                provider.file != null
                    ? Image.file(provider.file!,
                        width: 200, height: 200, fit: BoxFit.cover)
                    : Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey[300],
                        child: Icon(Icons.image,
                            size: 100, color: Colors.grey[600]),
                      ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    await provider.pickPicture();
                  },
                  icon: const Icon(Icons.photo),
                  label: const Text("Pick Image"),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () async {
                    await provider.uploadPicture();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultAgroScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text("Upload Image"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
