import 'package:covid_19_app/Services/Utilities/states_services.dart';
import 'package:covid_19_app/View/detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList>
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

  @override
  Widget build(BuildContext context) {
    StatesList statesList = StatesList();
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: statesList.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50,
                    controller: _controller,
                  ));
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var fetch = snapshot.data![index];
                        return Column(
                          children: [
                            ListTile(
                              leading: Image(
                                width: 50,
                                height: 50,
                                image: NetworkImage(
                                  snapshot.data![index]['countryInfo']['flag'],
                                ),
                              ),
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailResults(
                                        name: fetch['country'],
                                        image: fetch['countryInfo']['flag'],
                                        totalCases: fetch['cases'],
                                        totalDeaths: fetch['deaths'],
                                        totalRecovered: fetch['recovered'],
                                        active: fetch['active'],
                                        critical: fetch['critical'],
                                        todayDeaths: fetch['todayDeaths'],
                                        todayRecovered: fetch['todayRecovered'],
                                      ),
                                    ));
                              },
                            )
                          ],
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  CustomTextField({Key? key, required this.controller, this.onChange})
      : super(key: key);
  TextEditingController controller;
  final onChange;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: (value) {
        setState(() {});
      },
      onSaved: (newValue) => setState(() {
        print(widget.controller.text.toString());
      }),
      // onChanged: (value) => setState(() {}),
      // toolbarOptions: const ToolbarOptions(
      //     selectAll: true, cut: true, paste: true, copy: true),
      // decoration: InputDecoration(
      //   hintText: 'Search countries by name',
      //   prefixIcon: const Icon(
      //     Icons.search,
      //     color: Colors.grey,
      //   ),
      //   enabledBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(100),
      //       borderSide: const BorderSide(color: Colors.white)),
      //   focusedBorder: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(100),
      //       borderSide: const BorderSide(color: Colors.white, width: 2)),
      // ),
    );
  }
}

// return Shimmer.fromColors(
// baseColor: Colors.grey.shade700,
// highlightColor: Colors.grey.shade100,
// child: ListTile(
// leading: Container(
// width: 50,
// height: 50,
// color: Colors.white,
// ),
// title: Container(
// width: 89,
// height: 10,
// color: Colors.white,
// ),
// subtitle: Container(
// width: 89,
// height: 10,
// color: Colors.white,
// ),
// ),
// );
