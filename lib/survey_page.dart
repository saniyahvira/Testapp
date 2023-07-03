import 'package:flutter/material.dart';
import 'package:research_package/research_package.dart';
import 'survey_config.dart';
import 'api/user_sheets_api.dart';
import 'package:intl/intl.dart';

class SurveyPage extends StatelessWidget {
  final int? age;
  final String? name;
  final String? location;
  final DateTime? date;

  const SurveyPage({
    super.key,
    this.age,
    this.name,
    this.location,
    this.date,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: RPUITask(
          task: surveyTask,
          onSubmit: (result) {
            resultCallback(result);
          },
        ),
      );

  void resultCallback(RPTaskResult result) async {
    String formattedResult = '';
    print('FINAL RESULTS');
    print(' age: $age');
    print(' name: $name');
    print(' location: $location');
    print(' date: $date');
    print('RESULTS:');
    result.results.forEach((key, value) {
      value = value as RPActivityResult;
      formattedResult += ' $key\t: ${value.results}';
      print(' $key\t: ${value.results}');
    });
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(date!);

    final value = {
      "id": 1,
      "age": age,
      "name": name,
      "location": location,
      "date": formattedDate,
      "result": formattedResult,
    };
    await UsersheetsApi.insert([value]);
  }
}
