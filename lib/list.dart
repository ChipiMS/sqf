import 'package:flutter/material.dart';
import 'package:sqf_lite/menu.dart';
import 'package:sqf_lite/database_helper.dart';
import 'package:sqf_lite/cliente.dart';

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

  deleteClient(id) async{
    final rowsDeleted = await DBHelper.eliminar(id);
    print('Se borró el registro $id');
    load();
  }

  editClient(client){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Actualizar cliente"),
          content: Cliente(
            cliente: client
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Terminar"),
              onPressed: () {
                load();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
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
                  Text("${clientes[index]["nomCliente"]}:${clientes[index]["edadCliente"]}"),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editClient(clientes[index]);
                        }
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteClient(clientes[index]["idCliente"]);
                        }
                      )
                    ]
                  )
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