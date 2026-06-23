import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/models/user_model.dart';

class GoogleAuthService {
  // Criamos uma única instância para usar tanto no login quanto no logout
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserModel> signInWithGoogle() async {
    // CORRIGIDO: Removido o .standard() que quebrava o app
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      throw CustomError('Login cancelado pelo usuário.');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);

    final User? firebaseUser = userCredential.user;

    if (firebaseUser == null) {
      throw CustomError('Não foi possível obter os dados do usuário.');
    }

    return UserModel(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
      photoUrl: firebaseUser.photoURL,
    );
  }

  // ADICIONADO: Agora o seu Repository consegue chamar o encerramento de sessão!
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
