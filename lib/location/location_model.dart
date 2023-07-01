import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LocationModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for zipCode widget.
  TextEditingController? zipCodeController;
  String? Function(BuildContext, String?)? zipCodeControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    zipCodeController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
