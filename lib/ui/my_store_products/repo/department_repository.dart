import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/network/api_responses.dart';

import '../../../utils/firestore_constants.dart';
import '../data/departments_data.dart';

part 'department_repository.g.dart';

@riverpod
class DepartmentRepository  extends _$DepartmentRepository {

  ApiResponse build(){
    return ApiResponse();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DepartmentDataClass>> getDepartments() async {
    state = ApiResponse.loading();
    try{
      QuerySnapshot<Map<String,dynamic>> snapshot = await _firestore.collection(Department.departmentCollection).get();

      final List<DepartmentDataClass> departments = snapshot.docs.map((doc) {
        final data = doc.data();
        final dept = DepartmentDataClass.fromJson(data);
        return dept;
      }).toList();

      departments.forEach((element) {
        print("departmentsList :${element.name}");
      });

      state = ApiResponse.success(data: departments);
      return departments;
    } catch(error){
      state = ApiResponse.error(errorMsg: error.toString());
      return [];
    }
  }
}