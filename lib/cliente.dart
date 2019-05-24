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
  bool finished = false;
  final DBHelper = DataBaseHelper.instancia;
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

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

  void actualizarCliente() async{
    Map<String, dynamic> row = {
      'idCliente' : widget.cliente["idCliente"],
      'nomCliente': nameController.text,
      'edadCliente': ageController.text
    };
    final rowsAffected = await DBHelper.actualizar(row);
    print('Se actualizaron $rowsAffected registros');
  }
  @override
  Widget build(BuildContext context) {
    if(finished){
      if(widget.cliente["idCliente"] != null)
        return Text("Cliente actualizado");
      return Text("Cliente agregado");
    }
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
            hintText: "Introduce la edad",
            contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32))
          ),
          controller: ageController,
        ),
        RaisedButton(
          onPressed: (){
            if(ageController.text.length > 0 && nameController.text.length > 0) {
              if(widget.cliente["idCliente"] != null){
                actualizarCliente();
              }
              else{
                agregarCliente();
              }
              finished = true;
              setState(() {});
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
          ),
          padding: EdgeInsets.all(12),
          color: Colors.green,
          child: Text((widget.cliente["idCliente"] != null ? "Actualizar" : "Agregar"),
            style: TextStyle(
              color: Colors.white
            ),
          ),
        )
      ],
    );
  }
  @override
  void initState() {
    super.initState();
    if(widget.cliente["idCliente"] != null){
      nameController.text = widget.cliente["nomCliente"];
      ageController.text = "${widget.cliente["edadCliente"]}";
    }
  }
}