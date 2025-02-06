import 'package:cnattendance/model/event.dart';
import 'package:cnattendance/screen/eventscreen/eventlistcontroller.dart';
import 'package:cnattendance/widget/buttonborder.dart';
import 'package:cnattendance/widget/radialDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get/get.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  EventDetailScreen(this.event);

  @override
  Widget build(BuildContext context) {
    final model = Get.put(EventListController());
    return Container(
      decoration: RadialDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (event.image.isNotEmpty)
                    ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          event.image,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
                  if (event.image.isNotEmpty)
                    SizedBox(
                      height: 10,
                    ),
                  Text(
                    event.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Text(
                        translate('common.location'),
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      Spacer(),
                      Text(
                        event.location,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        translate('common.event_date'),
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      Spacer(),
                      Text(
                        event.startdate +
                            (event.endDate.isEmpty ? "" : " - ") +
                            (event.endDate.isEmpty ? "" : event.endDate),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        translate('common.event_time'),
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                      Spacer(),
                      Text(
                        event.startTime +
                            (event.endTime.isEmpty ? "" : " - ") +
                            (event.endTime.isEmpty ? "" : event.endTime),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Text(
                          translate('common.host'),
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                        Spacer(),
                        Text(
                          event.creator.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    translate('common.event_description'),
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    shape: ButtonBorder(),
                    elevation: 0,
                    color: Colors.white12,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        event.description,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
