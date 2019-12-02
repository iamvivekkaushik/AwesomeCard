import 'dart:math';

import 'package:flutter/material.dart';

class CreditCard extends StatefulWidget {
  final bool showBackSide;
  final Widget frontBackground;
  final Widget backBackground;
  final Widget frontLayout;
  final Widget backLayout;

  CreditCard(
      {this.showBackSide = false,
      @required this.frontBackground,
      @required this.backBackground,
      @required this.frontLayout,
      @required this.backLayout});

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard>
    with SingleTickerProviderStateMixin {
  double cardWidth;
  double cardHeight;
  AnimationController _controller;
  Animation<double> _moveToBack;
  Animation<double> _moveToFront;

  @override
  void initState() {
    _controller = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    _moveToBack = new TweenSequence<double>([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.easeInBack)),
          weight: 50.0),
      TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2), weight: 50.0)
    ]).animate(_controller);

    _moveToFront = new TweenSequence<double>(
      [
        TweenSequenceItem<double>(
          tween: ConstantTween<double>(pi / 2),
          weight: 50.0,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.easeOutBack)),
          weight: 50.0,
        ),
      ],
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    cardWidth = MediaQuery.of(context).size.width - 40;
    cardHeight = (cardWidth / 2) + 10;

    if (widget.showBackSide) {
      _controller.forward().orCancel;
    } else {
      _controller.reverse().orCancel;
    }

    return Center(
      child: Stack(
        children: <Widget>[
          AwesomeCard(
            animation: _moveToBack,
            child: _buildFrontCard(),
          ),
          AwesomeCard(
            animation: _moveToFront,
            child: _buildBackCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: cardWidth,
      height: cardHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            // Background for card
            widget.frontBackground,

            // Front Card Text Alignment
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Axis Bank",
                        style: TextStyle(
                            color: Colors.white, fontSize: 16),
                      ),

                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: new Image.asset('images/contactless_icon.png', width: 70.0, height: 50.0),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: cardWidth,
      height: cardHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            // Background for card
            widget.backBackground,
          ],
        ),
      ),
    );
  }
}

class AwesomeCard extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  AwesomeCard({@required this.animation, @required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value),
          alignment: Alignment.center,
          child: this.child,
        );
      },
    );
  }
}
