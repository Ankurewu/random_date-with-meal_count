import 'package:flutter/material.dart';

void main() {
  runApp(RandomDateGeneratorApp());
}

class RandomDateGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hostel Meal Management System',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define variables to store user inputs and calculated results
  List<double> bazarCostPerPerson = List.filled(5, 0);
  List<int> mealCountPerPerson = List.filled(5, 0);
  double electricityBill = 0;
  double internetBill = 0;
  double gasBill = 0;
  double cleaningBill = 0;
  double maidBill = 0;

  List<String> names = ['Hemal', 'Yousuf', 'Imran', 'Saad', 'Ankur'];

  // Function to calculate total expenses for each person
  List<double> calculateTotalExpensesPerPerson() {
    List<double> totalExpensesPerPerson = [];
    for (int i = 0; i < 5; i++) {
      double totalMealCost = bazarCostPerPerson[i] * mealCountPerPerson[i];
      double totalPersonExpenses = totalMealCost +
          electricityBill +
          internetBill +
          gasBill +
          cleaningBill +
          maidBill;
      totalExpensesPerPerson.add(totalPersonExpenses);
    }
    return totalExpensesPerPerson;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Meal Management System'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Enter Bazar Cost and Meal Count for 5 People:'),
            for (int i = 0; i < 5; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${names[i]}\'s Expenses:'),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: 'Bazar Cost'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) => setState(() {
                            bazarCostPerPerson[i] = double.tryParse(value) ?? 0;
                          }),
                        ),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) {
                            int mealsAdded = 0;
                            return AlertDialog(
                              title: Text('Set ${names[i]}\'s Meal Count'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Current Meals: ${mealCountPerPerson[i]}'),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      mealsAdded = int.tryParse(value) ?? 0;
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            mealCountPerPerson[i] = 0;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text('Remove'),
                                      ),
                                      SizedBox(width: 8),
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            mealCountPerPerson[i] += mealsAdded;
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text('Set Meal Count'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        child: Text('Set Meal Count'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => setState(() {
                          mealCountPerPerson[i]++;
                        }),
                        child: Text('Add Meal'),
                      ),
                      SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () => setState(() {
                          if (mealCountPerPerson[i] > 0) {
                            mealCountPerPerson[i]--;
                          }
                        }),
                        child: Text('Remove Meal'),
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(height: 16),
            Text('Enter Additional Expenses:'),
            TextFormField(
              decoration: InputDecoration(labelText: 'Electricity Bill'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                electricityBill = double.tryParse(value) ?? 0;
              }),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Internet Bill'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                internetBill = double.tryParse(value) ?? 0;
              }),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Gas Bill'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                gasBill = double.tryParse(value) ?? 0;
              }),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Cleaning Bill'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                cleaningBill = double.tryParse(value) ?? 0;
              }),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Maid Bill'),
              keyboardType: TextInputType.number,
              onChanged: (value) => setState(() {
                maidBill = double.tryParse(value) ?? 0;
              }),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                List<double> totalExpensesPerPerson = calculateTotalExpensesPerPerson();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Monthly Expenses'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < 5; i++)
                            Text('${names[i]}\'s Expenses: \$${totalExpensesPerPerson[i].toStringAsFixed(2)}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Calculate'),
            ),
          ],
        ),
      ),
    );
  }
}
