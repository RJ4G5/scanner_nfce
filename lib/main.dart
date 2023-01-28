import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:localstore/localstore.dart';
import 'ViewScan.dart';
import 'global.dart' as global;
import 'package:moment_dart/moment_dart.dart';
// ignore
// ignore: prefer_const_constructors
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyData with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
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
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  int _counter = 0;
  final db = Localstore.instance;
   List<Map<String, dynamic>> list_NFCEs = [ ];

  void incrementCounter() {
    setState(() {

       Navigator.of(context,rootNavigator:true).push(MaterialPageRoute( builder: (context) =>  const ViewScan(), ));
    });
  }

  void listAllNFCEs() async{
    log.d("listAllNFCEs");
   

     
      db.collection('NFCEs').get().then((docs) {
        if(docs != null){
         list_NFCEs.clear();
         docs.forEach((key, value) {list_NFCEs.add(value);});
         setState(() {});
        }
     
          

      });
    
    
  }
  formatDate (String date){

    int ano = int.parse(date.split("/")[2]);
    int mes= int.parse(date.split("/")[1]);
    int dia= int.parse(date.split("/")[0]);
    return DateTime(ano,mes,dia).toMoment().format('DD MMM');
    
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listAllNFCEs();
  }

  @override
  Widget build(BuildContext context) {

    global.homeState = this;

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
                
                  return Container(
                    height: 100,
                    margin: EdgeInsets.only(left: 10, right: 10,top: 5),
              
                   
                    
                    child: Row(
                      children: [
                        // ! Data da nota
                        Container(
                          height: double.infinity,
                          width: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:  [
                              Text(
                                list_NFCEs[index]['hora'].substring(0, list_NFCEs[index]['hora'].length - 3),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF455A64),
                                  fontSize: 13
                                ),
                              ),
                              Text(                                
                                formatDate(list_NFCEs[index]['data']),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF455A64),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),

                        ),
                        Expanded(
                          // ! preview da nota
                          child: Container(
                            
                            padding: EdgeInsets.only(left: 10,top: 5),
                            // ignore: prefer_const_constructors
                            decoration: BoxDecoration(
                                
                                gradient: LinearGradient(
                                    stops: const [0.02, 0.02],
                                    colors: const [Colors.red, Colors.white]
                                ),

                                borderRadius: BorderRadius.all( Radius.circular(10)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(10, 0, 0, 0),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                  // changes position of shadow
                                  ),
                                  
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  
                                  Text(
                                    list_NFCEs[index]['NomeEmpresarial'],
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,

                                    style: TextStyle(
                                      color: Color(0xFF455A64),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ]
                              ),

                          )
                        )
                        
                      ]
                    ),

                  );
                  
                  
                  
                },
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: incrementCounter,
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

