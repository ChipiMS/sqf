import 'package:flutter/material.dart';
import 'package:sqf_lite/database_helper.dart';

class Cliente extends StatefulWidget{
  final cliente;
  Cliente({Key key, @required this.cliente}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClienteState();
  }
}

class ClienteState extends State<Cliente>{
  final DBHelper = DataBaseHelper.instancia;
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  void agregarCliente() async{
    Map<String,dynamic> row = {
      'nomCliente': nameController.text,
      'edadCliente': ageController.text
    };

    nameController.text = '';
    ageController.text = '';

    final id = await DBHelper.insertar(row);
    print('Registro Insertado id: $id');
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: "Introduce el nombre",
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))
          ),
          controller: nameController,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Introduce el nombre",
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))
          ),
          controller: ageController,
        ),
        RaisedButton(
          onPressed: (){
            agregarCliente();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
          ),
          padding: EdgeInsets.all(12),
          color: Colors.green,
          child: Text("Agregar",
            style: TextStyle(
              color: Colors.white
            ),
          ),
        )
      ],
    );
  }
}