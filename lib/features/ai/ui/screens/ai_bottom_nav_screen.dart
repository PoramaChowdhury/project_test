
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:project/app/app_colors.dart';
import 'package:project/features/account/ui/screens/profile_screen.dart';
import 'package:project/features/ai/ui/ai_assets/ai_api_path.dart';
import 'package:project/features/common/ui/widgets/custom_app_bar.dart';
import 'package:project/features/common/ui/widgets/navbar_app_bar.dart';
import 'package:project/features/home/ui/screens/home_screen.dart';
import 'package:project/features/home/ui/widgets/bottom_nav_bar_widget.dart';

class AiBottomNavScreen extends StatefulWidget {

  const AiBottomNavScreen({super.key, });

  @override
  State<AiBottomNavScreen> createState() => _AiBottomNavScreenState();
}

class _AiBottomNavScreenState extends State<AiBottomNavScreen> {
  int _currentIndex = 1;

  late final GenerativeModel generativeModel;
  final ChatUser currentUser = ChatUser(id: "1", firstName: "ii", lastName: "s");
  final ChatUser gptUser = ChatUser(id: "2", firstName: "Campus", lastName: "Guru");

  List<ChatMessage> messageList = <ChatMessage>[];
  List<ChatUser> typingUsers = <ChatUser>[];

  @override
  void initState() {
    super.initState();

    // Initialize the GenerativeModel
    generativeModel = GenerativeModel(
      model: 'gemini-1.5-flash-latest', // Adjust this model if needed
      apiKey: AiApiPath.chatbotPostApi,  // Make sure you have the right API key
    );
  }

  // Function to format chat titles based on date
  String getChatLabel(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Yesterday";
    } else if (difference <= 7) {
      return "Last Week";
    } else if (difference <= 30) {
      return "This Month";
    } else {
      return "Older";
    }
  }

  // Send a message and get the AI response
  Future<void> getChatResponse(ChatMessage msg) async {
    setState(() {
      messageList.insert(0, msg);
      typingUsers.add(gptUser); // Show that GPT is typing
    });

    // Prepare the prompt for the GenerativeModel
    final prompt = "User: ${msg.text}";

    try {
      final content = [Content.text(prompt)];
      final response = await generativeModel.generateContent(content);
      final responseText = response.text;

      setState(() {
        messageList.insert(
          0,
          ChatMessage(
            user: gptUser,
            createdAt: DateTime.now(),
            text: responseText.toString(),
          ),
        );
      });
    } catch (e) {
      setState(() {
        messageList.insert(
          0,
          ChatMessage(
            user: gptUser,
            createdAt: DateTime.now(),
            text: "Error: ${e.toString()}",
          ),
        );
      });
    } finally {
      setState(() {
        typingUsers.remove(gptUser); // Remove typing indicator
      });
    }
  }


  void _onNavBarTapped(int index) async {
    setState(() {
      _currentIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (index == 1) {
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (index == 2) {
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } else if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? Color(0xFF121212) 
          : Colors.white,
      appBar: const NavBarAppBar(title: 'Campus Guru Ai', automaticallyImplyLeading: false,),
      body: Column(
        children: [
          // Chat Interface
          Expanded(
            child: DashChat(
              currentUser: currentUser,
              typingUsers: typingUsers,
              messageOptions: MessageOptions(
                textColor: Colors.white,
                currentUserContainerColor: Colors.grey.shade300,
                currentUserTextColor: Colors.black,
                  containerColor:Color(0xFF66B2B2),
              ),
              readOnly: false,
              inputOptions: const InputOptions(
                autocorrect: true,
                alwaysShowSend: false,
                cursorStyle: CursorStyle(
                  color: Colors.grey,
                ),
              ),
              onSend: (ChatMessage msg) {
                getChatResponse(msg);
              },
              messages: messageList,
            ),
          ),
          const SizedBox(height: 15,)
        ],
      ),
      bottomNavigationBar: BottomNavBarWidget(
        currentIndex: _currentIndex,
        onNavBarTapped: _onNavBarTapped,
      ),
    );
  }
}



