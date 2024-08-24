import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'list_user_logic.dart';

class ListUserPage extends StatelessWidget {
  const ListUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListUserLogic>(builder: (logic) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            logic.addUser();
          },
          label: const Text("Add User"),
          icon: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Users List"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 4.0),
                    child: GestureDetector(
                      onLongPress: () {
                        logic.showDialogs(logic.user[index]);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      logic.user[index].userData?.fullName ??
                                          "-",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    logic.user[index].userData?.contact ?? "-",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: (logic.user[index].userData
                                                                ?.position ??
                                                            "-")
                                                        .toLowerCase() ==
                                                    "admin"
                                                ? Colors.green.shade100
                                                : Colors.red.shade100,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(12))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          child: Text(
                                            logic.user[index].userData
                                                    ?.position ??
                                                "-",
                                            style: TextStyle(
                                              color: (logic.user[index].userData
                                                                  ?.position ??
                                                              "-")
                                                          .toLowerCase() ==
                                                      "admin"
                                                  ? Colors.green.shade900
                                                  : Colors.red.shade900,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: logic.user.length,
              ),
            ),
          ],
        ),
      );
    });
  }
}
