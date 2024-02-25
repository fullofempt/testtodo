import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void someFunction() {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Testbd');

  // To reference a document within the collection, use the doc() method
  DocumentReference documentReference = collectionReference.doc('todo');

  // DocumentReference DataReference =
  //     collectionReference.data('setData');

  documentReference.get().then((DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      // Document exists, you can access its data using snapshot.data()
      var data = snapshot.data();
      print(data);
    } else {
      // Document doesn't exist
      print('Document does not exist');
    }
  }).catchError((error) {
    // Handle errors
    print('Error getting document: $error');
  });
}

class AddTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addtasktofirebase() async {
    var time = DateTime.now();
    await FirebaseFirestore.instance.collection('Задача').doc(time.toString()).set({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'timestamp': time
    });
    Fluttertoast.showToast(msg: 'Data Added');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Новая задача')),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      labelText: 'Ввод', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      labelText: 'Введите описание',
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 10),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor:
                        MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.purple.shade100;
                      return Theme.of(context).primaryColor;
                    })),
                    child: Text(
                      'Добавить задачу',
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                    onPressed: () {
                      addtasktofirebase();
                    },
                  ))
            ],
          )),
    );
  }
}
