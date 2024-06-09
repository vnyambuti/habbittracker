import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habbittrack/Theme/theme_provider.dart';
import 'package:habbittrack/components/habbit_tile.dart';
import 'package:habbittrack/database/habbit_database.dart';
import 'package:habbittrack/models/habbit.dart';
import 'package:habbittrack/util/util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<Habbitdatabase>(context, listen: false).readhabbits();
    super.initState();
  }

  void checkhabbitodd(bool? value, Habbit habit) {
    if (value != null) {
      context.read<Habbitdatabase>().updateHabbitCompletion(habit.id, value);
    }
  }

  final addcontroller = TextEditingController();
  void newHabbit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("New Habbit"),
        content: TextField(
          controller: addcontroller,
          decoration: InputDecoration(hintText: "Eating", labelText: "Habbit"),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              addcontroller.clear();
              Provider.of<Habbitdatabase>(context, listen: false)
                  .addHabbit(addcontroller.text);
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Habbits"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => newHabbit(),
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Icon(Icons.work)),
            ListTile(
              leading: Icon(Icons.sunny),
              title: Text("Theme"),
              trailing: CupertinoSwitch(
                value: Provider.of<ThemeProvider>(context).isDark,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toogleTheme(),
              ),
            )
          ],
        ),
      ),
      body: _buildHabbitList(),
    );
  }

  Widget _buildHabbitList() {
    final habbitdb = context.watch<Habbitdatabase>();
    List<Habbit> currhabbits = habbitdb.habbits;
    return ListView.builder(
      itemCount: currhabbits.length,
      itemBuilder: (context, index) {
        final habb = currhabbits[index];

        bool isCompleteToday = isHabbitCompletedTOday(habb.completedDays);

        return HabbitTile(
            isCompleted: isCompleteToday,
            text: habb.name,
            onChanged: (p0) => checkhabbitodd(p0, habb));
      },
    );
  }
}
