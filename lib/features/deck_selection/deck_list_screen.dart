import 'package:flutter/material.dart';

import '../questions/deck_catalog.dart';
import '../questions/deck_definition.dart';
import '../session/session_screen.dart';
import 'deck_card.dart';

class DeckListScreen extends StatelessWidget {
  const DeckListScreen({super.key});

  void _openDeck(BuildContext context, DeckDefinition deck) {
    final questions = questionsForDeck(deck);
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => SessionScreen(
          deck: deck,
          questions: questions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 4),
                child: Text(
                  'Questions',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Pick a deck to start a conversation.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: deckCatalog.length,
                  itemBuilder: (context, index) {
                    final deck = deckCatalog[index];
                    return DeckCard(
                      title: deck.title,
                      description: deck.description,
                      onTap: () => _openDeck(context, deck),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
