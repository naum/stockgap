#!/usr/local/bin/dart

import 'package:stockgap/stockgap.dart' as cgi;

main() {
  cgi.kickoff();
  print(cgi.render('<h1>stockgap</h1><p>${cgi.env}</p>'));
}

