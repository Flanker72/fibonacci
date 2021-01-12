import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Ой...'),
      ),
      body: Center(
          child: Column(
            children: [
              SizedBox(height: 90.0),
              Text(
                'Упс...',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(height: 30.0),
              Text(
                'Тут ничегошеньки нет :(',
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 60.0),
              Image.asset('assets/logo_vertical.png'),
            ],
        ),
      ),
    );
  }
}
