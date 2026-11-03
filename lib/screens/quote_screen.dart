import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/quotes_data.dart';
import '../models/quote_model.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final Random _random = Random();
  late Quote _currentQuote;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Load an initial random quote on launch
    _currentIndex = _random.nextInt(quotesList.length);
    _currentQuote = quotesList[_currentIndex];
  }

  void _getNewQuote() {
    if (quotesList.length <= 1) return;

    int newIndex;
    do {
      newIndex = _random.nextInt(quotesList.length);
    } while (newIndex == _currentIndex);

    setState(() {
      _currentIndex = newIndex;
      _currentQuote = quotesList[newIndex];
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(
      ClipboardData(text: '"${_currentQuote.text}" — ${_currentQuote.author}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quote copied to clipboard!'),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote of the Moment'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Quote Display Card
              Card(
                elevation: 0,
                color: theme.colorScheme.surfaceContainerHighest,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Column(
                      key: ValueKey<int>(_currentIndex),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.format_quote_rounded,
                          size: 40,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _currentQuote.text,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '— ${_currentQuote.author}',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Copy Action Button
              IconButton.outlined(
                onPressed: _copyToClipboard,
                icon: const Icon(Icons.copy_rounded),
                tooltip: 'Copy quote',
              ),
              const Spacer(),
              // "New Quote" Primary Action Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton.icon(
                  onPressed: _getNewQuote,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text(
                    'New Quote',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}