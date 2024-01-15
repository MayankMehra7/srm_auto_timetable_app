import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';

Future<dynamic> main(final context) async {
  String year = context.req.query['year'];
  String department = context.req.query['department'];
  String section = context.req.query['section'];
  String timetable = "${year}_${department}_$section.csv";
  context.log(timetable);

  final jsonData = await csvToJson(context, "/timetables/$timetable");
  context.log(jsonData);
  return context.res.json(json);
}

Future<String> csvToJson(final context, String filePath) async {
  try {
    final file = File(filePath);
    context.log(filePath);
    final csvData = await file.readAsString();
    final parsedCsv = CsvToListConverter().convert(csvData);

    // Create the desired JSON structure
    final jsonData = <String, List>{};
    for (final row in parsedCsv) {
      final day = row[0];
      final values = row.sublist(1); // Skip the first column (day)
      jsonData[day] = values;
    }

    return jsonEncode(jsonData);
  } catch (error) {
    context.error('Error reading CSV file: $error');
    return '{"error": "Failed to read CSV file"}';
  }
}
