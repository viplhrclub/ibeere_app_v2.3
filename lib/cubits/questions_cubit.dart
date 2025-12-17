import 'package:flutter_bloc/flutter_bloc.dart';
import '../api_service.dart';

sealed class QuestionsState {
  const QuestionsState();
}

class QuestionsInitial extends QuestionsState {
  const QuestionsInitial();
}

class QuestionsLoading extends QuestionsState {
  const QuestionsLoading();
}

class QuestionsLoaded extends QuestionsState {
  final List<Map<String, dynamic>> questions;
  const QuestionsLoaded(this.questions);
}

class QuestionsError extends QuestionsState {
  final String message;
  const QuestionsError(this.message);
}

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit() : super(const QuestionsInitial());

  Future<void> getQuestions(String categoryId) async {
    try {
      emit(const QuestionsLoading());
      
      final questions = await ApiService.getQuestions(categoryId);
      
      if (questions.isEmpty) {
        emit(const QuestionsError('No questions found for this category'));
      } else {
        emit(QuestionsLoaded(questions));
      }
    } catch (e) {
      emit(QuestionsError(e.toString()));
    }
  }
  
  Future<Map<String, dynamic>> submitAnswers({
    required String uid,
    required String quizId,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      final result = await ApiService.submitQuiz(
        uid: uid,
        quizId: quizId,
        answers: answers,
      );
      return result;
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
}
