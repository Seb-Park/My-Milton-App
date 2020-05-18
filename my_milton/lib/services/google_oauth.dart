import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_milton/services/google_user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//auth change user stream
Stream<AppUser> get userStream {
//  print(((FirebaseUser user)=>userFromFirebaseUser(user).username));
  return _auth.onAuthStateChanged
//      .map((FirebaseUser user) => userFromFirebaseUser(user));
      .map(userFromFirebaseUser);
}

AppUser userFromFirebaseUser(FirebaseUser currentUser) {
  return currentUser != null
      ? AppUser(
          username: currentUser.displayName,
          id: currentUser.uid,
          email: currentUser.email,
          phoneNumber: currentUser.phoneNumber,
          photoUrl: currentUser.photoUrl)
      : null;
}

Future<AppUser> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  userFromFirebaseUser(currentUser);
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  print("User Sign Out" );
}