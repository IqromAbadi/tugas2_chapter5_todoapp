import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import '../utils/DbHelper.dart';
import '../views/homePage.dart';

class TodoList extends StatelessWidget {
  final Function deleteFunction;
  final Function isChecked;

  var db = DbHelper();
  TodoList({
    required this.deleteFunction,
    required this.isChecked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: db.queryAllRows(),
        builder: ((context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            var dataLength = data!.length;
            return dataLength == 0
                ? Center(
                    child: Text("No Data Found"),
                  )
                : ListView.builder(
                    itemCount: dataLength,
                    itemBuilder: (context, i) => Homepage(
                      id: data[i].id,
                      judul: data[i].judul,
                      deskripsi: data[i].deskripsi,
                      isDone: data[i].isDone,
                      deleteFunction: deleteFunction,
                      isChecked: isChecked,
                    ),
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text("No Data Found Error"),
            );
          }
        }),
      ),
    );
  }
}
