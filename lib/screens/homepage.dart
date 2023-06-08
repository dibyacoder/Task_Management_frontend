import 'package:flutter/material.dart';
import 'package:frontend_todo/screens/create_task.dart';
import 'package:frontend_todo/screens/see_desc.dart';
import 'package:frontend_todo/services/api.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Models/task_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    Get.lazyPut(() => Api());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateTask()),
              );
            },
            backgroundColor: Colors.teal,
            child: Icon(Icons.add, size: 30),
          ),
        ),
        backgroundColor: Colors.black,
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Task Management",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Your Tasks..",
                style: TextStyle(
                    color: Color.fromARGB(255, 90, 88, 88),
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 13,
              ),
              Container(
                height: 1,
                width: double.maxFinite,
                color: Colors.white,
              ),
              GetBuilder<Api>(
                builder: (controller) {
                  return controller.isLoaded
                      ? Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.result.length,
                                itemBuilder: (context, index) =>
                                    buildTask(index, controller.result),
                              ),
                            ),
                          ),
                        )
                      : Positioned(
                          left: 0,
                          right: 0,
                          top: 400,
                          bottom: 0,
                          child: Center(
                            child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Color.fromARGB(255, 191, 184, 227),
                              size: 60,
                            ),
                          ),
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTask(int index, result) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            padding: EdgeInsets.all(20),
            height: 65,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: Color.fromARGB(255, 53, 52, 52),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  child: Text(
                    result[index]["title"].toString(),
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => see_desc(index: index),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Api.deletetask(index.toString());

                          result.removeAt(index);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
