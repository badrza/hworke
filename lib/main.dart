import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hiveandcach/config/get_config.dart';
import 'package:hiveandcach/controller/counter_controller.dart';
import 'package:hiveandcach/model/bird_model.dart'; // إزالة الاستيراد المكرر
import 'package:hiveandcach/model/handle_model.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

import 'service/bird_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Hive.openBox<BirdModel>('bird');

  init(); // تأكد من أن دالة init موجودة وتعمل بشكل صحيح
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ValueNotifier<ResultModel> result = ValueNotifier(ResultModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePageWithListBird(),
              ),
            );
          },
          icon: const Icon(Icons.toc),
        ),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class HomePageWithListBird extends StatelessWidget {
  HomePageWithListBird({super.key});

  final ValueNotifier<ResultModel> result = ValueNotifier(ResultModel());

  get birdService => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bird List')),
      body: ValueListenableBuilder<ResultModel>(
        valueListenable: result,
        builder: (context, value, child) {
          if (value is ListOf<BirdModel>) {
            return ListView.builder(
              itemCount: value.modelList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(value.modelList[index].name),
                  leading: Image.network(value.modelList[index].image),
                );
              },
            );
          } else if (value is ExceptionModel) {
            return Center(child: Text(value.message));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          result.value = await birdService.getAllBird();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
