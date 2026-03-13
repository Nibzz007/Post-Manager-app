# Firebase Auth setup

The app uses **Firebase Authentication** (email/password) for sign in and sign up.

## 1. Create a Firebase project (if you haven’t)

- Go to [Firebase Console](https://console.firebase.google.com/)
- Create a project or use an existing one
- Enable **Authentication** → **Sign-in method** → **Email/Password** (enable it)

## 2. Add your app to the project

- In the project overview, add an **Android** app (and optionally iOS)
- Use your app’s package name: `com.example.post_manager_app` (or whatever is in `android/app/build.gradle.kts` → `applicationId`)
- Download **google-services.json** and place it in `android/app/`

## 3. Generate Flutter Firebase config

From the project root run:

```bash
dart run flutterfire_cli:configure
```

This will:

- Use your `google-services.json` (and iOS config if present)
- Generate `lib/firebase_options.dart` with your project’s config

If the CLI isn’t installed:

```bash
dart pub global activate flutterfire_cli
dart run flutterfire_cli:configure
```

## 4. Run the app

After `firebase_options.dart` is generated, run the app as usual. Sign in and sign up will use Firebase Auth.
