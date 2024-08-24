import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import '../app_managers/assets_managers.dart';

class CostumeDialogWithCross extends StatelessWidget {
  final String message;
  final bool cancelable;
  final String title;
  final String image;
  final String status;
  final VoidCallback? onButton1Clicked;
  final VoidCallback? onButton2Clicked;
  final bool button2Enabled;
  final String buttom1Lavel;
  final String buttom2Lavel;
  final Color titleColor;

  const CostumeDialogWithCross({
    super.key,
    this.message = "Process Successfully Completed",
    this.title = 'Success',
    this.image = AssetManager.appLogo,
    this.status = 'Success',
    this.titleColor = const Color.fromARGB(255, 5, 119, 43),
    this.cancelable = false,
    this.button2Enabled = false,
    this.onButton1Clicked,
    this.onButton2Clicked,
    this.buttom1Lavel = 'OK',
    this.buttom2Lavel = 'Retry',
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                if (cancelable) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(children: [
                  Positioned(
                      right: 6,
                      top: 6,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(32))),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ))),
                  Padding(
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: titleColor),
                        ),
                        const Gap(32),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 12),
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (onButton1Clicked) != null
                                  ? () {
                                      Navigator.pop(context);
                                      onButton1Clicked!();
                                    }
                                  : () {
                                      Navigator.pop(context);
                                    },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0)),
                                  backgroundColor: const Color(0xFF892BA2)),
                              child: Padding(
                                padding: const EdgeInsets.all(14),
                                child: Text(
                                  buttom1Lavel,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFF0D1FA)),
                                ),
                              )),
                        ),
                        const Gap(12),
                        Visibility(
                          visible: button2Enabled,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: (onButton2Clicked) != null
                                    ? () {
                                        Navigator.pop(context);
                                        onButton2Clicked!();
                                      }
                                    : () {
                                        Navigator.pop(context);
                                      },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0)),
                                  backgroundColor:
                                      const Color.fromARGB(255, 219, 223, 170),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: Text(
                                    buttom2Lavel,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
