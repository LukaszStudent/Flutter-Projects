import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:test2/Pages/interface.dart';
import 'package:test2/Pages/wybor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test2/main.dart';

List<FlSpot> spotWeightList = [];
List<double> elevationList = <double>[]; // lista przechowujaca wysokosci
double largestGeekValue=0.0;
double smallestGeekValue=0.0;
List<double> latitudeList =
    <double>[]; // lista przechowujaca szerkosc geograficzna
List<double> longitudeList =
    <double>[]; // lista przechowujaca dlugosc geograficzna

Set<Marker> _markers = {}; // markery
  Completer<GoogleMapController> _controller = Completer();
  late BitmapDescriptor mapMarker;
  Set<Polyline> _polyline = {}; // linie
  Set<Polygon> _polygon = {};

  List<LatLng> PointsList = <LatLng>[];

  var middlePosition = LatLng(0.0, 0.0);

void setLatLong(List<double> latList, List<double> longList) {
  latitudeList = latList;
  longitudeList = longList;
  latitudeList = latList;
  longitudeList = longList;
  getMiddlePosition(latitudeList, longitudeList);
  PointsList.clear();
  setPoints(PointsList, latitudeList, longitudeList);
  print("latlong WYKRESY latitude $latitudeList");
  print("latlong WYKRESY longitude $longitudeList");
}

void set_wysokosci(List<double> elvList) {
  // funkcja ustawiajaca liste wysoskosci
  elevationList = elvList;
  print("elevation WYKRESY: $elevationList");
  print(elevationList.length);
  spotWeightList.clear();
  for (var i = 0; i < elevationList.length; i++) {
    spotWeightList.add(FlSpot((i * 1.0), elevationList[i]));
    if (elevationList[i] > largestGeekValue) {
      largestGeekValue = elevationList[i];
    }
      
    // Checking for smallest value in the list
    if (elevationList[i] < smallestGeekValue) {
      smallestGeekValue = elevationList[i];
    }
  }
}

// funkcja dodawania do listy dlugosci i szerorkosci
void setPoints(List ptList, List latList, List longList) {
  for (int i = 0; i < latList.length; i++) {
    ptList.add(LatLng(latList[i], longList[i]));
  }
  _polyline.add(Polyline(
    polylineId: PolylineId('Trasa'),
    points: PointsList,
    width: 5,
  ));
  print("POINTS: $PointsList");
}

void getMiddlePosition(List latList, List lngList) {
  var middlePosidx = (latList.length / 2).round();
  middlePosition = LatLng(latList[middlePosidx], lngList[middlePosidx]);
  print("MIDDLE IDX: $middlePosidx");
  print("MIDDLE POS: $middlePosition");
}

class WykresWysokosci extends StatefulWidget {
  const WykresWysokosci({Key? key}) : super(key: key);

  @override
  State<WykresWysokosci> createState() => _WykresWysokosciState();
}

class _WykresWysokosciState extends State<WykresWysokosci> {
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  var db = Mysql();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Podsumowanie Tygodnia $tydzien'),
        backgroundColor: getcolor(),
      ),
      backgroundColor: Colors.white,
      body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Przebyta trasa',style: TextStyle(fontSize: 20,),),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                height: 400,
                width: 350,
                
                child: GoogleMap(
                    mapType: MapType.terrain,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: _markers,
                    polylines: _polyline,
                    polygons: _polygon,
                    initialCameraPosition:
                        CameraPosition(target: middlePosition, zoom: 14.00)),
              ),
            SizedBox(
              height: 100,
            ),
            Text('Wykres wysokości',style: TextStyle(fontSize: 20,),),
            // LineChart(
            //   LineChartData(
            //     titlesData: FlTitlesData(
            //       show: true,
            //       bottomTitles: SideTitles(
            //         showTitles: true,
            //         reservedSize: 35,
            //         getTitles: (value) {
            //           switch (value.toInt()) {
            //             case 0:
            //               return '0';
            //             case 10:
            //               return '10';
            //             case 20:
            //               return '20';
            //           }
            //           return '';
            //         },
            //         margin: 8,
            //       ),
            //       leftTitles: SideTitles(
            //         showTitles: true,
            //         reservedSize: 5,
            //         getTitles: (value) {
            //           switch (value.toInt()) {
            //             case 50:
            //               return '50';
            //             case 100:
            //               return '100';
            //             case 150:
            //               return '150';
            //           }
            //           return '';
            //         },
            //         margin: 8,
            //       ),
            //       ),
            //     minX: 0,
            //     maxX: spotWeightList.length.toDouble() - 1,
            //     minY: smallestGeekValue-5.0,
            //     maxY: largestGeekValue+20.0,
            //     gridData: FlGridData(drawVerticalLine: true),
            //     lineBarsData: [
            //       LineChartBarData(
            //         spots: spotWeightList,
            //         //colors: gradientColors,
            //         barWidth: 5,
            //         isCurved: true,
            //         belowBarData: BarAreaData(
            //           show: true,
            //           colors: gradientColors
            //               .map((color) => color.withOpacity(0.3))
            //               .toList(),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        // Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
              
        //     ])
      ]),
    );
  }
}
