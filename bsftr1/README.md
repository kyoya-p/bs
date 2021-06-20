# bsftr

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

プロジェクト構成
----
### Project初期化
```
flutter create bsftr1
```

### Firestore組み込み

pubspeck.yaml変更点
```
flutter pub add cloud_firestore
flutter pub add firebase_auth
flutter pub get
```
``` 
dependencies:
  cloud_firestore: ^2.2.2
  firebase_auth: ^1.4.1
```

index.html:
```
<script src="https://www.gstatic.com/firebasejs/8.6.5/firebase-app.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.6.5/firebase-analytics.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.6.5/firebase-auth.js"></script>
<script src="https://www.gstatic.com/firebasejs/8.6.5/firebase-firestore.js"></script>
<script>
      var firebaseConfig = {
        apiKey: //... 
        // ...
      };
      firebase.initializeApp(firebaseConfig);
</script>
```
