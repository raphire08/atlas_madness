import 'dart:convert';

import 'package:functions_framework/functions_framework.dart';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';

const emailAPIKey = 'md-_Z4n5nFZlOmIn0cyFF_WqQ';

@CloudFunction()
Future<Response> function(Request request) async {
  final queryBody = await request.readAsString();
  final email = jsonDecode(queryBody)['email'];
  final message = jsonDecode(queryBody)['message'];
  final title = jsonDecode(queryBody)['title'];

  Map<String, dynamic> body = {
    "key": emailAPIKey,
    "message": {
      "from_email": "hello@example.com",
      "subject": "$title",
      "text": "$message",
      "to": [
        {"email": '$email', "type": "to"}
      ]
    }
  };
  return await http
      .post(
        Uri.parse('https://mandrillapp.com/api/1.0/messages/send'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      )
      .then((value) => Response.ok(jsonEncode('Email Sent')));
}
