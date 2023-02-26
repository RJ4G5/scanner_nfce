library my_prj.globals;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart' ;
import 'package:meu_mercado/Views/scan_nfce/ViewScan.dart';

import 'dart:math';


import 'main.dart';


var logger = Logger();

late MyHomePageState homeState;
late ViewScanState viewScanState;
final random = new Random();





AlertFechNFCE(){
    showDialog(
        barrierDismissible: false,
        context:homeState.context,
        builder: (BuildContext context){
            return AlertDialog(
                    content: new Row(
                      children: [
                        CircularProgressIndicator(),
                        Container(margin: EdgeInsets.only(left: 7),child:Text("Buscando informações..." )),
                      ],
                    ),
                  );
        },
    );
}

CloseAlertFechNFCE() => Navigator.of(homeState.context).pop();

ShowSnackBar(String msg){
    ScaffoldMessenger.of(homeState.context).showSnackBar( SnackBar( content: Text(msg), duration: Duration(milliseconds: 3200), ), );
}
