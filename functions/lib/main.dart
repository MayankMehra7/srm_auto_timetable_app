import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

const Map timetables = {
  "1_bca_a":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_bca_a.csv",
  "1_bca_b":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_bca_b.csv",
  "1_bca_c":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_bca_c.csv",
  "1_bca_ds_a":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_bca_ds_a.csv",
  "1_bca_ds_b":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_bca_ds_b.csv",
  "1_bca_ds_c":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_bca_ds_c.csv",
  "1_mca_a":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_mca_a.csv",
  "1_mca_b":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_mca_b.csv",
  "1_mca_c":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_mca_c.csv",
  "1_mca_d":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_mca_d.csv",
  "1_mca_e":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_mca_e.csv",
  "1_mca_f":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_mca_f.csv",
  "1_mca_g":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_mca_g.csv",
  "1_msc_ads_a":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_msc_ads_a.csv",
  "1_msc_ads_b":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_msc_ads_b.csv",
  "1_msc_ads_c":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_msc_ads_c.csv",
  "1_msc_ads_d":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/1_msc_ads_b.csv",
  "2_bca_a":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/2_bca_a.csv",
  "2_bca_b":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/2_bca_b.csv",
  "2_bca_c":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/2_bca_c.csv",
  "2_bca_ds":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/2_bca_ds.csv",
  "3_bca_a":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/3_bca_a.csv",
  "3_bca_b":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/3_bca_b.csv",
  "3_bca_ds":
      "https://raw.githubusercontent.com/LiveWiresSRM2023/srm_auto_timetable_app/Main/functions/timetables/3_bca_ds.csv"
};

Future<dynamic> main(final context) async {
  String year = context.req.query['year'];
  String department = context.req.query['department'];
  String section = context.req.query['section'];
  String timetable = "${year}_${department}_$section.csv";
  context.log(timetable);

  final jsonData = await csvToJson(context, timetables[timetable]);
  context.log(jsonData);
  return context.res.send(jsonData);
}

// void main() async {
//   String timetable = "1_bca_a.csv";
//   final jsonData = await csvToJson("timetables/1_bca_a.csv");
//   print(jsonData);
// }

csvToJson(final context, String url) async {
  try {
    final file = await http.get(Uri.parse(url));
    final csvData = file.body;
    context.log(csvData);
    final parsedCsv = CsvToListConverter().convert(csvData);

    // Create the desired JSON structure
    final jsonData = <String, List>{};
    for (final row in parsedCsv) {
      final day = row[0];
      final values = row.sublist(1); // Skip the first column (day)
      jsonData[day] = values;
    }
    return jsonData;
  } catch (error) {
    context.error('Error reading CSV file: $error');
    // print('Error reading CSV file: $error');
    return '{"error": "Failed to read CSV file"}';
  }
}
