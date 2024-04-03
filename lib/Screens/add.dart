import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/model/add_date.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});


  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final box = Hive.box<Add_data>('data');
  DateTime date = DateTime.now();
  String? selectedItem;
  String? selectedItemsi;
  final TextEditingController explainController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final FocusNode explainFocus = FocusNode();
  final FocusNode amountFocus = FocusNode();
  final List<String> _items = [
    'Food',
    'Pix',
    'Uber',
    'Education'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    explainFocus.addListener(() {
      setState(() {});
    });
    amountFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            backgroundContainer(context),
            Positioned(
              top: 120,
              child: mainContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Container mainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 550,
      width: 340,
      child: Column(
        children: [
          const SizedBox(height: 50),
          nameDropDown(),
          const SizedBox(height: 30),
          explainTextField(),
          const SizedBox(height: 30),
          amountTextField(),
          const SizedBox(height: 10),
          howDropDown(),
          const SizedBox(height: 10),
          dateTimeButton(),
          const SizedBox(height: 25),
          saveButton(),

        ],
      ),
    );
  }

  GestureDetector saveButton() {
    return GestureDetector(
      onTap: () {
        if (selectedItem != null &&
            selectedItemsi != null &&
            amountController.text.isNotEmpty &&
            explainController.text.isNotEmpty) {
          var add = Add_data(
            selectedItemsi!,
            amountController.text,
            date,
            explainController.text,
            selectedItem!,
          );
          box.add(add);
          Navigator.of(context).pop();
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Erro'),
              content: const Text('Por favor, preencha todos os campos obrigatórios.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.deepPurple.shade700
        ),
        width: 120,
        height: 50,
        child: const Text(
          'Save',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget dateTimeButton() {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: const Color(0xffC5C5C5))),
      width: 300,
      child: TextButton(
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2020),
              lastDate: DateTime(2100));
          if (newDate == null) return;
          setState(() {
            date = newDate;
          });
        },
        child: Text(
          '${date.year} / ${date.day} / ${date.month}',
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Padding howDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 12, bottom: 5),
          ),
          Wrap(
            spacing: 10,
            children: [
              CheckboxListTile(
                title: const Text('Income'),
                value: selectedItemsi == 'Income', // Check if "Income" is selected
                onChanged: (value) => setState(() => selectedItemsi = value! ? 'Income' : null),
                activeColor: Colors.deepPurple.shade700,
              ),
              CheckboxListTile(
                title: const Text('Expense'),
                value: selectedItemsi == 'Expense', // Check if "Expense" is selected
                onChanged: (value) => setState(() => selectedItemsi = value! ? 'Expense' : null),
                activeColor: Colors.deepPurple.shade700,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding amountTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: amountController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Amount',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xff7052f7))),
        ),
      ),
    );
  }

  Padding explainTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: TextField(
          controller: explainController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            labelText: 'Description',
            labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xff7052f7)),
            ),
          ),
        ),
      ),
    );
  }

  Padding nameDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: const Color(0xffC5C5C5),
          ),
        ),
        child: DropdownButton<String>(
          value: selectedItem,
          onChanged: ((value) {
            setState(() {
              selectedItem = value!;
            });
          }),
          items: _items
              .map((e) => DropdownMenuItem(
                value: e,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40,
                        child: Image.asset('assets/img/$e.png'),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    e,
                    style: const TextStyle(fontSize: 17),
                  )
                ],
              ),
            ),
          ))
              .toList(),
          hint: const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              'Name',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }


  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff7052f7), Color(0xff4a9af7)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Text(
                      'Adding',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    const Icon(
                      Icons.attach_file_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
