import 'package:logger/logger.dart' ;

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart'as dom;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

import 'GetData/GetDataNFCE.dart';

var log = Logger();

class ViewScan extends StatefulWidget {
  const ViewScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewScanState();
}

class _ViewScanState extends State<ViewScan> {
  
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool led = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.


  @override
  Widget build(BuildContext context) {

   // var status =  Permission..request();


    
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.all(8),
                          child: TextButton(
                                    style: ButtonStyle(
                                            backgroundColor: led == false ? MaterialStateProperty.all<Color>(Color(0xFFEEEEEE)) : MaterialStateProperty.all<Color>(Color(0xFFBDBDBD)) ,
                                     ),
                            
                                    onPressed: ()  async{
                                      
                                       await controller?.toggleFlash();
                                       led = (await controller?.getFlashStatus())!;
                                      
                                       
                                       setState(() {
                                 
                                       });
                                      
                                    },
                                    child: FutureBuilder(
                                      future: controller?.getFlashStatus(),
                                      builder: (context, snapshot) {
                                       // led != snapshot.data! ;
                                       
                                        return snapshot.data == false ? const Icon(MdiIcons.lightbulbVariantOutline,color: Color(0xFFBDBDBD),) : const Icon(MdiIcons.lightbulbOn,color: Color(0xFFF5F5F5));
                                      },
                                    )
                          ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.all(15),
                        child: TextButton(
                            style: ButtonStyle(
                                       padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
                                       backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEEEEEE)),
                            ),
                            onPressed: () async {
                              await controller?.pauseCamera().then((value) =>   Navigator.pop(context));
                            },
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                  const Icon(MdiIcons.arrowLeft,color: Color(0xFFBDBDBD)),
                                  const Text('voltar', style: TextStyle(fontSize: 10,color: Color(0xFFBDBDBD))),

                              ],
                            )
                          )
                          
                          ,
                      ),
                     
                    ],
                  ),
                 
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  

  Widget _buildQrView(BuildContext context) {

    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400)  ? 150.0 : 300.0;
   
    return QRView(

      key: qrKey,
      onQRViewCreated: _onQRViewCreated,      
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea,

      ),

      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.resumeCamera();
  
    controller.scannedDataStream.listen((scanData) {
        controller.pauseCamera().then((value)  {
       
            print(scanData.code);
            print(scanData.format);
            
            
             getDataNFCE( url: scanData.code.toString());
            

           /*   http.get(Uri.parse(scanData.code.toString())).then((html){
               
                dom.Document body = parse(html.body);
                var dataTable = body.querySelectorAll("#myTable tr");
                dataTable.forEach((tr) {
                    //print(element.runtimeType);
                    var value = tr.getElementsByTagName("td");
                    
                      print(value[0].getElementsByTagName("h7")[0].text); // produto
                      print(value[1].text); //quantidade
                      print(value[2].text); // unidade
                      var dinheiro = value[3].text.split(r": R$ "); // preço
                      print(double.parse(dinheiro[dinheiro.length-1].replaceAll(",", ".")) );
                      print("--------------------");
                });
              

               
                Navigator.pop(context);
             });  */
        });
        

        

        
       
    });


  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log.d('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sem permisão da camera')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}