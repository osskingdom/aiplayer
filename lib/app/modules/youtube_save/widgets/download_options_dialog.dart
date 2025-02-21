import 'package:flutter/material.dart';

class DownloadOptionsDialog extends StatelessWidget {
  final Function(String type, String quality) onDownload;

  const DownloadOptionsDialog({
    super.key,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Download Options'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Select media type and quality:'),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: 'Video',
            items: const [
              DropdownMenuItem(
                value: 'Video',
                child: Text('Video'),
              ),
              DropdownMenuItem(
                value: 'Audio',
                child: Text('Audio'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                onDownload(value, '1080p');
              }
            },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: '1080p',
            items: const [
              DropdownMenuItem(
                value: '1080p',
                child: Text('1080p'),
              ),
              DropdownMenuItem(
                value: '720p',
                child: Text('720p'),
              ),
              DropdownMenuItem(
                value: '480p',
                child: Text('480p'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                onDownload('Video', value);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Download'),
        ),
      ],
    );
  }
}
