import 'package:flutter/material.dart';
import '../Screens/add.dart';
import '../Screens/home.dart';
import '../screens/statistics.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  final ValueNotifier<int> _indexColor = ValueNotifier<int>(0);
  final List<IconData> _icons = [
    Icons.home,
    Icons.bar_chart_outlined,
    Icons.account_balance_wallet_outlined,
    Icons.person_outlined
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _indexColor,
        builder: (context, index, child) {
          switch (index) {
            case 0:
              return const Home();
            case 1:
              return const Statistics();
            case 2:
              return const Home(); // Substitua por outro widget conforme necessário
            case 3:
              return const Statistics(); // Substitua por outro widget conforme necessário
            default:
              return Container(); // Caso o índice esteja fora do intervalo, retorne um container vazio
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddScreen()));
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _icons.length,
                  (index) => GestureDetector(
                onTap: () {
                  _indexColor.value = index;
                },
                child: ValueListenableBuilder<int>(
                  valueListenable: _indexColor,
                  builder: (context, currentIndex, child) => Icon(
                    _icons[index],
                    size: 30,
                    color: currentIndex == index ? Colors.deepPurple : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
