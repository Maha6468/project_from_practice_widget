import 'package:flutter/material.dart';
import 'package:project_from_practice_widget/notice/nCustom/cus_AppBar.dart';
import 'package:project_from_practice_widget/notice/nCustom/cus_TextfromField.dart';

class MScaffold extends StatefulWidget {
  const MScaffold({super.key});

  @override
  State<MScaffold> createState() => _MScaffoldState();
}

class _MScaffoldState extends State<MScaffold> {
  final _formKey=GlobalKey<FormState>();
  final TextEditingController nameController=TextEditingController();
  final TextEditingController batchController=TextEditingController();

  @override
  void dispose(){
    nameController.dispose();
    batchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 CustomFromField(
                   label: "Enter your name",
                   hint: "Name",
                   controller: nameController,
                   validator: (value){
                     if(value==null||value.isEmpty){
                       return "Name cannot be empty";
                     }
                     return null;
                   },),
                  SizedBox(height: 10,),
                  CustomFromField(
                    label: "Enter your batch",
                    hint: "Batch",
                    controller: batchController,
                    validator: (value){
                    if(value==null||value.isEmpty){
                      return "Name cannot be empty";
                    }
                    return null;
                  },),
                  SizedBox(height: 2),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print("Name: ${nameController.text}");
                        print("Batch: ${batchController.text}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Form submitted successfully!")),
                        );
                      }
                    },
                    child: Text("Submit"),
                  ),
                ],
          ),
        ),
      ),
    );
  }
}
