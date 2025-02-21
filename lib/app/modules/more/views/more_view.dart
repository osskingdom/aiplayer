import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/more_controller.dart';

class MoreView extends GetView<MoreController> {
  const MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Options'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('App Settings'),
              onTap: () {
                // TODO: Handle settings tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // TODO: Handle about tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & Support'),
              onTap: () {
                // TODO: Handle help tap
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Send Feedback'),
              onTap: () {
                // TODO: Handle feedback tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
