import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'b_store_comparison_model.dart';
export 'b_store_comparison_model.dart';

class BStoreComparisonWidget extends StatefulWidget {
  const BStoreComparisonWidget({
    Key? key,
    this.myListRef,
    this.pinList,
    this.quantitiesML,
  }) : super(key: key);

  final DocumentReference? myListRef;
  final List<ProductsRecord>? pinList;
  final List<BquantityRecord>? quantitiesML;

  @override
  _BStoreComparisonWidgetState createState() => _BStoreComparisonWidgetState();
}

class _BStoreComparisonWidgetState extends State<BStoreComparisonWidget> {
  late BStoreComparisonModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BStoreComparisonModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<StoresRecord>>(
      stream: queryStoresRecord(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        List<StoresRecord> bStoreComparisonStoresRecordList = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                automaticallyImplyLeading: false,
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 30.0,
                  ),
                  onPressed: () async {
                    context.safePop();
                  },
                ),
                title: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'lyptoibz' /* Store comparison */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).secondary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    StreamBuilder<MylistRecord>(
                      stream: MylistRecord.getDocument(widget.myListRef!),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                color: FlutterFlowTheme.of(context).primary,
                              ),
                            ),
                          );
                        }
                        final textMylistRecord = snapshot.data!;
                        return Text(
                          textMylistRecord.name,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).secondary,
                                fontWeight: FontWeight.normal,
                              ),
                        );
                      },
                    ),
                  ],
                ),
                actions: [
                  StreamBuilder<MylistRecord>(
                    stream: MylistRecord.getDocument(widget.myListRef!),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 50.0,
                            height: 50.0,
                            child: CircularProgressIndicator(
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                          ),
                        );
                      }
                      final circleImageMylistRecord = snapshot.data!;
                      return Container(
                        width: 100.0,
                        height: 100.0,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          circleImageMylistRecord.myListPhoto,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ],
                centerTitle: true,
                elevation: 2.0,
              ),
            ),
            body: StreamBuilder<List<ProductsRecord>>(
              stream: queryProductsRecord(),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        color: FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  );
                }
                List<ProductsRecord> tabBarProductsRecordList = snapshot.data!;
                return DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment(0.0, 0),
                        child: TabBar(
                          labelColor: FlutterFlowTheme.of(context).primary,
                          labelStyle: FlutterFlowTheme.of(context).bodyMedium,
                          indicatorColor:
                              FlutterFlowTheme.of(context).secondary,
                          tabs: [
                            Tab(
                              text: FFLocalizations.of(context).getText(
                                'xjoacu0x' /* My Stores */,
                              ),
                            ),
                            Tab(
                              text: FFLocalizations.of(context).getText(
                                '5p23pvcx' /* All availale Stores */,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Builder(
                              builder: (context) {
                                final favStore = functions
                                    .listStoresPerTotalFavorite(
                                        bStoreComparisonStoresRecordList
                                            .toList(),
                                        currentUserReference,
                                        widget.pinList!.toList(),
                                        widget.quantitiesML!.toList(),
                                        tabBarProductsRecordList.toList())
                                    .toList();
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: favStore.length,
                                  itemBuilder: (context, favStoreIndex) {
                                    final favStoreItem =
                                        favStore[favStoreIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: StreamBuilder<
                                          List<StoresGroupsRecord>>(
                                        stream: queryStoresGroupsRecord(
                                          queryBuilder: (storesGroupsRecord) =>
                                              storesGroupsRecord.where(
                                                  'storesRef',
                                                  arrayContains:
                                                      favStoreItem.reference),
                                          singleRecord: true,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                ),
                                              ),
                                            );
                                          }
                                          List<StoresGroupsRecord>
                                              myListStoresGroupsRecordList =
                                              snapshot.data!;
                                          final myListStoresGroupsRecord =
                                              myListStoresGroupsRecordList
                                                      .isNotEmpty
                                                  ? myListStoresGroupsRecordList
                                                      .first
                                                  : null;
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                'Finalstep',
                                                queryParameters: {
                                                  'myListRef': serializeParam(
                                                    widget.myListRef,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'storeRef': serializeParam(
                                                    favStoreItem.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'bquantityML': serializeParam(
                                                    widget.quantitiesML,
                                                    ParamType.Document,
                                                    true,
                                                  ),
                                                  'pinList': serializeParam(
                                                    widget.pinList,
                                                    ParamType.Document,
                                                    true,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'bquantityML':
                                                      widget.quantitiesML,
                                                  'pinList': widget.pinList,
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 3.0,
                                                    color: Color(0x411D2429),
                                                    offset: Offset(0.0, 1.0),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 8.0, 8.0, 8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  1.0,
                                                                  1.0,
                                                                  1.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                        child: Image.network(
                                                          myListStoresGroupsRecord!
                                                              .logo,
                                                          width: 80.0,
                                                          height: 80.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    8.0,
                                                                    4.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  functions
                                                                      .totalPerStoreCountItems(
                                                                          widget
                                                                              .pinList!
                                                                              .toList(),
                                                                          widget
                                                                              .quantitiesML!
                                                                              .toList(),
                                                                          favStoreItem
                                                                              .reference,
                                                                          tabBarProductsRecordList
                                                                              .toList())
                                                                      .toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            10.0,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'jlfkyvlk' /*  items unavailable */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            10.0,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              thickness: 1.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .accent4,
                                                            ),
                                                            Text(
                                                              myListStoresGroupsRecord!
                                                                  .name,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  favStoreItem
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            12.0,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        StreamBuilder<
                                                            List<
                                                                BquantityRecord>>(
                                                          stream:
                                                              queryBquantityRecord(),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<BquantityRecord>
                                                                totalBquantityRecordList =
                                                                snapshot.data!;
                                                            return Text(
                                                              formatNumber(
                                                                functions.totalPerStore(
                                                                    widget
                                                                        .pinList!
                                                                        .toList(),
                                                                    totalBquantityRecordList
                                                                        .toList(),
                                                                    favStoreItem
                                                                        .reference,
                                                                    tabBarProductsRecordList
                                                                        .toList()),
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .periodDecimal,
                                                                currency: '',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium,
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            Builder(
                              builder: (context) {
                                final allstores = functions
                                    .listStoresPerTotal(
                                        bStoreComparisonStoresRecordList
                                            .toList(),
                                        widget.pinList!.toList(),
                                        widget.quantitiesML!.toList(),
                                        tabBarProductsRecordList.toList())
                                    .toList();
                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: allstores.length,
                                  itemBuilder: (context, allstoresIndex) {
                                    final allstoresItem =
                                        allstores[allstoresIndex];
                                    return Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 8.0, 16.0, 8.0),
                                      child: StreamBuilder<
                                          List<StoresGroupsRecord>>(
                                        stream: queryStoresGroupsRecord(
                                          queryBuilder: (storesGroupsRecord) =>
                                              storesGroupsRecord.where(
                                                  'storesRef',
                                                  arrayContains:
                                                      allstoresItem.reference),
                                          singleRecord: true,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                ),
                                              ),
                                            );
                                          }
                                          List<StoresGroupsRecord>
                                              myListStoresGroupsRecordList =
                                              snapshot.data!;
                                          final myListStoresGroupsRecord =
                                              myListStoresGroupsRecordList
                                                      .isNotEmpty
                                                  ? myListStoresGroupsRecordList
                                                      .first
                                                  : null;
                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                'Finalstep',
                                                queryParameters: {
                                                  'myListRef': serializeParam(
                                                    widget.myListRef,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'storeRef': serializeParam(
                                                    allstoresItem.reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                  'bquantityML': serializeParam(
                                                    widget.quantitiesML,
                                                    ParamType.Document,
                                                    true,
                                                  ),
                                                  'pinList': serializeParam(
                                                    widget.pinList,
                                                    ParamType.Document,
                                                    true,
                                                  ),
                                                }.withoutNulls,
                                                extra: <String, dynamic>{
                                                  'bquantityML':
                                                      widget.quantitiesML,
                                                  'pinList': widget.pinList,
                                                },
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 3.0,
                                                    color: Color(0x411D2429),
                                                    offset: Offset(0.0, 1.0),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        8.0, 8.0, 8.0, 8.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  1.0,
                                                                  1.0,
                                                                  1.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                        child: Image.network(
                                                          myListStoresGroupsRecord!
                                                              .logo,
                                                          width: 80.0,
                                                          height: 80.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    8.0,
                                                                    8.0,
                                                                    4.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  functions
                                                                      .totalPerStoreCountItems(
                                                                          widget
                                                                              .pinList!
                                                                              .toList(),
                                                                          widget
                                                                              .quantitiesML!
                                                                              .toList(),
                                                                          allstoresItem
                                                                              .reference,
                                                                          tabBarProductsRecordList
                                                                              .toList())
                                                                      .toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            10.0,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    '20oqdtbq' /*  items unavailable */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            10.0,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                            Divider(
                                                              thickness: 1.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .accent4,
                                                            ),
                                                            Text(
                                                              myListStoresGroupsRecord!
                                                                  .name,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    fontSize:
                                                                        12.0,
                                                                  ),
                                                            ),
                                                            Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Text(
                                                                  allstoresItem
                                                                      .name,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Poppins',
                                                                        fontSize:
                                                                            12.0,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        StreamBuilder<
                                                            List<
                                                                BquantityRecord>>(
                                                          stream:
                                                              queryBquantityRecord(),
                                                          builder: (context,
                                                              snapshot) {
                                                            // Customize what your widget looks like when it's loading.
                                                            if (!snapshot
                                                                .hasData) {
                                                              return Center(
                                                                child: SizedBox(
                                                                  width: 50.0,
                                                                  height: 50.0,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                            List<BquantityRecord>
                                                                totalBquantityRecordList =
                                                                snapshot.data!;
                                                            return Text(
                                                              formatNumber(
                                                                functions.totalPerStore(
                                                                    widget
                                                                        .pinList!
                                                                        .toList(),
                                                                    totalBquantityRecordList
                                                                        .toList(),
                                                                    allstoresItem
                                                                        .reference,
                                                                    tabBarProductsRecordList
                                                                        .toList()),
                                                                formatType:
                                                                    FormatType
                                                                        .decimal,
                                                                decimalType:
                                                                    DecimalType
                                                                        .periodDecimal,
                                                                currency: '',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium,
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
