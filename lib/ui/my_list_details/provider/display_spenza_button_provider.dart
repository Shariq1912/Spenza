import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final displaySpenzaButtonProvider = StateProvider.autoDispose<bool>((ref) => false);
