import 'package:fiboeda/pages/index.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  static const route = '/order';

  @override
  Widget build(BuildContext context) {
    final _CompanyData company = ModalRoute.of(context).settings.arguments;
    final bool showForm = company != null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Бронь столиков'),
      ),
      body: showForm ? _Form(company) : _StartScreen(_companies),
    );
  }
}

class _Form extends StatefulWidget {
  final _CompanyData company;

  const _Form(this.company);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    _OrderData _order = _OrderData(widget.company);

    return Container(
      child: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  _order.company.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Text(
                  _order.company.address,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              SizedBox(height: 16.0),
              Divider(),
              ListTile(
                leading: Icon(Icons.person, color: Theme.of(context).primaryColor,),
                minLeadingWidth: 20.0,
                title: TextField(
                  decoration: InputDecoration(hintText: 'Ваше имя'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.phone, color: Theme.of(context).primaryColor,),
                minLeadingWidth: 20.0,
                title: TextField(
                  decoration: InputDecoration(hintText: 'Номер телефона'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.people, color: Theme.of(context).primaryColor,),
                minLeadingWidth: 20.0,
                title: TextField(
                  decoration: InputDecoration(hintText: 'Количество персон'),
                ),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Theme.of(context).primaryColor,),
                minLeadingWidth: 20.0,
                title: TextField(
                  decoration: InputDecoration(hintText: 'Дата и время'),
                ),
              ),
              SizedBox(height: 32.0),
              Center(
                child: Text('Мы перезвоним для уточнения деталей.', style: TextStyle(color: Colors.grey)),
              ),
              Divider(height: 48.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: OutlineButton(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Забронировать', style: Theme.of(context).textTheme.subtitle1,),
                  borderSide: BorderSide(
                      width: 2.0, color: Theme.of(context).primaryColor),
                  highlightedBorderColor: Colors.white,
                  onPressed: () {
                    _order.save();
                    Navigator.of(context).popUntil((route) => route.settings.name == IndexPage.route);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final _CompanyData company;
  _Card(this.company);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              child: Image.asset(
                company.image,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  company.title,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Colors.white,
                      ),
                ),
                SizedBox(height: 16.0),
                Text(company.address,
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 24.0),
                OutlineButton(
                  borderSide: BorderSide(width: 2.0, color: Colors.white),
                  highlightedBorderColor: Colors.white,
                  child: Text('Хочу сюда!'),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(OrderPage.route, arguments: company);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _StartScreen extends StatelessWidget {
  final List<_CompanyData> companies;
  _StartScreen(this.companies);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: companies.map((e) => _Card(e)).toList(),
    );
  }
}

class _CompanyData {
  final String title;
  final String address;
  final String image;
  _CompanyData(this.title, this.address, this.image);
}

List<_CompanyData> _companies = [
  _CompanyData('Кухня • бар', '50 лет Октября, 57в', 'assets/order_bar.jpg'),
  _CompanyData('Кальянная', 'Монтажников, 59', 'assets/about.jpg'),
];

class _OrderData {
  final _CompanyData company;
  String name = '';
  String phone = '';
  String time = '';
  String personCount = '';
  String comment = '';

  _OrderData(this.company);

  save() {
    print('Send order to database');
  }
}
