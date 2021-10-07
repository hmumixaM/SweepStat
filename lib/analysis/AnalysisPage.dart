import 'package:flutter/material.dart';
import 'GraphChart.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';


class AnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphChart();
  }
}

pickFile() async {
  FilePickerResult result = await FilePicker.platform.pickFiles();
  if (result != null) {
    PlatformFile file = result.files.first;

    final input = new File(file.path).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(new CsvToListConverter())
        .toList();

    print(fields);
  }
}
