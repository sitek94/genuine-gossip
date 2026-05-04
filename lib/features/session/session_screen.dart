import 'package:flutter/material.dart';

import '../questions/deck_definition.dart';
import '../questions/question.dart';
import 'question_card.dart';
import 'question_session.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({
    super.key,
    required this.deck,
    required this.questions,
  });

  final DeckDefinition deck;
  final List<Question> questions;

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  late QuestionSession _session;

  @override
  void initState() {
    super.initState();
    _session = QuestionSession.start(
      deck: widget.deck,
      questions: widget.questions,
    );
  }

  void _onNext() {
    setState(() => _session = _session.next());
  }

  void _onRestart() {
    setState(() {
      _session = QuestionSession.start(
        deck: widget.deck,
        questions: widget.questions,
      );
    });
  }

  void _onChooseAnotherDeck() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.deck.title),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: _session.isEmpty
              ? _EmptyDeckView(onChooseAnotherDeck: _onChooseAnotherDeck)
              : _session.isFinished
                  ? _FinishedView(
                      total: _session.totalCount,
                      onRestart: _onRestart,
                      onChooseAnotherDeck: _onChooseAnotherDeck,
                    )
                  : _ActiveSessionView(
                      session: _session,
                      theme: theme,
                      onNext: _onNext,
                      onChooseAnotherDeck: _onChooseAnotherDeck,
                    ),
        ),
      ),
    );
  }
}

class _ActiveSessionView extends StatelessWidget {
  const _ActiveSessionView({
    required this.session,
    required this.theme,
    required this.onNext,
    required this.onChooseAnotherDeck,
  });

  final QuestionSession session;
  final ThemeData theme;
  final VoidCallback onNext;
  final VoidCallback onChooseAnotherDeck;

  @override
  Widget build(BuildContext context) {
    final question = session.currentQuestion!;
    final position = session.completedCount + 1;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '$position / ${session.totalCount}',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: QuestionCard(
              key: ValueKey<String>(question.id),
              question: question,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: onNext,
          child: const Text('Next'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: onChooseAnotherDeck,
          child: const Text('Choose another deck'),
        ),
      ],
    );
  }
}

class _FinishedView extends StatelessWidget {
  const _FinishedView({
    required this.total,
    required this.onRestart,
    required this.onChooseAnotherDeck,
  });

  final int total;
  final VoidCallback onRestart;
  final VoidCallback onChooseAnotherDeck;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'You finished this deck',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$total questions answered',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        FilledButton(
          onPressed: onRestart,
          child: const Text('Restart deck'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: onChooseAnotherDeck,
          child: const Text('Choose another deck'),
        ),
      ],
    );
  }
}

class _EmptyDeckView extends StatelessWidget {
  const _EmptyDeckView({required this.onChooseAnotherDeck});

  final VoidCallback onChooseAnotherDeck;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'No questions in this deck yet.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
        FilledButton(
          onPressed: onChooseAnotherDeck,
          child: const Text('Choose another deck'),
        ),
      ],
    );
  }
}
