import 'package:flutter/material.dart';

class FontStyles {
  // Regular
  static const TextStyle regular = TextStyle(
    fontFamily: 'SourceSans3',
    fontWeight: FontWeight.normal,
  );
  static const TextStyle regularList = TextStyle(
    fontFamily: 'SourceSans3',
    fontWeight: FontWeight.w400,
      fontSize: 14
  );

  // Bold
  static const TextStyle bold = TextStyle(
    fontFamily: 'SourceSans3',
    fontWeight: FontWeight.bold,
      fontSize: 16
  );
  static const TextStyle bold14 = TextStyle(
    fontFamily: 'SourceSans3',
    fontWeight: FontWeight.bold,
      fontSize: 14
  );

  // Italic
  static const TextStyle italic = TextStyle(
    fontFamily: 'SourceSans3',
    fontStyle: FontStyle.italic,
  );

  // Bold Italic
  static const TextStyle boldItalic = TextStyle(
    fontFamily: 'SourceSans3',
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    fontSize: 16
  );
}
