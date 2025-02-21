import 'package:flutter/material.dart';

class DownloadOptionsDialog extends StatefulWidget {
  final Function(String type, String quality) onDownload;

  const DownloadOptionsDialog({
    super.key,
    required this.onDownload,
  });

  @override
  State<DownloadOptionsDialog> createState() => _DownloadOptionsDialogState();
}

class _DownloadOptionsDialogState extends State<DownloadOptionsDialog> {
  String selectedType = 'Video';
  String selectedQuality = '1080p';

  final Map<String, List<String>> qualityOptions = {
    'Video': ['1080p', '720p', '480p'],
    'Audio': ['320kbps', '256kbps', '128kbps'],
  };

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
            value: selectedType,
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
                setState(() {
                  selectedType = value;
                  selectedQuality = qualityOptions[value]!.first;
                });
              }
            },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: selectedQuality,
            items: qualityOptions[selectedType]!
                .map((quality) => DropdownMenuItem(
                      value: quality,
                      child: Text(quality),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedQuality = value;
                });
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
          onPressed: () {
            widget.onDownload(selectedType, selectedQuality);
            Navigator.pop(context);
          },
          child: const Text('Download'),
        ),
      ],
    );
  }
}
