import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  static const route = '/order';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Бронь столиков'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black45,
                        BlendMode.darken
                    ),
                    child: Image.asset(
                      'assets/about.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Кухня • бар',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text('50 лет Октября, 57в'),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black45,
                        BlendMode.darken
                    ),
                    child: Image.asset(
                      'assets/order_bar.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Кальянная',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text('Монтажников, 59'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
