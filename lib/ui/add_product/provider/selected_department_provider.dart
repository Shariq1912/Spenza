import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDepartmentsProvider =
    StateProvider<Set<String>>((ref) =>  {"All"});

final searchQueryProvider = StateProvider<String>((ref) => '');

