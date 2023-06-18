import 'dart:async';
import 'dart:ffi';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:test2/Pages/interface.dart';
import 'package:test2/Pages/wybor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:location/location.dart';
import 'package:test2/main.dart';
import 'package:test2/Pages/landing.dart';
//import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart';

void zapisz_do_bazy(double metr) // funkcja zapisania dystansu do bazy
{
      db.getConnection().then((conn) {
          String sql =
              'insert into heroku_9a6378669589f80.meters (id_u,tydzien,dzien,metr) value ("$logowanie_id","$tydzien","$dzien","$metr");';
          conn.query(sql);
        });
}

class CountDownTimerPage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => CountDownTimerPage(),
      ),
    );
  }
  // This function is triggered when the "Read" button is pressed

  @override
  _State createState() => _State();
}

int id = 0;
var db = Mysql();
Future<void> add_markers(List ls, List elv) async {
  db.getConnection().then((conn) {
    String sql =
        'select ID from heroku_9a6378669589f80.markers order by ID desc limit 1';
    conn.query(sql).then((results) {
      for (var row in results) {
        id = row[0];
        print("id: $id");
        if (id == 0 || id == null) {
          print("if id: $id");
          id = 1;
        } else {
          id = id + 1;
          print("else id: $id");
        }
      }
    });
  });

  int elementy = ls.length;
  var latitude = 0.0;
  var longitude = 0.0;
  var elevation = 0;
  String insert =
      'insert into heroku_9a6378669589f80.markers (ID,dzien,tydzien,latitude,longitude,id_u,elevation) values ';
  String values = '';
  await new Future.delayed(const Duration(milliseconds: 500));
  for (int i = 0; i < elementy; i++) {
    latitude = ls[i].latitude;
    longitude = ls[i].longitude;
    elevation = elv[i];
    values =
        '("$id","$dzien","$tydzien","$latitude","$longitude","$logowanie_id","$elevation")';

    insert += values;
    if (i == elementy - 1) {
      insert += ';';
    } else {
      insert += ',';
    }
    print('ZAPYTANIE nr $i: $insert \n');
    print('ZAPYTANIE id: $id');
  }
  db.getConnection().then((conn) {
    conn.query(insert);
  });
}

// zmienne
int runTime = 0; // zmienna globalna od ustawienia czasu biegu
int breakTime = 0; // zmienna globalna od ustawienia czasu truchtu
int stretchingTime = 10; // zmienna od ustawienia czasu rozciagania
int cycles = 0; // zmienna globalna od liczby cykli biegu
bool currentCycle =
    true; // zmienna do informowania o połowie cyklu true/false bieg/przerwa
int cyclesDone = 0; // zmienna od liczby wykonanych cykli
bool autostart = false; // zmienna od autostartu timera
bool started =
    false; // zmienna odpowiadajaca za wykrycie wcisniecia przycisku start
int rawTime = 0; // zmienna odpowiadajaca za trzymanie wartosci czasu
String user = ""; // zmienna przechowujaca email uzytkownika
int tydzien =
    0; // zmienna przechowujaca informacje w ktorym tygodniu znajduje sie uzytkownik
int dzien =
    0; // zmienna przechowujaca informacje w ktorym dniu znajduje sie uzytkownik
int textInfoFlag =
    0; // zmienna odpowiadajaca za flage do zmiany tekstu wyswietlanego
bool minutes = false;
final textInfo = [
  //zmienna odpowiadajaca za wyswietlany tekst w timerze
  Text(
    "Biegaj",
    key: Key('0'),
    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black),
  ),
  Text("Marsz",
      key: Key('1'),
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black)),
  Text("Rociąganie",
      key: Key('2'),
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.black)),
];

//funkcje
var wykonane_cykle = 0;

void getUserInfo(userName, userTydzien, userDzien) {
  // pobranie informacji o uzytkowniku
  user = userName;
  tydzien = userTydzien;
  dzien = userDzien;
}

void setrunTime(int minutes) {
  //ustawienie czasu biegu

  runTime = minutes;
}

void setbreakTime(int minutes) {
  //ustawienie czasu truchtu

  breakTime = minutes;
}

void setCycle(int cycleValue) {
  //ustawienie liczby cylki

  cycles = cycleValue;
}

//ustawienie auto-startu
void setAutoStart(bool switcher) {
  autostart = switcher;
}

void setMinutes(bool change) {
  minutes = change;
}

// SPRAWDZENIE DOSTEPU DO LOKALIZACJI W TELEFONIE
checkService(Location location) async {
  var serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }
}

// SPYTANIE O DOSTEP DO LOKALIZACJI W TELEFONIE
askPermission(Location location) async {
  var _permissiongranted = await location.hasPermission();
  if (_permissiongranted == PermissionStatus.denied) {
    _permissiongranted = await location.requestPermission();
    if (_permissiongranted != PermissionStatus.granted) {
      return;
    }
  }
}

class _State extends State<CountDownTimerPage> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countDown,
    onEnded: () {
      print('onEnded');
    },
  );

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (minutes) {
      _stopWatchTimer.setPresetMinuteTime(runTime);
    } else {
      _stopWatchTimer.setPresetSecondTime(runTime);
    }
    //_stopWatchTimer.setPresetSecondTime(runTime); // ustawienie czasu w timerze
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    if (autostart) {
      _stopWatchTimer.onExecute
          .add(StopWatchExecute.start); // wystartowanie automatyczne
    }

    //ustawienie na zmienną czasu
    _stopWatchTimer.rawTime.listen((value) => rawTime = value);

    // wyłączenie okna timera  tutaj powinno byc przekierowanie o wykonaniu cykli
    _stopWatchTimer.rawTime.listen((value) async {
      if (rawTime == 0 && started == true && cyclesDone == -1) {
        print("koniec");
        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
        updateProgress(user, tydzien, dzien, 1);
        await new Future.delayed(const Duration(milliseconds: 500));
        add_markers(PointsTable, elevationList);
        started = false;
        await new Future.delayed(const Duration(milliseconds: 1500));
        Navigator.pop(context);
        Navigator.pop(context);
        wykonane_cykle = 0;
        textInfoFlag = 0;
        cyclesDone = 0;
        zapisz_do_bazy(nowa3);
        //started = false;
      }
    });

    // ustawienie cyklu rozciagania sie
    _stopWatchTimer.rawTime.listen((value) {
      if (rawTime == 0 && started == true && cyclesDone == cycles) {
        print("rozciaganie");
        //setAutoStart(true);
        setState(() {
          textInfoFlag = 2;
          if (minutes) {
            _stopWatchTimer.setPresetMinuteTime(stretchingTime);
          } else {
            _stopWatchTimer.setPresetSecondTime(stretchingTime);
          }
          //_stopWatchTimer.setPresetSecondTime(stretchingTime);
          _stopWatchTimer.onExecute
              .add(StopWatchExecute.start); // wystartowanie automatyczne
          FlutterRingtonePlayer.playAlarm();
          Future.delayed(Duration(milliseconds: 3000), () {
            FlutterRingtonePlayer.stop();
          });
        });
        wykonane_cykle = cycles;
        cyclesDone = -1;
      }
    });

    // funkcja on ended
    // sledzenie rawtime do przemiany cyklu
    _stopWatchTimer.rawTime.listen((value) {
      print('cyclesDone: $cyclesDone');
      if (rawTime == 0 &&
          started == true &&
          cyclesDone != cycles &&
          cyclesDone != -1) {
        if (currentCycle) {
          currentCycle = false;
          print("przerwa");

          setState(() {
            textInfoFlag = 1;
            if (minutes) {
              _stopWatchTimer.setPresetMinuteTime(breakTime);
            } else {
              _stopWatchTimer.setPresetSecondTime(breakTime);
            }
            //_stopWatchTimer.setPresetSecondTime(breakTime);
            _stopWatchTimer.onExecute
                .add(StopWatchExecute.start); // wystartowanie automatyczne
            FlutterRingtonePlayer.playAlarm();
            Future.delayed(Duration(milliseconds: 3000), () {
              FlutterRingtonePlayer.stop();
            });
          });

          cyclesDone++;
          wykonane_cykle++;
          if (wykonane_cykle > cycles) {
            wykonane_cykle = cycles;
          }
        } else {
          currentCycle = true;
          print("bieg");
          setState(() {
            textInfoFlag = 0;
            if (minutes) {
              _stopWatchTimer.setPresetMinuteTime(runTime);
            } else {
              _stopWatchTimer.setPresetSecondTime(runTime);
            }
            //_stopWatchTimer.setPresetSecondTime(runTime);
            _stopWatchTimer.onExecute
                .add(StopWatchExecute.start); // wystartowanie automatyczne
            FlutterRingtonePlayer.playAlarm();
            Future.delayed(Duration(milliseconds: 3000), () {
              FlutterRingtonePlayer.stop();
            });
          });
        }
      }
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

/************************************************* MAPA TUTAJ ******************************************************* */

  String mergeURL(String URL, String LAT, String LONG) {
    String mergedUrl = URL + LAT + ',' + LONG;
    return mergedUrl;
  } /* FUNKCJA DO MERGORWANIA URL DO WYSOKOSCI */

  String url =
      'https://api.opentopodata.org/v1/eudem25m?locations='; // URL DO ODCZYTANIA WYSOKOSCI

  Future<int> fetchElevation(url1) async {
    final response = await get(Uri.parse(url1));
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    //print(jsonData["results"][0]["elevation"].toInt());
    var elevation = jsonData["results"][0]["elevation"].toInt();
    return elevation;
  } /* FUNKCJA DO WYCIAGANIA WYSOKOSCI Z URL */

  Completer<GoogleMapController> _controller = Completer();
  var location = new Location(); // zmienna lokacji
  var latitude; // zmienna szerokosci geograficznej
  var longitude; // zmienna dlugosci geograficznej
  var elevation; //zmienna wysokosci geograficznej
  var mergedURL; // zmienna przechowujaca url zmergowany
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(53.447032, 14.491759),
    zoom: 14.4746,
  );

  Set<Marker> _markers = {}; // markery
  late BitmapDescriptor mapMarker;
  Set<Polyline> _polyline = {}; // linie
  Set<Polygon> _polygon = {};

  Set<Polyline> _polylines = Set<Polyline>();
  Set<Polygon> _polygons = Set<Polygon>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polygonIdCounter = 1;

  List<LatLng> PointsTable =
      <LatLng>[]; // tablica przechowujaca punkty na mapie

  List<int> elevationList = <int>[]; // lista przechowujaca wysokosci

  var prev_lat = 0.0; // poprzednia szerokosc geograficzna
  var prev_long = 0.0; // poprzednia dlugosc geograficzna

  // funckja pobierania wartosci z listy
  void getPointsValues(tablica) {
    int elementy = tablica.length;
    var latitude = 0.0;
    var longitude = 0.0;

    for (int i = 0; i < elementy; i++) {
      latitude = tablica[i].latitude;
      longitude = tablica[i].longitude;
      print(latitude);
    }
  }

  // funkcja dodawania do listy dlugosci i szerorkosci
  void addTab(List PointsTable, double lat, double long) {
    PointsTable.add(LatLng(lat, long));
  }

  void addElevation(List elevationList, int elevation) {
    elevationList.add(elevation);
  }

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 0.0,
      zoom: 19.151926040649414);

  void _onMapCreated(GoogleMapController) {
    //funkcja odswiezajaca linie punktow na mapie
    setState(() {
      _polyline.add(Polyline(
        polylineId: PolylineId('Trasa'),
        points: PointsTable,
        width: 5,
      ));
    });
  }
    double calculateDistance(lat1, lon1, lat2, lon2) { //funkcja wyliczajaca odległość 
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    var wynik = 12742 * asin(sqrt(a));
    return wynik;
  }
  String _content = "";
  double nowa2=0.0;
  double nowa3=0.0;
  // Find the Documents path
  Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }



  // TextField controller
  final _textController = TextEditingController();
  // This function is triggered when the "Write" buttion is pressed
  Future<void> _writeData(double dane) async {
    final _dirPath = await _getDirPath();

    final _myFile = File('$_dirPath/data.txt');
    // If data.txt doesn't exist, it will be created automatically

    await _myFile.writeAsString('$dane');
    _textController.clear();
    
  }
  
  double roundDouble(double value, int places){ 
   num mod = pow(10.0, places);

    return ((value * mod).round().toDouble() / mod);}

    Future<void> _readData() async {
    final dirPath = await _getDirPath();
    final myFile = File('$dirPath/data.txt');
    final data = await myFile.readAsString(encoding: utf8);
   
    setState(() {
      
      _content = data;

    });
        double nowa=double.parse(_content)*1000.0;
    nowa2=nowa+nowa2;
  
    print('nowa  $nowa');
    print('nowa2 $nowa2');
    print('nowa3 $nowa3');
    
    if (nowa2>60000.0){
        nowa2=0.0;
    }
    else{
      nowa3=roundDouble(nowa2, 2);
    print('zmienna $nowa3 ');
    }

  }
  // funkcja sprawdzajaca zmiane lokalizacji
  Future<void> _goToTheLake() async {
    // print('Started: $started');
    // if(!started){
    //   return;
    // }
    final GoogleMapController controller = await _controller.future;

    var currentLocation = await location.getLocation();
    latitude = currentLocation.latitude!;
    longitude = currentLocation.longitude!;
    var idk = CameraPosition(
        target: LatLng(latitude, longitude),
        bearing: 192.8334901395799,
        tilt: 0.0,
        zoom: 19.151926040649414);

    location.onLocationChanged.listen((LocationData currentLocation) async {
      if (!started) {
        return;
      }
      latitude = currentLocation.latitude!;
      longitude = currentLocation.longitude!;
      print('Lat: $latitude');
      print('Long: $longitude');
      print('elevation: $elevation');
      print('Tab: $PointsTable');
      print('URL: $mergedURL');
      print('ElTab: $elevationList');

      if ((prev_lat - latitude).abs() > 0.00001 ||
          (prev_long - longitude).abs() > 0.00001) {
        print('Location changed !!');
        var a=calculateDistance(prev_lat, prev_long, latitude, longitude);
      
        print(a);
        _writeData(a);
        _readData();

        prev_lat = latitude;
        prev_long = longitude;
        //print(prev_lat - latitude);
        var idk = CameraPosition(
            target: LatLng(latitude, longitude),
            bearing: 192.8334901395799,
            tilt: 0.0,
            zoom: 19.151926040649414);
        await new Future.delayed(const Duration(milliseconds: 500));

        controller.animateCamera(CameraUpdate.newCameraPosition(idk));
        //tablica.add(LatLng(latitude, longitude));

        addTab(PointsTable, latitude, longitude);
        await new Future.delayed(const Duration(milliseconds: 1000));
        mergedURL = mergeURL(url, latitude.toString(), longitude.toString());
        elevation = await fetchElevation(mergedURL);
        addElevation(elevationList, elevation);
        await new Future.delayed(const Duration(milliseconds: 1000));
      }

      var diff1 = (prev_lat - latitude).abs();
      var diff2 = (prev_long - longitude).abs();
      print('Difference lat: $diff1');
      print('Difference long: $diff2');
      print('Started: $started');
      print(prev_long);
      print(prev_lat);
      _onMapCreated(controller);
    });
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zegarek'),
        backgroundColor: getcolor(),
        automaticallyImplyLeading: false,
      ),
      body: Stack(children: <Widget>[
        //Text("dssd"), // elemety za wysuwanym panelem
        GoogleMap(
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
            polylines: _polyline,
            polygons: _polygon,
            initialCameraPosition:
                CameraPosition(target: LatLng(52.00, 47.00), zoom: 17)),
        SizedBox(
          height: 2000,
          child: SlidingUpPanel(
            maxHeight: MediaQuery.of(context).size.height * .80,
            //margin: EdgeInsets.symmetric(horizontal: 15.0),
            backdropEnabled: true,
            panel: StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snap) {
                final value = snap.data!;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: _isHours);
                return Column(children: <Widget>[
                  Center(
                    child: Icon(
                      Icons.arrow_upward,
                      size: 24,
                    ),
                  ),
                  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: textInfo[textInfoFlag]),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      displayTime,
                      style: const TextStyle(
                          fontSize: 40,
                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  CircularPercentIndicator(
                      radius: 150,
                      lineWidth: 8,
                      backgroundColor: Colors.grey,
                      percent: wykonane_cykle / cycles,
                      animation: true,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Wykonano:',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                          Text('$wykonane_cykle/$cycles',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black)),
                        ],
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlue,
                                  onPrimary: Colors.white,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () async {
                                  _goToTheLake();
                                  started = true;
                                  _stopWatchTimer.onExecute
                                      .add(StopWatchExecute.start);
                                },
                                child: const Text(
                                  'Start',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white,
                                  shape: const StadiumBorder(),
                                ),
                                onPressed: () async {
                                  started = false;
                                  _stopWatchTimer.onExecute
                                      .add(StopWatchExecute.stop);
                                  wykonane_cykle = 0;
                                  textInfoFlag = 0;
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Back',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                       ]
                       
                       )
                       ),
                      Padding(
                          padding:
                            const EdgeInsets.only(bottom: 10),
                            child: Text("Dystans: $nowa3 m",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold ) ,
                    ),
                               
                  )
                          
                ]
                );
                
              },
            ),
            
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            parallaxEnabled: true,
            parallaxOffset: .5, minHeight: 110,

          ),
        
        ) 
      ]),
    );
  }
}
