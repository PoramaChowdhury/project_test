
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import 'package:project/features/ai/ui/ai_assets/ai_api_path.dart';


class AiChatController extends GetxController {
  // Observable messages list
  var messages = <ChatMessage>[].obs; // Make sure this is an observable

  final ChatUser currentUser = ChatUser(id: "1", firstName: "User", lastName: "Name");
  final ChatUser gptUser = ChatUser(id: "2", firstName: "Chatbot", lastName: "Bot");

  late final GenerativeModel generativeModel;

  @override
  void onInit() {
    super.onInit();
    generativeModel = GenerativeModel(
      model: 'gemini-1.5-flash-latest', // Adjust model if needed
      apiKey: AiApiPath.chatbotPostApi, // Ensure the correct API key here
    );
  }

  // Send message and get AI response
  Future<void> sendMessage(String text) async {
    final userMessage = ChatMessage(
      user: currentUser,
      createdAt: DateTime.now(),
      text: text,
    );

    // Add user message to the observable list
    messages.insert(0, userMessage);

    // Generate AI response
    final prompt = "User: $text";

    try {
      final content = [Content.text(prompt)];
      final response = await generativeModel.generateContent(content);
      final responseText = response.text;

      // Add AI response to the observable list
      messages.insert(
        0,
        ChatMessage(
          user: gptUser,
          createdAt: DateTime.now(),
          text: responseText.toString(),
        ),
      );
    } catch (e) {
      // Handle errors (e.g., network issues)
      messages.insert(
        0,
        ChatMessage(
          user: gptUser,
          createdAt: DateTime.now(),
          text: "Error: ${e.toString()}",
        ),
      );
    }
  }
}
