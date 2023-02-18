import 'package:covid_19_app/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailResults extends StatefulWidget {
  String name, image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayDeaths,
      todayRecovered;

  DetailResults({
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayDeaths,
    required this.todayRecovered,
  });

  @override
  State<DetailResults> createState() => _DetailResultsState();
}

class _DetailResultsState extends State<DetailResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.067),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          CustomRow(
                              title: 'Total Affected',
                              value: widget.totalCases.toString()),
                          CustomRow(
                              title: 'Total Recovered',
                              value: widget.totalRecovered.toString()),
                          CustomRow(
                              title: 'Total Deaths',
                              value: widget.todayDeaths.toString()),
                          CustomRow(
                              title: 'Total Active',
                              value: widget.active.toString()),
                          CustomRow(
                              title: 'Total Critical',
                              value: widget.critical.toString()),
                          CustomRow(
                              title: 'Today Recovered',
                              value: widget.totalRecovered.toString()),
                          CustomRow(
                              title: 'Today Deaths',
                              value: widget.todayDeaths.toString()),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image.toString()),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// children: [
// CustomRow(
// title: 'Total Affected',
// value: widget.totalCases.toString()),
// CustomRow(
// title: 'Total Recovered',
// value: widget.totalRecovered.toString()),
// CustomRow(
// title: 'Total Deaths',
// value: widget.todayDeaths.toString()),
// CustomRow(
// title: 'Total Active', value: widget.active.toString()),
// CustomRow(
// title: 'Total Critical', value: widget.critical.toString()),
// CustomRow(
// title: 'Today Recovered',
// value: widget.totalRecovered.toString()),
// CustomRow(
// title: 'Today Deaths',
// value: widget.todayDeaths.toString()),
// ],
