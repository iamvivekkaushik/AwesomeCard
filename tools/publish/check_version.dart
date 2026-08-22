import 'dart:io';
import 'package:yaml/yaml.dart';

// ignore_for_file: avoid_print

void main(List<String> args) {
  print(args);
  final pubspec = File('pubspec.yaml');
  final content = loadYaml(pubspec.readAsStringSync()) as YamlMap;

  final pubspecVersion = content['version'] as String;
  var tagVersion = '';
  if (args.isNotEmpty) {
    tagVersion = args[0].split('/').last;
  }
  if (tagVersion.startsWith('v')) {
    tagVersion = tagVersion.substring(1);
  }

  if (pubspecVersion != tagVersion) {
    throw Exception(
        'pubspec version ($pubspecVersion) and tag version ($tagVersion) are different');
  }
}
