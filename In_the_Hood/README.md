# In_the_Hood

This folder contains a manually scaffolded Flutter application mirroring the default `flutter create` counter app. The tooling is not available in this environment, so the project was created by hand with the standard `main.dart`, lint configuration, and widget test template.

## Bootstrapping Flutter locally

Use the included wrapper to download a pinned Flutter SDK into `.flutter-sdk/` when the SDK is missing:

```bash
./tool/flutterw --version
```

The wrapper respects `FLUTTER_VERSION` if you need to override the default `3.19.6` release. It can also consume an existing SDK via `FLUTTER_SDK_PATH`, or a custom download mirror via `FLUTTER_STORAGE_BASE_URL` when direct access to Google's storage is blocked. Once the SDK is present, you can run tests or other commands via the wrapper, for example:

```bash
./tool/flutterw test
```

## Generating platform folders

To complete platform-specific files, run the following on a machine with Flutter installed:

```bash
flutter create .
```

This will add Android, iOS, web, and other platform folders while preserving the existing Dart sources.
