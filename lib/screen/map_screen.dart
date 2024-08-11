import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';
import 'package:veri_food/dao/review_helper.dart';
import 'package:veri_food/dao/store_helper.dart';
import 'package:veri_food/model/store.dart';

class MapScreen extends StatefulWidget {
  final Uuid? store;

  const MapScreen({super.key, this.store});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late NaverMapController _mapController;
  final Completer<NaverMapController> _mapControllerCompleter = Completer();
  Store? _selectedStore;
  List<Store> _stores = [];

  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NaverMap(
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

              _loadMarkers();
              // send map controller complete signal
              _mapControllerCompleter.complete(_mapController);
            },
          ),
          _bottomWidget(),
        ],
      ),
    );
  }

  Widget _bottomWidget() {
    if (_selectedStore == null) {
      return Container();
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, "/store", arguments: _selectedStore!.uuid);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF7FAF9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: 250,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedStore?.name ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w900,
                          height: 0,
                          letterSpacing: 0.36,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          RatingBar.builder(
                            itemSize: 16,
                            initialRating: 0,
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
                          const SizedBox(width: 4),
                          Text(
                            '4.1/5 (32)',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w400,
                              height: 0,
                              letterSpacing: 1.32,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/48x48"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/48x48"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://via.placeholder.com/48x48"),
                                fit: BoxFit.fill,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Spacer(flex: 1),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFDA0B1F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

  void _loadMarkers() {
    _mapController.clearOverlays();

    for (var store in _stores) {
      var marker = NMarker(
        id: store.uuid.toString(),
        position: NLatLng(37.5666805, 126.9784147),
        icon: NOverlayImage.fromAssetImage("assets/marker.png"),
      );

      marker.setOnTapListener((overlay) {
        setState(() {
          _selectedStore = store;
        });
      });
      _mapController.addOverlay(marker);
    }
  }

  void _loadItems() async {
    Store? selectedStore;
    if (widget.store != null) {
      selectedStore = await StoreHelper().loadStore(widget.store!);
    }

    var stores = await StoreHelper().loadStoreList();
    _loadMarkers();
    setState(() {
      _stores = stores;
      _selectedStore = selectedStore;
    });
  }
}
