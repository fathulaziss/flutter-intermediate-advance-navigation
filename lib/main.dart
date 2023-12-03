import 'package:declarative_navigation/screen/quote_detail_screen.dart';
import 'package:declarative_navigation/screen/quotes_list_screen.dart';
import 'package:flutter/material.dart';

import 'model/quote.dart';

void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatefulWidget {
  const QuotesApp({Key? key}) : super(key: key);

  @override
  State<QuotesApp> createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  String? selectedQuote;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quotes App',
      // home: QuotesListScreen(quotes: quotes),
      home: Navigator(
        pages: [
          MaterialPage(
            key: const ValueKey("QuotesListPage"),
            child: QuotesListScreen(
              quotes: quotes,
              onTapped: (String quoteId) {
                setState(() {
                  selectedQuote = quoteId;
                });
              },
            ),
          ),
          if (selectedQuote != null)
            MaterialPage(
              key: ValueKey("QuoteDetailsPage-$selectedQuote"),
              child: QuoteDetailsScreen(quoteId: selectedQuote!),
            ),
        ],
        onPopPage: (route, result) {
          final didPop = route.didPop(result);

          if (!didPop) {
            return false;
          }

          setState(() {
            selectedQuote = null;
          });

          return true;
        },
      ),
    );
  }
}
