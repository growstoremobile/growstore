import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:growstore/core/errors/custom_error.dart';
import 'package:growstore/features/auth/models/user_model.dart';

class GoogleAuthService {
  // Mudança 1: Criamos UMA única instância do GoogleSignIn para usar na classe toda
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserModel> signInWithGoogle() async {
    // Mudança 2: Usamos a variável '_googleSignIn' aqui em vez de tentar recriar do zero
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn
        .standard();

    if (googleUser == null) {
      throw CustomError('Login cancelado pelo usuário.');
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken:
          googleAuth.accessToken, // Aqui já está com o 'T' maiúsculo perfeito!
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

  Future<void> signOut() async {
    // Mudança 3: Usamos a mesma instância aqui para fazer o log out com segurança
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
