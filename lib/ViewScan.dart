import 'package:logger/logger.dart' ;


import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:meu_mercado/main.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'GetData/GetDataNFCE.dart';
import 'global.dart' as global;


var logger = Logger();

class ViewScan extends StatefulWidget {

 const  ViewScan({Key? key}) : super(key: key);
  
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
      body: Stack(
        children: <Widget>[
          
            
            _buildQrView(context),
            Container(
              height: 80,
              width: 80,
              margin: EdgeInsets.only(top: 50,left: 30),
             
              child: TextButton(
                    style: ButtonStyle(
                                 shape:  MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
                                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
                                backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(0, 238, 238, 238)),
                    ),
                    onPressed: () async {
                      await controller?.pauseCamera().then((value) =>   Navigator.pop(context));
                    },
                    child: const Icon(MdiIcons.arrowLeft,color: Color(0xFFBDBDBD),size: 40)
              ) ,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:Container(
                  height:80,
                  width: 80,
                  margin: EdgeInsets.only(bottom: 50),
                  
                  child: TextButton(
                          style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
                                  shape:  MaterialStateProperty.all<CircleBorder>(const CircleBorder()),
                                  backgroundColor: led == false ? MaterialStateProperty.all<Color>(Color.fromARGB(0, 238, 238, 238)) : MaterialStateProperty.all<Color>(Color.fromARGB(108, 189, 189, 189)) ,
                            ),
                  
                          onPressed: ()  async{
                            context.findAncestorStateOfType<MyHomePageState>()?.listAllNFCEs();
                              await controller?.toggleFlash();
                              led = (await controller?.getFlashStatus())!;
                            
                              
                              setState(() {
                        
                              });
                            
                          },
                          child: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              // led != snapshot.data! ;
                              
                              return snapshot.data == false ? const Icon(MdiIcons.lightbulbVariantOutline,color: Color(0xFFBDBDBD),size: 40,) : const Icon(MdiIcons.lightbulbOn,color: Color(0xFFF5F5F5),size: 40);
                            },
                          )
                  ),
              ) ,
            ),
          
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
            
            
            getDataNFCE( url: scanData.code.toString(), context:context );
            

          
        });
        

        

        
       
    });


  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    logger.d('${DateTime.now().toIso8601String()}_onPermissionSet $p');
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