import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class ChatWithDev extends StatelessWidget {
  const ChatWithDev({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {'text': 'مرحبًا! كيف يمكنني مساعدتك؟', 'isSentByMe': false},
      {'text': 'أحتاج إلى مساعدة في فلاتر.', 'isSentByMe': true},
      {'text': 'بالطبع! بماذا تحتاج المساعدة؟', 'isSentByMe': false},
      {'text': 'كيف يمكنني إدارة الحالة بكفاءة؟', 'isSentByMe': true},
      {'text': 'يمكنك استخدام Provider أو Riverpod أو Bloc!', 'isSentByMe': false},
      {'text': '', 'isSentByMe': false, 'isSupportBubble': true},

    ];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: false,
        leading: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back_ios),
            ),
            const CircleAvatar(
              backgroundImage: AssetImage(SenseiConst.mostafaSenseiogo),
            ),
          ],
        ),
        title: const Text(
          'Mostafa Sensei',
        ),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.call),),
          IconButton(onPressed: () {} , icon:const Icon(Icons.camera), ),

        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  text: messages[index]['text'],
                  isSentByMe: messages[index]['isSentByMe'],
                  isSupportBubble: messages[index].containsKey('isSupportBubble'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'أرسل رسالة',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final bool isSupportBubble;

  const ChatBubble({
    required this.text,
    required this.isSentByMe,
    this.isSupportBubble = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSentByMe)
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(SenseiConst.mostafaSenseiogo),
                radius: 16.0,
              ),
            ),
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: isSentByMe
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: isSupportBubble
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.link, color: Colors.blue),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.share, color: Colors.green),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: isSentByMe
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

