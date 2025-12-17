import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  /// User authentication service
  static Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Create user document
      await _db.collection('users').doc(userCred.user!.uid).set({
        'uid': userCred.user!.uid,
        'email': email,
        'fullName': fullName,
        'createdAt': FieldValue.serverTimestamp(),
        'coins': 0,
        'balance': 0.0,
        'isVerified': false,
      });
      
      return {'success': true, 'uid': userCred.user!.uid};
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'error': e.message};
    }
  }
  
  /// Sign in user
  static Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return {'success': true, 'uid': userCred.user!.uid};
    } on FirebaseAuthException catch (e) {
      return {'success': false, 'error': e.message};
    }
  }
  
  /// Get user profile
  static Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    try {
      final doc = await _db.collection('users').doc(uid).get();
      return doc.data();
    } catch (e) {
      return null;
    }
  }
  
  /// Update user coins
  static Future<bool> updateUserCoins(String uid, int coinsToAdd) async {
    try {
      await _db.collection('users').doc(uid).update({
        'coins': FieldValue.increment(coinsToAdd),
      });
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Get quiz questions
  static Future<List<Map<String, dynamic>>> getQuestions(String categoryId) async {
    try {
      final snapshot = await _db
        .collection('questions')
        .where('category', isEqualTo: categoryId)
        .limit(10)
        .get();
      
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      return [];
    }
  }
  
  /// Submit quiz answers
  static Future<Map<String, dynamic>> submitQuiz({
    required String uid,
    required String quizId,
    required List<Map<String, dynamic>> answers,
  }) async {
    try {
      int score = 0;
      for (var answer in answers) {
        if (answer['isCorrect'] == true) score++;
      }
      
      final result = {
        'uid': uid,
        'quizId': quizId,
        'score': score,
        'totalQuestions': answers.length,
        'submittedAt': FieldValue.serverTimestamp(),
      };
      
      await _db.collection('quiz_results').add(result);
      
      // Award coins for correct answers
      await updateUserCoins(uid, score * 10);
      
      return {'success': true, 'score': score, 'coinsEarned': score * 10};
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
  
  /// Process wallet transaction
  static Future<Map<String, dynamic>> processPayment({
    required String uid,
    required double amount,
    required String transactionId,
  }) async {
    try {
      // Calculate coins (100 coins = 1 unit currency)
      int coinsToAdd = (amount * 100).toInt();
      
      // Record transaction
      await _db.collection('transactions').add({
        'uid': uid,
        'amount': amount,
        'coins': coinsToAdd,
        'transactionId': transactionId,
        'status': 'completed',
        'timestamp': FieldValue.serverTimestamp(),
      });
      
      // Update user balance
      await _db.collection('users').doc(uid).update({
        'balance': FieldValue.increment(amount),
        'coins': FieldValue.increment(coinsToAdd),
      });
      
      return {
        'success': true,
        'coinsAdded': coinsToAdd,
        'transactionId': transactionId,
      };
    } catch (e) {
      return {'success': false, 'error': e.toString()};
    }
  }
  
  /// Get leaderboard
  static Future<List<Map<String, dynamic>>> getLeaderboard({int limit = 100}) async {
    try {
      final snapshot = await _db
        .collection('users')
        .orderBy('coins', descending: true)
        .limit(limit)
        .get();
      
      return snapshot.docs.map((doc) => {
        ...doc.data(),
        'rank': snapshot.docs.indexOf(doc) + 1,
      }).toList();
    } catch (e) {
      return [];
    }
  }
  
  /// Get user achievements/badges
  static Future<List<Map<String, dynamic>>> getUserBadges(String uid) async {
    try {
      final snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('badges')
        .get();
      
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      return [];
    }
  }
  
  /// Award badge
  static Future<bool> awardBadge({
    required String uid,
    required String badgeId,
    required String badgeName,
  }) async {
    try {
      await _db
        .collection('users')
        .doc(uid)
        .collection('badges')
        .doc(badgeId)
        .set({
          'id': badgeId,
          'name': badgeName,
          'awardedAt': FieldValue.serverTimestamp(),
        });
      return true;
    } catch (e) {
      return false;
    }
  }
}
