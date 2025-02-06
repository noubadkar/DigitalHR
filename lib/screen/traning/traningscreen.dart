import 'package:cnattendance/provider/prefprovider.dart';
import 'package:cnattendance/screen/traning/trainingdetailcontroller.dart';
import 'package:cnattendance/screen/traning/trainingdetailsscreen.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class TrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Get.put(TrainingDetailController());
    final userId = context.watch<PrefProvider>().userId;
    return FocusDetector(
      onFocusGained: () {
        model.upcomingPage = 1;
        model.pastPage = 1;
        model.getTrainings(true);
        model.getTrainings(false);
      },
      child: Container(
        decoration: RadialDecoration(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text("Trainings"),
          ),
          body: RefreshIndicator(
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            color: Colors.white,
            backgroundColor: Colors.blueGrey,
            edgeOffset: 50,
            onRefresh: () {
              return model
                  .getTrainings(model.toggleValue.value == 0 ? true : false);
            },
            child: SafeArea(
                child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    Center(
                      child: Obx(
                        () => ToggleSwitch(
                          activeBgColor: [Colors.white12],
                          activeFgColor: Colors.white,
                          inactiveFgColor: Colors.white,
                          inactiveBgColor: Colors.transparent,
                          minWidth: 100,
                          minHeight: 45,
                          initialLabelIndex: model.toggleValue.value,
                          totalSwitches: 2,
                          onToggle: (index) {
                            model.toggleValue.value = index!;
                          },
                          labels: [
                            translate('holiday_screen.upcoming'),
                            translate('holiday_screen.past')
                          ],
                        ),
                      ),
                    ),
                    allTrainings(model, userId)
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }

  Widget allTrainings(TrainingDetailController model, String userId) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: model.toggleValue == 0
              ? model.upcomingTrainingList.length
              : model.pastTrainingList.length,
          itemBuilder: (context, index) {
            final training = model.toggleValue == 0
                ? model.upcomingTrainingList[index]
                : model.pastTrainingList[index];
            return GestureDetector(
              onTap: () {
                Get.to(TrainingDetailScreen(),
                    arguments: {"training": training});
              },
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                color: Colors.white12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          color: Colors.white12,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5),
                            child: Text(
                              (training.trainer.where(
                                (element) =>
                                    element.user_id.toString() == userId,
                              )).isEmpty
                                  ? "Participant"
                                  : "Trainer",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.model_training,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(training.trainingType,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        height: 1.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 15,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(training.startDate,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                              SizedBox(
                                width: 5,
                              ),
                              Text("-",
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.calendar_month,
                                size: 15,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(training.endDate,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timelapse,
                                size: 15,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(training.startTime,
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                              if (training.endTime.isNotEmpty)
                                Text("  -  ",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12)),
                              if (training.endTime.isNotEmpty)
                                Icon(
                                  Icons.timelapse,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              if (training.endTime.isNotEmpty)
                                SizedBox(
                                  width: 5,
                                ),
                              if (training.endTime.isNotEmpty)
                                Text(training.endTime,
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
