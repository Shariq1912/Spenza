
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final imagePickerProvider = StateProvider<File?>((ref) => null);
final networkImageProvider = StateProvider<String>((ref) => "");
