import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  static const route = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('О компании'),
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: [
          Image.asset('assets/about.jpg'),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                Text(
                    'Особенная философия Фибоначчи складывается из многих факторов - команда профессионалов, индивидуальная концепция, гастрономическое меню, приятная музыка и конечно сервис на высшем уровне.'),
                SizedBox(height: 8.0),
                Text(
                    'Мы уверены, бутылочка освежающей воды с соком лайма на столе - это аура хорошего заведения про еду!'),
                SizedBox(height: 8.0),
                Text(
                    'Мы воплощаем свои идеи в реальность и влюбляем в них вас. Философия нашей команды - поддерживая индивидуальность, мы смотрим в одну сторону!'),
                SizedBox(height: 24.0),
                Text(
                  'ДИЗАЙН С ФИЛОСОФИЕЙ',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          Image.asset('assets/interior2.jpg'),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                Text(
                    'Наши дизайнеры отталкивались от европейских трендов и хотели не просто создать комфортный дизайн для наших гостей, но и показать всей Тюмени наш Новаторский подход к делу во всех смыслах этого слова.'),
                SizedBox(height: 8.0),
                Text(
                    'Откройте сердце для нового: Мир таков, каким мы его видим'),
                SizedBox(height: 24.0),
                Row(
                  children: [
                    Image.asset(
                      'assets/logo_vertical.png',
                      width: 48.0,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: Text(
                        'Кстати, Фибоначчи - это итальянский математик Леонардо Пизанский, который выявил последовательность чисел Фибоначчи, ставших основой для понятия "Золотое сечение".',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  'ЧТО ПО КОКТЕЙЛЯМ?',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          Image.asset('assets/cocktails.jpg'),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                Text(
                    'Наша авторская коктейльная карта станет для вас искушением!'),
                SizedBox(height: 8.0),
                Text(
                    'Даже если вы не знаете своих предпочтений, то мы сможем подобрать под вас напиток, который захочется повторить. Фруктовый, ягодный, пряный, сладкий, кислый, освежающий, терпкий, мягкий, легкий, крепкий, воздушный… любой. Просто приходи и пробуй!'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
