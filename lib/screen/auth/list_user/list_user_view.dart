import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/app_managers/assets_managers.dart';
import 'list_user_logic.dart';

class ListUserPage extends StatelessWidget {
  const ListUserPage({super.key});

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
            logic.isLoading
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Expanded(
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
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Image.network(
                                          logic.user[index].userData?.userPhoto ??
                                              "-",
                                          width: 60,
                                          height: 60,
                                          errorBuilder: (context, _, __) {
                                            return Image.asset(
                                              AssetManager.userLogo,
                                              width: 60,
                                            );
                                          },
                                        ),
                                      ),
                                      const Gap(12),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                logic.user[index].userData
                                                        ?.fullName ??
                                                    "-",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              logic.user[index].userData
                                                      ?.contact ??
                                                  "-",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Row(
                                              children: [
                                                const Spacer(),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: (logic
                                                                          .user[
                                                                              index]
                                                                          .userData
                                                                          ?.position ??
                                                                      "-")
                                                                  .toLowerCase() ==
                                                              "admin"
                                                          ? Colors
                                                              .green.shade100
                                                          : Colors.red.shade100,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  12))),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                    child: Text(
                                                      logic.user[index].userData
                                                              ?.position ??
                                                          "-",
                                                      style: TextStyle(
                                                        color: (logic
                                                                            .user[
                                                                                index]
                                                                            .userData
                                                                            ?.position ??
                                                                        "-")
                                                                    .toLowerCase() ==
                                                                "admin"
                                                            ? Colors
                                                                .green.shade900
                                                            : Colors
                                                                .red.shade900,
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
                                    ],
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
