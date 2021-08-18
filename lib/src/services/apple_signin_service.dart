import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInService {
  static void signIn() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    print(credential);

    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
  }
}
