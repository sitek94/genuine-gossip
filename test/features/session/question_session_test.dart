import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:questions_app/features/questions/deck_definition.dart';
import 'package:questions_app/features/questions/question.dart';
import 'package:questions_app/features/session/question_session.dart';

const _deck = DeckDefinition(
  id: DeckId.shuffleEverything,
  title: 'Test',
  description: 'Test deck',
);

List<Question> _makeQuestions(int count) {
  return List<Question>.generate(
    count,
    (i) => Question(
      id: 'q_${i.toString().padLeft(3, '0')}',
      text: 'Question $i',
      topic: QuestionTopic.connection,
      vibe: QuestionVibe.reflective,
      explicitness: QuestionExplicitness.none,
      format: QuestionFormat.question,
    ),
  );
}

void main() {
  group('QuestionSession.start', () {
    test('preserves all provided questions', () {
      final questions = _makeQuestions(8);
      final session = QuestionSession.start(
        deck: _deck,
        questions: questions,
        random: Random(1),
      );
      expect(session.totalCount, questions.length);
      expect(
        session.questions.map((q) => q.id).toSet(),
        questions.map((q) => q.id).toSet(),
      );
    });

    test('contains no duplicate question IDs', () {
      final questions = _makeQuestions(10);
      final session = QuestionSession.start(
        deck: _deck,
        questions: questions,
        random: Random(1),
      );
      final ids = session.questions.map((q) => q.id).toList();
      expect(ids.toSet().length, ids.length);
    });

    test('current question is non-null for non-empty input', () {
      final session = QuestionSession.start(
        deck: _deck,
        questions: _makeQuestions(3),
      );
      expect(session.currentQuestion, isNotNull);
      expect(session.isFinished, isFalse);
    });

    test('empty input starts finished', () {
      final session = QuestionSession.start(deck: _deck, questions: const []);
      expect(session.isEmpty, isTrue);
      expect(session.isFinished, isTrue);
      expect(session.currentQuestion, isNull);
      expect(session.totalCount, 0);
    });
  });

  group('QuestionSession.next', () {
    test('advances progress', () {
      final session = QuestionSession.start(
        deck: _deck,
        questions: _makeQuestions(3),
        random: Random(1),
      );
      expect(session.completedCount, 0);
      final next = session.next();
      expect(next.completedCount, 1);
      expect(next.currentQuestion, isNotNull);
    });

    test('reaches finished after stepping through all questions', () {
      var session = QuestionSession.start(
        deck: _deck,
        questions: _makeQuestions(4),
        random: Random(1),
      );
      for (var i = 0; i < 4; i++) {
        session = session.next();
      }
      expect(session.isFinished, isTrue);
      expect(session.currentQuestion, isNull);
      expect(session.completedCount, 4);
    });

    test('next after finished is safe and remains finished', () {
      var session = QuestionSession.start(
        deck: _deck,
        questions: _makeQuestions(2),
        random: Random(1),
      );
      session = session.next().next().next().next();
      expect(session.isFinished, isTrue);
      expect(session.currentQuestion, isNull);
    });

    test('no question ID repeats across the session order', () {
      var session = QuestionSession.start(
        deck: _deck,
        questions: _makeQuestions(6),
        random: Random(2),
      );
      final visited = <String>[];
      while (!session.isFinished) {
        visited.add(session.currentQuestion!.id);
        session = session.next();
      }
      expect(visited.toSet().length, visited.length);
      expect(visited.length, 6);
    });
  });

  group('QuestionSession.restart', () {
    test('returns a fresh session at the start', () {
      var session = QuestionSession.start(
        deck: _deck,
        questions: _makeQuestions(3),
        random: Random(1),
      );
      session = session.next();
      final restarted = session.restart(random: Random(1));
      expect(restarted.completedCount, 0);
      expect(restarted.totalCount, 3);
      expect(restarted.isFinished, isFalse);
    });
  });
}
