import 'package:covid_19_app/Model/WorldStatesModel.dart';
import 'package:covid_19_app/Services/Utilities/states_services.dart';
import 'package:covid_19_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({Key? key}) : super(key: key);

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorsList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices stateServices = StatesServices();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                FutureBuilder(
                  future: stateServices.fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            controller: _controller,
                            color: Colors.white,
                            size: 50.0,
                          ));
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              'Total': snapshot.data!.cases!.toDouble(),
                              'Recovered': snapshot.data!.recovered!.toDouble(),
                              'Deaths': snapshot.data!.deaths!.toDouble(),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              decimalPlaces: 2,
                              chartValueBackgroundColor: Colors.transparent,
                              chartValueStyle: TextStyle(color: Colors.white),
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            colorList: colorsList,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  CustomRow(
                                      title: 'Total Affected',
                                      value: snapshot.data!.cases.toString()),
                                  CustomRow(
                                      title: 'Total Recovered',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  CustomRow(
                                      title: 'Total Deaths',
                                      value: snapshot.data!.deaths.toString()),
                                  CustomRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                  CustomRow(
                                      title: 'Critical',
                                      value:
                                          snapshot.data!.critical.toString()),
                                  CustomRow(
                                      title: 'Today Recovered',
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                  CustomRow(
                                      title: 'Today Deaths',
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CountriesList(),
                                  ));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xff1aa260),
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  )),
                              child: const Center(
                                child: Text('Track Countries'),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  String title, value;

  CustomRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider()
        ],
      ),
    );
  }
}
