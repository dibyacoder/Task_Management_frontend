import 'package:flutter/material.dart';
import 'package:frontend_todo/screens/homepage.dart';
import 'package:frontend_todo/services/api.dart';
import 'package:get/get.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({Key? key}) : super(key: key);

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  late String title;
  late String description;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
                        fontSize: 20, // Increased font size
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
                            var data = {
                              "title": titleController.text,
                              "desc": descriptionController.text
                            };
                            Api.addtask(data).then((value) async {
                              await controller.gettask();
                            });
                            Get.snackbar("Add", "Your Task is Added");
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(
                                255, 90, 88, 88), // Change button colorMo
                            onPrimary: Colors.white, // Change text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Add border radius
                            ),
                          ),
                          child: const Text(
                            'Add',
                            style: TextStyle(
                                fontWeight: FontWeight.bold), // Make text bold
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
