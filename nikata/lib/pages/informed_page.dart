import 'package:flutter/material.dart';
import 'package:nikata/pages/essentials.dart';


class InformedPage extends StatefulWidget {
  const InformedPage({super.key});

  @override
  State<InformedPage> createState() => _InformedPageState();
}

class _InformedPageState extends State<InformedPage> {
  List<String> chatIDList = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController chatIDFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch from database
  }

  bool isValidChatID(String chatID) {
    if (chatID == '') {
      return false;
    }
    return ((int.tryParse(chatID) != null) && (chatID.length <= 10));
  }

  void addChatID(String chatID) {
    if (isValidChatID(chatID)) {
      setState(() {
        chatIDList.add(chatID);
        chatIDFieldController.clear();
        // deposit in database
      });
    }
  }

  void deleteChatID(int index) {
    setState(() {
      chatIDList.removeAt(index);
      // deposit in database
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sidePageAppBar(
        title: 'Informed',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              'Note:\n- Invalid ChatIDs will not be notified.\n- To make sure a Telegram ChatID can be notified, it is necessary to first initiate a conversation with the @nikatadoota_bot on Telegram.\n- To Check the ChatID of a telegram account, search up and contact the --------- bot on Telegram to obtain your chat ID.',
              style: TextStyle(
                color: Colors.yellow,
                fontFamily: 'FiraCode',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: customTextField(
              controller: chatIDFieldController,
              labelText: 'Enter a valid Telegram ChatID',
              validator: (value) {
                if (!isValidChatID(value!)) {
                  return 'Invalid ChatID';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: SizedBox(
              width: 500,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.yellow,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addChatID(chatIDFieldController.text);
                  }
                },
                child: Text('Add ChatID'),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatIDList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ListTile(
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.yellow,
                      ),
                      onPressed: () {
                        deleteChatID(index);
                      },
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        color: Colors.yellow,
                      ),
                    ),
                    textColor: Colors.yellow,
                    tileColor: Colors.black,
                    title: Text(chatIDList[index]),
                    // You can customize the list tile as needed
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
    );
  }

  @override
  void dispose() {
    chatIDFieldController.dispose();
    super.dispose();
  }
}