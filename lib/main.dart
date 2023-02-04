import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:localstore/localstore.dart';
import 'ViewScan.dart';
import 'Views/card_nfce/card_nfce.dart';
import 'global.dart' as global;
import 'package:moment_dart/moment_dart.dart';
import 'package:ticketview/ticketview.dart';
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

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {


  final db = Localstore.instance;
  List<Map<String, dynamic>> list_NFCEs = [ ];
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();


  void addCardNFCE(Map<String, dynamic> cardNFCE){

      Timer(Duration(milliseconds: 200), (){
         //list_NFCEs.add(cardNFCE);    
         list_NFCEs.insert(0,cardNFCE);
         listKey.currentState?.insertItem(0);
          setState(() {});
      });
      
  }
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
         int index = 0;
         final reverseDocs = LinkedHashMap.fromEntries(docs.entries.toList().reversed);
         reverseDocs.forEach((key, value) {           
            list_NFCEs.add(value);
            listKey.currentState?.insertItem(index);
            index +=1;
         });
      
         
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

    global.homeState = this;
    
    

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:  Container(
          
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
                  child:DefaultTabController(
                    length: 3,
                    child: Scaffold(
                      appBar: AppBar(
                        toolbarHeight: 60,
                        
                        backgroundColor: Color(0xff607D8B),
                        title: TabBar(
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50), // Creates border
                              color: Color.fromARGB(43, 255, 255, 255),
                          ),
                         
                          tabs: [                             
                            Tab(text: 'Compras',),                          
                            Tab(text: 'Mais comprados',),                            
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: [
                            AnimatedList(
                                key: listKey,

                                initialItemCount:list_NFCEs.length ,
                              itemBuilder: (context, index, animation) {
                                int reverseIndex = list_NFCEs.length - 1 - index;
                              // print("reverse: $reverseIndex");
                                
                                return SizeTransition(
                                  
                                  sizeFactor: animation,
                                  child: CardNFCE(list_NFCEs[index],index),
                                );
                                
                                
                                
                              }

                            ),
                            Center(child: Text('CATS')),
                      
                        ],
                      ),
                    ),
                  ),
                  
                  
                
                  
                  
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

