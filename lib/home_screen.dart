import 'dart:io';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:screenshot/screenshot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? fileByte;
  double borderWidth = 10;
  double circleSize = 100;
  Color borderColor = Colors.black;
  ScreenshotController screenshotController = ScreenshotController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Flutter Farsi",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          height: circleSize,
                          width: circleSize,
                          decoration: BoxDecoration(
                            image: fileByte == null
                                ? null
                                : DecorationImage(
                                    image: MemoryImage(fileByte!),
                                    fit: BoxFit.cover,
                                  ),
                            shape: BoxShape.circle,
                        
                            border: Border.all(
                                color: borderColor, width: borderWidth),
                          ),
                          alignment: Alignment.center,
                          child:  fileByte != null
                              ? null
                              :Icon(Icons.person,size: 50,),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: Colors.purpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              fileByte = result.files.first.bytes;
                            } else {
                              // User canceled the picker
                            }
                            setState(() {});
                          },
                          child: const Text(
                            "Pick Image",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      // ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //       fixedSize: const Size(200, 50),
                      //       backgroundColor: Colors.purpleAccent,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //     onPressed: ()  {
                      //       screenshotController.capture();
                      //     },
                      //     child: const Text(
                      //       "Save Profile",
                      //       style: TextStyle(fontSize: 20, color: Colors.white),
                      //     )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Border",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              useSafeArea: true,
                              barrierDismissible: true,
                              builder: (context) {
                                return AlertDialog(
                                  alignment: Alignment.center,
                                  scrollable: false,
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ColorPicker(
                                        pickerColor: Colors.red,
                                        onColorChanged: (value) {
                                          borderColor = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(200, 50),
                                            backgroundColor:
                                                Colors.purpleAccent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: const Text(
                                            "Submit",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            color: borderColor,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 5,
                          child: Slider(
                            max: 50,
                            min: 0,
                            value: borderWidth,
                            onChanged: (value) {
                              setState(() {
                                borderWidth = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Circle Size",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 5,
                          child: Slider(
                            max: 300,
                            min: 0,
                            value: circleSize,
                            onChanged: (value) {
                              setState(() {
                                circleSize = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
