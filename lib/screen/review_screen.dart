import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:uuid/parsing.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import 'package:veri_food/dao/review_helper.dart';
import 'package:veri_food/dao/store_helper.dart';
import 'package:veri_food/model/review.dart';

class ReviewScreen extends StatefulWidget {
  final Uuid? store;

  const ReviewScreen({super.key, this.store});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weeksController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  int _checkListValue = 0;
  int _stars = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Write a Review',
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            height: 0.08,
            letterSpacing: 0.10,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: ShapeDecoration(
                  color: Color(0xFFECF8F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'What is your name and weeks of pregnancy?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.10,
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.10,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLines: 1,
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Weeks of Pregnancy',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.10,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      maxLines: 1,
                      controller: _weeksController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 100,
                decoration: ShapeDecoration(
                  color: Color(0xFFECF8F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'How was your meal?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.10,
                      ),
                    ),
                    RatingBar.builder(
                      itemSize: 24,
                      initialRating: _stars / 2.0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ignoreGestures: false,
                      updateOnDrag: true,
                      itemBuilder: (context, _) {
                        return const Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                      onRatingUpdate: (rating) {
                        setState(() {
                          _stars = (rating * 2).toInt();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 400,
                decoration: ShapeDecoration(
                  color: const Color(0xFFECF8F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    const Expanded(
                      child: Text(
                        'Please check the checklist.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: (_checkListValue & (1 << 0) != 0),
                            onChanged: (value) {
                              setState(() {
                                _checkListValue = _checkListValue ^ (1 << 0);
                              });
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Does it contain ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'raw',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: ' or ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'uncooked meats',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: (_checkListValue & (1 << 1) != 0),
                            onChanged: (value) {
                              setState(() {
                                _checkListValue = _checkListValue ^ (1 << 1);
                              });
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Does it contain ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'raw',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: ' or ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'uncooked sausages',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: (_checkListValue & (1 << 2) != 0),
                            onChanged: (value) {
                              setState(() {
                                _checkListValue = _checkListValue ^ (1 << 2);
                              });
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Does it contain ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'raw fish',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: ', ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'smoked fish',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: ' or ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'seafoods',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w800,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: (_checkListValue & (1 << 3) != 0),
                            onChanged: (value) {
                              setState(() {
                                _checkListValue = _checkListValue ^ (1 << 3);
                              });
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Does it contain ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'organ meats',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: (_checkListValue & (1 << 4) != 0),
                            onChanged: (value) {
                              setState(() {
                                _checkListValue = _checkListValue ^ (1 << 4);
                              });
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Does it contain ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'raw',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: ' or ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'undercooked eggs',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: (_checkListValue & (1 << 5) != 0),
                            onChanged: (value) {
                              setState(() {
                                _checkListValue = _checkListValue ^ (1 << 5);
                              });
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Does it contain ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'fresh cheese',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: ' or ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'soft cheese',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: (_checkListValue & (1 << 6) != 0),
                            onChanged: (value) {
                              setState(() {
                                _checkListValue = _checkListValue ^ (1 << 6);
                              });
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Does it contain ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'blue cheese',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: (_checkListValue & (1 << 7) != 0),
                            onChanged: (value) {
                              setState(() {
                                _checkListValue = _checkListValue ^ (1 << 7);
                              });
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Does it contain ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'unwashed fruits',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: ' or ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'vegetables',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: (_checkListValue & (1 << 8) != 0),
                            onChanged: (value) {
                              setState(() {
                                _checkListValue = _checkListValue ^ (1 << 8);
                              });
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Is it a ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'takeaway salad',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: ' or ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'salad bar',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Checkbox(
                            value: (_checkListValue & (1 << 9) != 0),
                            onChanged: (value) {
                              setState(() {
                                _checkListValue = _checkListValue ^ (1 << 9);
                              });
                            },
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Does it contain any ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'alcohol',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: ' or ',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: 'caffeine',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w900,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                                TextSpan(
                                  text: '?',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 10,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    height: 0.15,
                                    letterSpacing: 0.10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 100,
                decoration: ShapeDecoration(
                  color: Color(0xFFECF8F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Please add a photo of the food',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.10,
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image:
                              NetworkImage("https://via.placeholder.com/48x48"),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 200,
                decoration: ShapeDecoration(
                  color: Color(0xFFECF8F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Please leave a detailed review',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.10,
                      ),
                    ),
                    TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Write your review here',
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.10,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: _commentController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await _saveReview(Review(
                          uuid: Uuid(),
                          rating: _stars,
                          authorName: _nameController.text,
                          authorWeek: int.parse(_weeksController.text),
                          createdAt: DateTime.now().millisecondsSinceEpoch,
                          food: widget.store!,
                          checklist: _checkListValue,
                          comment: _commentController.text,
                          pictureUrl:
                              "https://via.placeholder.com/48x48",
                        ));

                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
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
                            'Submit Review >',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.80,
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
        ),
      ),
    );
  }

  Future<void> _saveReview(Review review) async {
    // Save review to database
    if (widget.store == null) return;
    var store = await StoreHelper().loadStore(widget.store!);
    if (store == null) return;
    await ReviewHelper().saveReview(review);
    store.reviewList.add(review.uuid);
    await StoreHelper().saveStore(store);
  }
}
