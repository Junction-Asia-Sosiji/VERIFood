import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:veri_food/dao/review_helper.dart';
import 'package:veri_food/dao/store_helper.dart';
import 'package:veri_food/dao/zone_helper.dart';
import 'package:veri_food/model/store.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late NaverMapController _mapController;
  final Completer<NaverMapController> _mapControllerCompleter = Completer();
  bool _isRecommended = true;
  List<Store> _stores = [
    Store(
      uuid: "1",
      name: "Restaurant 1",
      latitude: 35.8355006,
      longitude: 129.20920409,
      likes: 0,
      reviewList: [],
      foodList: [],
    ),
    Store(
      uuid: "2",
      name: "Restaurant 2",
      latitude: 35.835506,
      longitude: 129.2092042,
      likes: 0,
      reviewList: [],
      foodList: [],
    ),
    Store(
      uuid: "3",
      name: "Restaurant 3",
      latitude: 35.835504,
      longitude: 129.2092042,
      likes: 0,
      reviewList: [],
      foodList: [],
    ),
  ];
  List<double> _avgRatings = [
    4.5,
    4.0,
    3.5,
  ];


  @override
  void initState() {
    super.initState();

    // _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shall we eat together today?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              "Let's enjoy delicious food safely",
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 18,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w300,
                letterSpacing: 0.24,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/map");
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  elevation: 0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 193,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: NaverMap(
                    options: const NaverMapViewOptions(
                      indoorEnable: true,
                      locationButtonEnable: true,
                      consumeSymbolTapEvents: false,
                    ),
                    onMapReady: (controller) async {
                      _mapController = controller;

                      NCameraPosition myLocation = await _loadMyLocation();

                      _mapController
                          .updateCamera(NCameraUpdate.fromCameraPosition(myLocation));

                      // send map controller complete signal
                      _mapControllerCompleter.complete(_mapController);
                    },
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF7F9F9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/loud_speaker.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '산모를 위한 각종 꿀팁 url',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF001F26),
                            fontSize: 18,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w800,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isRecommended = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                            ),
                            side:
                                BorderSide(width: 1, color: Color(0xFF6F7979)),
                          ),
                          backgroundColor: _isRecommended
                              ? const Color(0xFFCCE8E8)
                              : Colors.white,
                        ),
                        child: Container(
                          height: 48,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _isRecommended
                                  ? const Icon(Icons.check, size: 18)
                                  : const SizedBox(width: 18),
                              const SizedBox(width: 8),
                              const Text(
                                'Recommended',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF041F20),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isRecommended = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(100),
                              bottomRight: Radius.circular(100),
                            ),
                            side:
                                BorderSide(width: 1, color: Color(0xFF6F7979)),
                          ),
                          backgroundColor: _isRecommended
                              ? Colors.white
                              : const Color(0xFFCCE8E8),
                        ),
                        child: Container(
                          height: 48,
                          // Equivalent to the Container's height
                          alignment: Alignment.center,
                          // Align the content to the center
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Distance',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF041F20),
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.10,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _isRecommended
                                  ? const SizedBox(width: 18)
                                  : const Icon(Icons.check, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _loadRestaurantItem(0),
              _loadRestaurantItem(1),
              _loadRestaurantItem(2),
              Container(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'More Menu Recommendations from Gynecologists >',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadRestaurantItem(int index) {
    if (index >= _stores.length) return Container();
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, "/map", arguments: _stores[index].uuid);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: double.infinity,
        height: 100,
        margin: const EdgeInsets.all(8),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    image: DecorationImage(
                      image: NetworkImage("https://via.placeholder.com/80x80"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 24,
                      child: Row(
                        children: [
                          Text(
                            _stores[index].name,
                            style: const TextStyle(
                              color: Color(0xFF161D1D),
                              fontSize: 22,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 0.06,
                            ),
                          ),
                          SizedBox(width: 8),
                          RatingBar.builder(
                            itemSize: 16,
                            initialRating: _avgRatings[index],
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0),
                            ignoreGestures: true,
                            updateOnDrag: false,
                            itemBuilder: (context, _) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                              );
                            },
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Category • \$\$ • 1.2 miles away ',
                      style: const TextStyle(
                        color: Color(0xFF3F4949),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                        letterSpacing: 0.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(
                  CupertinoIcons.heart,
                  color: Colors.black,
                  size: 24,
                ),
                onPressed: () {
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<NCameraPosition> _loadMyLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return Future.error(
          "Location permissions are denied, we cannot request permissions.");
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    var marker = NMarker(
      id: "my_location",
      position: NLatLng(position.latitude, position.longitude),
      icon: NOverlayImage.fromAssetImage("assets/my_location.png"),
    );

    _mapController.addOverlay(marker);

    return NCameraPosition(
      target: NLatLng(position.latitude, position.longitude),
      zoom: 12,
    );
  }

  void _loadItems() async {
    var zones = await ZoneHelper().loadZoneList();
    var zone = zones.where((element) => element.name == "uuid").firstOrNull;
    if (zone == null) return;
    int i = 0;
    List<Store> stores = [];
    List<double> avgRatings = [];
    for (var storeUuid in zone.stores) {
      var storeUuidString = storeUuid as String;
      if (i >= 5) break;
      var store = await StoreHelper().loadStore(storeUuidString);
      if (store != null) {
        stores.add(store);
        double avg = await ReviewHelper().loadAverageRating(storeUuidString);
        avgRatings.add(avg);
      }
      i++;
    }
    setState(() {
      _stores = stores;
      _avgRatings = avgRatings;
    });
  }
}
