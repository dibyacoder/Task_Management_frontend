import 'package:flutter/material.dart';
import 'package:frontend_todo/screens/homepage.dart';
import 'package:frontend_todo/services/api.dart';
import 'package:get/get.dart';

class see_desc extends StatefulWidget {
  final int index;
  const see_desc({Key? key, required this.index}) : super(key: key);

  @override
  State<see_desc> createState() => _see_descState();
}

class _see_descState extends State<see_desc> {
  late String title;
  late String description;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Set initial values for the text form fields
    titleController.text =
        Get.find<Api>().result[widget.index]["title"].toString();
    descriptionController.text =
        Get.find<Api>().result[widget.index]["description"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      controller: titleController,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      onChanged: (value) => title = value,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: descriptionController,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                      onChanged: (value) => description = value,
                      maxLines: null, // Allow multiline input
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            color: Colors.black,
            child: GetBuilder<Api>(
              builder: (controller) {
                return Container(
                  height: 60,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 25 * 3,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Api().updatetask(widget.index.toString(), {
                              "title": titleController.text,
                              "desc": descriptionController.text,
                              "id": widget.index.toString()
                            });
                            Get.snackbar("Update", "Your Task is updated");
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 90, 88, 88),
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )),
      ),
    );
  }
}
