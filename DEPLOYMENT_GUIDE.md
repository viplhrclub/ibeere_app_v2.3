# Backend Deployment Guide

## Quick Start

This guide covers deploying the Ibeere App backend to Firebase and the server.

### Prerequisites

1. **Firebase CLI**
   ```bash
   npm install -g firebase-tools
   firebase login
   ```

2. **Firebase Project**
   - Project ID: `ibeere-app`
   - Must be created on Firebase Console

3. **Server Access**
   - Host: `api.ibeere.fun`
   - User: `apiib9322`
   - Password: `Og8j58c7RrfeL`

## Deployment Steps

### 1. Deploy Cloud Functions to Firebase

```bash
cd functions
npm install
cd ..
firebase deploy --only functions
```

**Expected Output:**
```
✔  Deploy complete!
Function URL: https://region-ibeere-app.cloudfunctions.net/submitQuizAnswers
Function URL: https://region-ibeere-app.cloudfunctions.net/updateLeaderboardPositions
...
```

### 2. Deploy Firestore Security Rules

```bash
firebase deploy --only firestore:rules
```

**Expected Output:**
```
✔  Firestore Rules have been successfully published.
```

### 3. Create Firestore Indexes

```bash
firebase deploy --only firestore:indexes
```

**Expected Output:**
```
✔  Firestore indexes have been successfully deployed.
```

### 4. Deploy Everything at Once

```bash
firebase deploy
```

## Post-Deployment Verification

### 1. Verify Cloud Functions

```bash
firebase functions:list
```

Should show 8 functions:
- onCreate_UserProfile
- onDelete_UserProfile
- handleMonerooWebhook
- submitQuizAnswers
- updateLeaderboardPositions
- checkAndAwardAchievements
- cleanupOldTransactions
- checkAndAwardMonthlyRewards

### 2. Verify Firestore Rules

In Firebase Console:
1. Go to Firestore → Rules
2. Confirm security rules are published
3. Test with sample queries

### 3. Test API Service

Run in Flutter app:
```dart
// Test sign up
final result = await ApiService.signUp(
  'test@example.com',
  'password123',
  'Test User'
);
print(result);  // Should print: {success: true, uid: '...'}

// Test sign in
final loginResult = await ApiService.signIn(
  'test@example.com',
  'password123'
);
print(loginResult);  // Should print: {success: true, uid: '...'}
```

### 4. Test Quiz Submission

```dart
// Get questions
final questions = await ApiService.getQuestions('general_knowledge');
print('Loaded ${questions.length} questions');

// Submit quiz
final result = await ApiService.submitQuiz(
  uid,
  'quiz_001',
  {0: 0, 1: 2, 2: 1}  // questionId: selectedAnswerIndex
);
print('Score: ${result['score']}, Coins Earned: ${result['coinsEarned']}');
```

### 5. Test Payment Processing

```dart
// Process payment
final paymentResult = await ApiService.processPayment(
  uid,
  100,  // Amount in currency
  'txn_123456'  // Moneroo transaction ID
);
print('Payment: ${paymentResult['status']}');
```

## Troubleshooting

### Issue: "Permission denied" on Firestore Rules

**Solution:**
1. Go to Firebase Console → Firestore → Rules
2. Click "Publish"
3. Wait for rules to be live (usually 1-2 minutes)

### Issue: Cloud Functions timeout

**Solution:**
1. Increase timeout in functions/index.js:
   ```javascript
   functions.runWith({timeoutSeconds: 60})
   ```
2. Redeploy: `firebase deploy --only functions`

### Issue: Moneroo webhook not firing

**Solution:**
1. Configure webhook URL in Moneroo dashboard
2. URL format: `https://region-ibeere-app.cloudfunctions.net/handleMonerooWebhook`
3. Test webhook manually from Moneroo dashboard

### Issue: Leaderboard not updating

**Solution:**
1. Verify scheduled function is deployed
2. Check Cloud Functions logs: `firebase functions:log`
3. Manually trigger: `firebase functions:call updateLeaderboardPositions`

## Server Deployment

To deploy app binary to server:

```bash
# SSH into server
ssh -i path/to/key apiib9322@api.ibeere.fun

# Navigate to app directory
cd /home/apiib9322/ibeere-app

# Copy new APK/build
scp -i path/to/key build/app/outputs/flutter-apk/app-release.apk apiib9322@api.ibeere.fun:/home/apiib9322/ibeere-app/

# Restart app service (if applicable)
systemctl restart ibeere-app
```

## Monitoring

### View Live Logs

```bash
firebase functions:log
```

### Monitor Firestore Usage

1. Firebase Console → Firestore → Usage
2. Check read/write operations
3. Monitor daily bill

### Monitor Cloud Functions

1. Firebase Console → Functions
2. Check invocation count, errors, latency
3. Set up alerts for errors

## Rollback

If something breaks:

```bash
# Deploy previous version from git
git revert HEAD
firebase deploy

# Or manually rollback
firebase deploy --only functions
```

## Next Steps

1. ✅ Deploy Cloud Functions
2. ✅ Deploy Firestore Rules
3. ✅ Deploy Firestore Indexes
4. 🔄 Test all API methods in app
5. 🔄 Test end-to-end flows (auth → quiz → payment)
6. 🔄 Load testing and optimization
7. 🔄 Production rollout

## Contact & Support

**Firebase Project:** ibeere-app
**API Docs:** See `../lib/api_service.dart`
**Cloud Functions:** See `./index.js`
**Firestore Schema:** See `./firestore.rules`
