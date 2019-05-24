import 'package:flutter/material.dart';
import 'package:sqf_lite/menu.dart';
import 'package:sqf_lite/database_helper.dart';

class List extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Dashboard",
      home: MenuLateral(),
    );
  }
}

class MenuLateral extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MenuLateralState();
  }
}

class MenuLateralState extends State<MenuLateral>{
  var clientes;
  final DBHelper = DataBaseHelper.instancia;

  void load() async{
    clientes = await DBHelper.listarTodos();
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Clientes"),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          children: Menu.build(context, load),
        ),
      ),
      body: clientes == null ?
      Center(
        child: CircularProgressIndicator()
      ) : ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Text("${clientes[index]["nomCliente"]}:${clientes[index]["edadCliente"]}")
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
          );
        }
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }
}