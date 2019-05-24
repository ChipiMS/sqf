import 'package:flutter/material.dart';
import 'package:sqf_lite/cliente.dart';
class Menu{
  static build(BuildContext context, callback){
    return <Widget>[
      ListTile(
        title: Text("Agregar"),
        trailing: Icon(Icons.account_box),
        onTap: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              // return object of type Dialog
              return AlertDialog(
                title: new Text("Categorias favoritas"),
                content: Cliente(
                  cliente: {}
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Terminar"),
                    onPressed: () {
                      callback();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
          );
        },
      )
    ];
  }
}
