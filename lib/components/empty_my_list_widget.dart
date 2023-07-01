import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'empty_my_list_model.dart';
export 'empty_my_list_model.dart';

class EmptyMyListWidget extends StatefulWidget {
  const EmptyMyListWidget({Key? key}) : super(key: key);

  @override
  _EmptyMyListWidgetState createState() => _EmptyMyListWidgetState();
}

class _EmptyMyListWidgetState extends State<EmptyMyListWidget> {
  late EmptyMyListModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmptyMyListModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Empty_list_icon.gif',
              width: 130.0,
              height: 250.0,
              fit: BoxFit.contain,
            ),
            Text(
              FFLocalizations.of(context).getText(
                '1u67vgv4' /* You don't 
have any 
list yet,... */
                ,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
