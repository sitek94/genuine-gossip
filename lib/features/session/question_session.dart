import 'dart:math';

import '../questions/deck_definition.dart';
import '../questions/question.dart';

final class QuestionSession {
  const QuestionSession._({
    required this.deck,
    required this.questions,
    required this.currentIndex,
  });

  factory QuestionSession.start({
    required DeckDefinition deck,
    required List<Question> questions,
    Random? random,
  }) {
    final shuffledQuestions = List<Question>.of(questions)..shuffle(random);
    return QuestionSession._(
      deck: deck,
      questions: List.unmodifiable(shuffledQuestions),
      currentIndex: 0,
    );
  }

  final DeckDefinition deck;
  final List<Question> questions;
  final int currentIndex;

  bool get isEmpty => questions.isEmpty;

  bool get isFinished => isEmpty || currentIndex >= questions.length;

  Question? get currentQuestion => isFinished ? null : questions[currentIndex];

  int get totalCount => questions.length;

  int get completedCount =>
      currentIndex > totalCount ? totalCount : currentIndex;

  QuestionSession next() {
    if (isFinished) return this;
    return QuestionSession._(
      deck: deck,
      questions: questions,
      currentIndex: currentIndex + 1,
    );
  }

  QuestionSession restart({Random? random}) {
    return QuestionSession.start(
      deck: deck,
      questions: questions,
      random: random,
    );
  }
}
