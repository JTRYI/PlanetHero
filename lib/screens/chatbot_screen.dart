import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:planethero_application/constant.dart';
import 'package:http/http.dart' as http;
import '../models/chat-message.dart';

const backgroundColor = Color(0xFF028C5D);
const botBackgroundColor = Color(0xFF00B87C);

class ChatbotScreen extends StatefulWidget {
  //declare route name
  static String routeName = '/chatbot';

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  //for chatbot replying
  late bool isLoading;
  TextEditingController _textController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  Future<String> generateResponse(String prompt) async {
    const gptApiKey = gptApiSecretKey;
    var url = Uri.https("api.openai.com", "/v1/completions");
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $gptApiKey'
        },
        body: jsonEncode(//jsonEncode is basically JSON.stringify
            {
          'model': 'text-davinci-003',
          'prompt': prompt,
          'temperature': 0,
          'max_tokens': 1000,
        }));

    //decode the response or JSON.parse it like in JS
    Map<String, dynamic> newResponse = jsonDecode(response.body);
    // Check if 'choices' is not null and is an array
    if (newResponse['choices'] != null && newResponse['choices'] is List) {
        List<dynamic> choices = newResponse['choices'];
        
        // Check if there are elements in the choices array
        if (choices.isNotEmpty) {
            String generatedText = choices[0]['text'];
            
            // Remove leading whitespace characters
            generatedText = generatedText.trim();
            
            return generatedText;
        }
    }

    // Return a default response or handle the error scenario
    return "Sorry, I couldn't generate a response.";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: Text(
            "Hero Chatbot",
            style: TextStyle(fontFamily: 'Roboto Bold'),
          ),
          backgroundColor: botBackgroundColor,
        ),
        backgroundColor: backgroundColor,
        body: Column(
          children: [
            //chat body
            Expanded(child: _buildChat()),
            Visibility(
                visible: isLoading,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )),
            Row(
              children: [
                //input field
                _buildChatInput(),

                //submit button
                _buildChatSubmit(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Expanded _buildChatInput() {
    return Expanded(
        child: TextField(
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(color: Colors.white),
      controller: _textController,
      decoration: InputDecoration(
        fillColor: botBackgroundColor,
        filled: true,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    ));
  }

  Widget _buildChatSubmit() {
    return Visibility(
        visible: !isLoading,
        child: Container(
          color: botBackgroundColor,
          child: IconButton(
            icon: Icon(Icons.send_rounded, color: Colors.greenAccent.shade400),
            onPressed: () {
              //display user input
              setState(() {
                _messages.add(ChatMessage(
                    text: _textController.text,
                    chatMessageType: ChatMessageType.user));

                isLoading = true;
              });
              var input = _textController.text;
              _textController.clear();
              Future.delayed(Duration(milliseconds: 50))
                  .then((value) => _scrollDown());

              //cal chatgpt api
              generateResponse(input).then((value) {
                setState(() {
                  isLoading = false;
                  _messages.add(ChatMessage(
                      text: value, chatMessageType: ChatMessageType.bot));
                });
              });

              //display chatbot response
              _textController.clear();
              Future.delayed(Duration(milliseconds: 50))
                  .then((value) => _scrollDown());
            },
          ),
        ));
  }

  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  ListView _buildChat() {
    return ListView.builder(
        itemCount: _messages.length, //messages array length
        controller: _scrollController, //for scrolling of list view
        itemBuilder: ((context, index) {
          var message = _messages[index];
          return ChatMessageWidget(
            text: message.text,
            chatMessageType: message.chatMessageType,
          );
        }));
  }
}

class ChatMessageWidget extends StatelessWidget {
  final String text;
  final ChatMessageType chatMessageType;
  const ChatMessageWidget({required this.text, required this.chatMessageType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(16),
      color: chatMessageType == ChatMessageType.bot
          ? botBackgroundColor
          : backgroundColor,
      child: Row(children: [
        chatMessageType == ChatMessageType.bot
            ? Container(
                margin: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: Transform.scale( //make avatar png smaller inside Circle Avatar widget
                    scale: 0.7,  
                    child: Image.asset(
                      'images/chatbot-avatar.png',
                    ),
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.only(right: 16),
                child: CircleAvatar(
                  child: Icon(Icons.person),
                ),
              ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
            )
          ],
        ))
      ]),
    );
  }
}
