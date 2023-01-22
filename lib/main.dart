import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:localstore/localstore.dart';
import 'ViewScan.dart';
// ignore: prefer_const_constructors
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final db = Localstore.instance;
   List<Map<String, dynamic>> list_NFCEs = [ ];

  void _incrementCounter() {
    setState(() {
      
       Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ViewScan(),
            ));
    });
  }

  void listAllNFCEs() async{
    print("listAllNFCEs");

     
      db.collection('NFCEs').get().then((docs) {
        if(docs != null){
        
         docs.forEach((key, value) {list_NFCEs.add(value);});
         setState(() {});
        }
     
          

      });
    
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listAllNFCEs();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(15, 0, 0, 0),
                    spreadRadius: 5,
                    blurRadius: 7,
                   // changes position of shadow
                  ),
                  
                ],
              ),
              
            ),
            Expanded(
              child: ListView.builder(
                itemCount: list_NFCEs.length,
                itemBuilder: (context, index) {
                  return Text(list_NFCEs[index]["NomeEmpresarial"]);
                },
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(MdiIcons.barcodeScan),
      ), 
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const []
            ),
          ),
        ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

