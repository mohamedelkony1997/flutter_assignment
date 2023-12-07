
import 'package:assignment_test/bussinessLogic/LoginCubit/login_cubit.dart';
import 'package:assignment_test/bussinessLogic/itemsCubit/items_cubit.dart';


import 'package:assignment_test/views/itemsdetails/ItemDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment_test/repositery/authrepositery/loginRepositery.dart';
import 'package:assignment_test/repositery/items/itemsRepositery.dart';
import 'package:get/get.dart';
import 'views/fix/fix.dart';
import 'views/items/items.dart';
import 'views/authfolder/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit(LoginRepository())),
          BlocProvider(create: (context) => ItemsCubit(ItemRepository())),
        ],
        child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
         initialRoute: '/',
      routes: {
        '/': (context) =>  MyHomePage(title: 'Potato Tech Flutter Assignment'),
        "/login": (context) => LoginTab(),
        "items": (context) => ItemsTabView(),
        "/itemsdetails": (context) => ItemDetailsPage(),
        "/fix": (context) => FixTab(),
       
      },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tab = _tabController.index;
      });
    });

    context.read<ItemsCubit>().loadItems();
  }

  Widget _tabBars(int index) {
    switch (index) {
      case 0:
        return LoginTab();
      case 1:
        return ItemsTabView();
      default:
        return FixTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: const Tab(
                  child: Text('Login'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: const Tab(
                  child: Text('Items'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: const Tab(
                  child: Text('Fix'),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _tabBars(0),
            _tabBars(1),
            _tabBars(2),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
