import 'package:flutter/material.dart';

class QnA {
  final String question;
  final String answer;

  const QnA(this.question, this.answer);
}

class HelpUserPage extends StatefulWidget {
  const HelpUserPage({super.key});

  @override
  State<HelpUserPage> createState() => _HelpUserPageState();
}

class _HelpUserPageState extends State<HelpUserPage> {
  final List<QnA> qnaList = const [
    QnA("How to use the app?", "You can start by creating an account..."),
    QnA("How to reset password?", "Go to settings and click on 'Reset Password'..."),
    // Add more QnA pairs here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help Center"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: QnASearch(qnaList));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: qnaList.length,
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ExpansionTile(
                title: Text(
                  qnaList[index].question,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      qnaList[index].answer,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8.0),
        ),
      ),
    );
  }
}

class QnASearch extends SearchDelegate<QnA> {
  final List<QnA> qnaList;

  QnASearch(this.qnaList);

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {},
      );

  @override
  Widget buildResults(BuildContext context) {
    final results = qnaList
        .where((qna) => qna.question.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(
        child: Text("No results found."),
      );
    }

    return _buildList(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = qnaList
        .where((qna) => qna.question.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildList(suggestions);
  }

  Widget _buildList(List<QnA> items) => ListView.builder(
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].question),
            subtitle: items[index].answer.isNotEmpty
                ? Text(
                    items[index].answer,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            onTap: () {
              query = items[index].question;
              showResults(context);
            },
          );
        },
      );
}
