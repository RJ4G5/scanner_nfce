

import 'package:flutter/material.dart';


import '../../global.dart';


class CardItensMaisComprados extends StatelessWidget{
  
  List<dynamic> grupo;
  CardItensMaisComprados(this.grupo, {super.key});

  @override
  Widget build(BuildContext context) {
    logger.d(grupo);
    return Text("data");
  }

}