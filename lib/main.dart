import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


import 'DB/DB_NFCEs.dart';
import 'Views/card_nfce/card_itens_mais_comprados.dart';
import 'Views/scan_nfce/ViewScan.dart';
import 'Views/card_nfce/card_nfce.dart';
import 'global.dart' as global;


// ignore
// ignore: prefer_const_constructors
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scanner NFC-e',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  List<Map<String, dynamic>> list_NFCEs = [ ];
  List<dynamic> list_MaisFrequentes = [ ];
  final GlobalKey<AnimatedListState> list_NFCEs_Key = GlobalKey<AnimatedListState>();
  ScrollController list_NFCEs_ScrollController = ScrollController(initialScrollOffset: 0,);

  bool empty_nfce = false;
  bool empty_MaisFrequentes = false;


  DB_NFCEs db_nfcEs = DB_NFCEs();


  void addCardNFCE(Map<String, dynamic> cardNFCE){
      
        list_NFCEs_ScrollController.animateTo(list_NFCEs_ScrollController.position.maxScrollExtent,duration: Duration(milliseconds: 200), curve: Curves.ease);      
     
      
      
      
      Timer(Duration(milliseconds: 300), (){
         //list_NFCEs.add(cardNFCE);   
         
         
         list_NFCEs.insert(0,cardNFCE);
         list_NFCEs_Key.currentState?.insertItem(0);
         ListViewMaisFreguentes();
          setState(() {});
      });
      
  }
   openViewScan() {
    setState(() {
      //list_NFCEs_Key.currentContext.
       Navigator.of(context).push(MaterialPageRoute( builder: (context) =>  const ViewScan(), ));
    });
  }

  
  
  
  void listNFCEs() async{
    //log.d("listAllNFCEs");
      final _this = this;

      db_nfcEs.getNFCEs().then((docs) {
        
          if(docs != null){
              empty_nfce = false;
              list_NFCEs.clear();
              int index = 0;
              final reverseDocs = LinkedHashMap.fromEntries(docs.entries.toList().reversed);
              reverseDocs.forEach((key, _nfce) {           
                  list_NFCEs.add(_nfce);
                  list_NFCEs_Key.currentState?.insertItem(index);            
                  index +=1;
              });
            
                  // _this.maisFrequentes(todosProdutos);
              
              setState(() {});
        }else{
          empty_nfce = true;
          setState(() {});
        }
          
          

      });   

      
  }

  ListViewMaisFreguentes(){
    db_nfcEs.FrequentesPorEmpresa().then((grupos){

        list_MaisFrequentes  = grupos;
        
         setState(() {
            if(grupos.length > 0)
              empty_MaisFrequentes = false;
            else
              empty_MaisFrequentes = true;
         });
        
    }); 
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listNFCEs();
    ListViewMaisFreguentes();

  
    
  }

  @override
  Widget build(BuildContext context) {

    global.homeState = this;
    
    

    return DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: AppBar(
                        
                        //toolbarHeight: 60,
                        title: Text("Scanner NFC-e"),
                        backgroundColor: Color(0xff607D8B),
                        bottom: TabBar(

                          indicator: BoxDecoration(

                              borderRadius: BorderRadius.circular(5), // Creates border
                              color: Color.fromARGB(43, 255, 255, 255),

                          ),
                         
                          tabs: [ 
                                                        
                            Tab(text: 'NFCEs',),                          
                            Tab(text: 'Mais comprados',),                            
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: [
                          // ! list view nfces
                            empty_nfce ?
                            // ! empty?
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              child: Column(
                                children: [
                                  Text("Você ainda não escaneou nenhuma nota!", style: TextStyle(color: Color(0xff546E7A), fontWeight: FontWeight.bold, fontSize: 18 ),),
                                  Image.asset("assets/scan.gif")
                                ],
                              ),

                            )

                            : // ! else

                            AnimatedList(
                                controller: list_NFCEs_ScrollController,
                                key: list_NFCEs_Key,


                                initialItemCount:list_NFCEs.length ,
                                itemBuilder: (context, index, animation) {
                                    
                                    return SizeTransition(
                                      sizeFactor: animation,
                                      child: CardNFCE(list_NFCEs[index],index),
                                    );
                              }

                            ),
                            //! list view mais comprados

                            empty_MaisFrequentes ?
                            // ! empty?
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              child: Column(
                                children: [
                                  Text("Dados insuficientes para gerar relatório!", style: TextStyle(color: Color(0xff546E7A), fontWeight: FontWeight.bold, fontSize: 18 ),),
                                  Image.asset("assets/empty-cart.png")
                                ],
                              ),

                            )

                            : // ! else
                            ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: list_MaisFrequentes.length,
                              itemBuilder: (BuildContext context, int index) {
                               
                                return CardItensMaisComprados(list_MaisFrequentes[index]);
                              }
                            ),
                      
                        ],
                      ),

                        floatingActionButton: FloatingActionButton(
                            onPressed: openViewScan,
                            backgroundColor: Color(0xff455A64),
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
                        )
                    ),
                  );
    
  }
}

