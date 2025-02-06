import 'package:cnattendance/data/source/network/model/trainingresponse/trainingresponse.dart';
import 'package:cnattendance/screen/traning/trainingdetailcontroller.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';

class TrainingDetailScreen extends StatelessWidget {
  final model = Get.put(TrainingDetailController());
  final trainingStatus = "In Progress";

  @override
  Widget build(BuildContext context) {
    final training = Get.arguments["training"] as Training;
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text("Training Detail"),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        training.trainingType,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Card(
                          margin: EdgeInsets.zero,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                Text(
                                  " Date: ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  training.startDate,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                                if (training.endDate.isNotEmpty)
                                  Text(
                                    " - ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                if (training.endDate.isNotEmpty)
                                  Text(
                                    training.endDate,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Card(
                          margin: EdgeInsets.zero,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 3),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timelapse,
                                  color: Colors.black,
                                  size: 18,
                                ),
                                Text(
                                  " Time: ",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "${training.startTime} - ${training.endTime.isEmpty ? "TBD" : training.endTime}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Description",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ReadMoreText(
                      training.description,
                      trimLines: 15,
                      colorClickableText: Colors.blue,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      lessStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      moreStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      "Trainer(s)",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "Expertise",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Card(
                  elevation: 0,
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 3.0, vertical: 8),
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: training.trainer.map(
                              (e) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${e.name ?? ''}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Text(
                                  "${e.expertise ?? ''}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            );
                          },
                        ).toList()),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Participant(s)",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Card(
                  elevation: 0,
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 3.0, vertical: 8),
                    child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: training.employees.map(
                              (e) {
                            return Row(
                              children: [
                                Text(
                                  "${e.name ?? ''}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            );
                          },
                        ).toList()),
                  ),
                ),
                if (training.certificate.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Certificate",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          /*Spacer(),
                        GestureDetector(
                            onTap: () async {
                              final value = await model
                                  .checkAndRequestStoragePermission();

                              if (value) {
                                model.saveFileLocally(training.certificate);
                              }
                              print(value);
                            },
                            child: Icon(
                              Icons.download,
                              color: Colors.white,
                            ))*/
                        ],
                      ),
                      if (training.certificate.isNotEmpty)
                        SizedBox(
                          height: 10,
                        ),
                      if (training.certificate.isNotEmpty)
                        Image.network(
                          training.certificate,
                          height: 300,
                        ),
                    ],
                  ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
