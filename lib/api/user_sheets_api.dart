import 'package:gsheets/gsheets.dart';
import 'package:my_app/survey_page.dart';

class UsersheetsApi {
  static const _credentials = r'''{
  "type": "service_account",
  "project_id": "myapp-389608",
  "private_key_id": "633eca5a41acf119a4a958e5bb3237c759b850bd",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDKr+7bmXEb4v3V\ng1AJf/cssncbTN63wsfP+8APWu+2zQz3ezjtOBeX6WKdPgma2inKwysLbrvDXQDF\ns2KdG8n3/80WXZOFx1qjbKu7N6CvZVKJA0aW1TyMI1JZ1prbQxTIza+thVGlGkTC\nuV7liPPeTdSTfLgR7g4TvryuIf3S3gr/ZXrqSUfREaqy/1UZD4lW7kJu1S6BE06Q\ntkMc9ngBY5DpNcQ/0Dk0xIRisPyW7XG5QL2mrF7eoNRUGkpH7l2eciDOEw25UfbU\nVkCNuTpWa5zCSvcefWT2NFFPlNGBM2+JGxT2gjx+URubT1KShroN0pGnqfHU08UA\neV7vb5iTAgMBAAECggEAKYKqmpLsVVfBwK6p/6gTiTXrqs2td1kO7wuSJBLtsTSB\niVXVLNAmFNiZd7ay5OH1WS9ra2X8UmCDvfmlIqQEUyQybngvtGBFsd6ZtTgJUqKf\nqqvfExkM026QeRG4mVs9sHpfllwNgpDEsFSimMPZnhe2h5YtZI6ql2Si487WWw79\nG9O1CFrpkfPF4Pl8VBDXlYO/gGrSYM+C7yM6tkEx8yM2NMl9UNaVhNEtTo8dn+JM\n2fteMQLQc9hibWSfpvHp+PJZTzDgHNuZJOAyTm44N10o8NhdU1fL+uKZ750IutYn\n5TfR2wUh4DE9nK/Gnahiqe9ycZeoYSeY4yyeafgwoQKBgQDyCITfxzkj1ZcouvFR\nQLC4MUgbuOJB5TlUkDW6xPTnjyp5g4DRTRpfY6q+HsABw5tBY1URVWE3ZbqGuBu5\nLC5aN9swRZQxwJE82tgiQqPEQHlmhz8NfMUJEhM44z1LD+ggBSuPHsEeVmjMqH5O\nGfKDmwDX/i8ffOy9i8vFG5N9qwKBgQDWYircSioBVDgsqNZCJY5kYpTZ/s1fgzYH\nTXpumtcafcwerupaFunC3TfLE62cIJGctDbRbTxTU/VAVrNcSLHX74de+b+bW13Z\n5N45est7s4CbNDGFipUCnZ+v+Xb9RVUtMhQ8vQh49P+75VMIkD+snqWyeH953dWr\n91a2HvVYuQKBgGsGgVtDCW1jIbiNEfDQHlUU1cIMe2CQME3IhznTpkhO8oVRNUFY\nSvUraXEwv88H5DuB5TgI/Tg178lq2DeF5elXEcHCwslNUewLCc/8j9ZUfFpuK9+W\n8LoWGBHrykrK+eZO4vgirVrw8t6tE00OBENV44WfjM7ruvQGQVEj5JCJAoGBAJPY\n/bAQoalq+JasFZ9moS3P4tH4bJBbQA6HO1E+DeyiJvxeKxbYSHxv7cNqncdXmrRU\ngJ2r1Peupiup32ZcZ/IAqf4xBRhSSYY01aEUc3KrF51xwFlVenBkXjWROKNwhk52\nBAjjYQ1yAVAG1l3IhXE5tBJCEb/s4igHmtBcx11ZAoGBALLywfx1gIW3t+2DXkCs\nkDORhYDBLlx+PFR0XevTC/3g2eRlkjufdFUtTBh1mZY0F4Kd7XM3Vjo3BxUsuqKD\nQy07mWkXxs+J8EGMdGCjVYgP6g1Uy1XlmC3iIesLteo0sCth5c5ayyq8lwAi2EgB\n9+pvTiN47ff/An1Pqd8IQIyn\n-----END PRIVATE KEY-----\n",
  "client_email": "myapp-554@myapp-389608.iam.gserviceaccount.com",
  "client_id": "109368196034777649032",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/myapp-554%40myapp-389608.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
  }''';
  static final _spreadsheetsId = '1DJJ2AYpiiiBVxkaDUvVWpgBCywPOAX9h9ABdto-MiFI';
  static final _myapp = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _myapp.spreadsheet(_spreadsheetsId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Person');

      final firstRow = ["key", "age", "name", "location", "date", "result"];
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error:$e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }
}
