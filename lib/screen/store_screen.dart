import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:veri_food/dao/food_helper.dart';
import 'package:veri_food/dao/review_helper.dart';
import 'package:veri_food/dao/store_helper.dart';
import 'package:veri_food/model/food.dart';
import 'package:veri_food/model/review.dart';
import 'package:veri_food/model/store.dart';

class StoreScreen extends StatefulWidget {
  final String? store;

  const StoreScreen({super.key, this.store});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int _selectedMenu = 0;
  Store? _selectedStore = Store(
    uuid: "1",
    name: "Restaurant 1",
    latitude: 35.8355006,
    longitude: 129.20920409,
    likes: 0,
    reviewList: [],
    foodList: [],
  );
  double? _avgRating = 4.5;
  List<Food> _foodList = [
    Food(
      uuid: "1",
      name: "Food 1",
      price: 10000,
    ),
    Food(
      uuid: "2",
      name: "Food 2",
      price: 20000,
    ),
    Food(
      uuid: "3",
      name: "Food 3",
      price: 30000,
    ),
  ];
  List<Review> _reviewList = [

  ];

  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedStore?.name ?? "Store Screen"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/360x287"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: Text(
                        _selectedStore?.name ?? "Store Name",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 31,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 0.03,
                          letterSpacing: 0.10,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          itemSize: 24,
                          initialRating: _avgRating ?? 0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
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
                          '$_avgRating/5 (32)',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: 1.32,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.call, color: Colors.black),
                        SizedBox(width: 4),
                        Text(
                          'Phone',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0.21,
                            letterSpacing: 0.10,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          '|',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0.21,
                            letterSpacing: 0.10,
                          ),
                        ),
                        SizedBox(width: 16),
                        Icon(CupertinoIcons.heart, color: Colors.black),
                        SizedBox(width: 4),
                        Text(
                          'Like',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0.21,
                            letterSpacing: 0.10,
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          '|',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0.21,
                            letterSpacing: 0.10,
                          ),
                        ),
                        SizedBox(width: 16),
                        Icon(CupertinoIcons.share, color: Colors.black),
                        SizedBox(width: 4),
                        Text(
                          'Share',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0.21,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // select menu
              Container(
                width: double.infinity,
                height: 50,
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedMenu = 0;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: _selectedMenu == 0
                              ? const Color(0xFF9BDBCE)
                              : const Color(0xFFCCE8E7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          'Menu',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0.21,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedMenu = 1;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: _selectedMenu == 1
                              ? const Color(0xFF9BDBCE)
                              : const Color(0xFFCCE8E7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          'Info & Origin',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0.21,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedMenu = 2;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: _selectedMenu == 2
                              ? const Color(0xFF9BDBCE)
                              : const Color(0xFFCCE8E7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                        child: const Text(
                          'Review',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            height: 0.21,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _loadMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadMenu() {
    switch (_selectedMenu) {
      case 0:
        return _menu();
      case 1:
        return _info();
      case 2:
        return _review();
      default:
        return _menu();
    }
  }

  Widget _menu() {
    return Column(
      children: [
        _menuItem(0),
        _menuItem(1),
        _menuItem(2),
        _menuItem(3),
        _menuItem(4),
        _menuItem(5),
        _menuItem(6),
        _menuItem(7),
        _menuItem(8),
        _menuItem(9),
      ],
    );
  }

  Widget _menuItem(int index) {
    if (index >= (_foodList.length)) {
      return Container();
    }
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _foodList[index].name,
                style: const TextStyle(
                  color: Color(0xFF161D1D),
                  fontSize: 22,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Best menu!',
                style: const TextStyle(
                  color: Color(0xFF3F4949),
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25,
                ),
              ),
              Text(
                (_foodList[index].price ?? "N/A").toString() ,
                style: const TextStyle(
                  color: Color(0xFF3F4949),
                  fontSize: 18,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.25,
                ),
              ),
              Text(
                'Review 45',
                style: const TextStyle(
                  color: Color(0xFF3F4949),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.25,
                ),
              ),
            ],
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 80,
                height: 80,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://via.placeholder.com/80x80"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _info() {
    return Placeholder();
  }

  Widget _review() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFCCE8E7),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  (_avgRating ?? "N/A").toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w900,
                    height: 0,
                    letterSpacing: 2.76,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Review ${_foodList.length}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    letterSpacing: 1.08,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: RatingBar.builder(
                  itemSize: 24,
                  initialRating: 4.5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 0),
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
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/review', arguments: widget.store);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFECF8F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  elevation: 0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: const Center(
                    child: Text(
                      'Write a Review >',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: 1.80,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _reviewItem(0),
        _reviewItem(1),
        _reviewItem(2),
        _reviewItem(3),
        _reviewItem(4),
      ],
    );
  }

  Widget _reviewItem(int index) {
    if (index >= (_reviewList.length)) {
      return Container();
    }
    return Container(
      width: double.infinity,
      height: 150,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: ShapeDecoration(
        color: const Color(0xFFECF8F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 2,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    _reviewList[index].authorName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w600,
                      height: 0,
                      letterSpacing: 1.56,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: RatingBar.builder(
                    itemSize: 24,
                    initialRating: _reviewList[index].rating / 2.0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
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
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '2days ago',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 1.56,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_reviewList[index].authorWeek}th week',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 1.08,
                        ),
                      ),
                      const Text(
                        'of pregnancy',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: 1.08,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '“Safe”',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: 1.56,
                    ),
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              _reviewList[index].comment,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: 1.08,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9BDBCE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      child: Center(
                        child: Text(
                          'Raw Meat, Poultry X',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 1.56,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9BDBCE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      child: Center(
                        child: Text(
                          'Clean vegetables',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 1.56,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            flex: 2,
            child: Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9BDBCE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      child: Center(
                        child: Text(
                          'Seafood X',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 1.56,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9BDBCE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      child: Center(
                        child: Text(
                          'Hard-boiled eggs used',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 1.56,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _loadItems() async {
    if (widget.store == null) return;
    var selectedStore = await StoreHelper().loadStore(widget.store!);
    var avgRating = await ReviewHelper().loadAverageRating(widget.store!);
    setState(() {
      _selectedStore = selectedStore;
      _avgRating = avgRating;
    });
    if (selectedStore == null) return;
    var foodUuidList = selectedStore.foodList;
    List<Food> foodList = [];
    for (var foodUuid in foodUuidList) {
      var food = await FoodHelper().loadFood(foodUuid);
      if (food != null) {
        foodList.add(food);
      }
    }
    setState(() {
      _foodList = foodList;
    });
    var reviewList = <Review>[];
    for (var reviewUuid in selectedStore.reviewList) {
      var review = await ReviewHelper().loadReview(reviewUuid);
      if (review != null) {
        reviewList.add(review);
      }
    }
    setState(() {
      _reviewList = reviewList;
    });
  }
}
