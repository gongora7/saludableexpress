import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInService {
  static String clientId = 'com.cosmonautas.saludableappservice';
  static String redirectUri =
      'https://app.easystore.com.mx/api/callback/sign_in_with_apple';

  Future<String> signIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: clientId,
            redirectUri: Uri.parse(redirectUri),
          ));
      return credential.authorizationCode;
    } catch (e) {
      return null;
    }

    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
  }
}
