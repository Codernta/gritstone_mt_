import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gritstone/HiveDB/hive_functions.dart';
import 'package:gritstone/HiveDB/hive_model.dart';
import 'package:gritstone/Providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterTts flutterTts = FlutterTts();

  TextEditingController _textController = TextEditingController();

  bool themeValue = false;

  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: null,
      body: appBody(),
    );
  }

  appBody() {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sizedBx(),
              dayNightSwitch(),
              sizedBx(),
              textFieldContainer(),
              sizedBx(),
              savedItemTitle(),
              sizedBx(),
              savedItemList()
            ],
          )),
    );
  }

  sizedBx() {
    return SizedBox(
      height: 20,
    );
  }

  dayNightSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0,top: 40),
          child: Text('GRITSTONE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Color(0xff800000),fontFamily: 'Quicksand'),),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 40),
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.light_mode,
              color: themeValue ? Colors.white : Colors.black,
            ),
            label: Text(
              themeValue ? 'light mode' : 'dark mode',
              style: TextStyle(color: themeValue ? Colors.white : Colors.black,fontFamily: 'Quicksand'),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(10),
              primary: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {
              setState(() {
                themeValue = !themeValue;
              });
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ),
      ],
    );
  }

  textFieldContainer() {
    return Container(
      height: 200,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: _textController,
                maxLines: 8,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter text to save or read..',
                    labelStyle: TextStyle(fontFamily: 'Quicksand')
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () => speak(_textController.text),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Read',
                      style: TextStyle(color: Color(0xff800000),fontSize: 18,fontFamily: 'Quicksand'),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () => onAddTextAddClicked(_textController.text),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Color(0xff800000),fontSize: 18,fontFamily: 'Quicksand'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  savedItemTitle() {
    return Text('Saved Items',style: TextStyle(color: Color(0xff800000),fontSize: 25,fontWeight: FontWeight.w500,fontFamily: 'Quicksand'));
  }

  savedItemList() {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.5,
      child: ValueListenableBuilder(
          valueListenable:addTextNotifier ,
          builder: (BuildContext ctx, List<AddTextModel> textList, Widget? child) {
            return textList.length == 0 ? noData() : ListView.separated(
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                itemCount: textList.length,
                itemBuilder: (context, index) {
                  final data = textList[index];
                  return Container(
                      height: 80,
                      child: listTiles(index,data.textToSave.toString())
                  );
                }
            );
          }
      ),
    );
  }

  listTiles(int index,String texts) {
    int indxx= index+1;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xff800000),
        radius: 50,
        child: Text(
          indxx.toString(),style: TextStyle(fontSize: 20,fontFamily: 'Quicksand'),), // Replace this with your desired icon or image
      ),
      title: Text(texts.toString()),
      trailing: IconButton(
        icon: Icon(Icons.delete,color: Colors.red),
        onPressed: () =>
            deleteTextFromList(index),
      ),
    );
  }


  Future<void> onAddTextAddClicked( String textToSave) async {
    final textObject = AddTextModel( textToSave: textToSave);
    addToTextToList(textObject);
  }

  noData() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.note_alt_rounded,size: 100,color: Colors.grey,
            ),
            SizedBox(height: 40,),
            Text(
              'No Text Saved!',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.blue.shade900,
                  fontFamily: 'Quicksand'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
