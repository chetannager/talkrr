import 'package:talkrr/core/redux/actions/account_actions.dart';
import 'package:talkrr/core/redux/stores/account_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:talkrr/utils/utils.dart';

AccountState accountStateReducer(AccountState prevState, dynamic action) {
  if (action is SetLoggedInAction) {
    return _setLoggedIn(prevState, action.AUTH_TOKEN);
  }

  if (action is LogoutAction) {
    return _setLogout(prevState);
  }
  return prevState;
}

AccountState _setLoggedIn(AccountState prevState, String AUTH_TOKEN) {
  setAuthToken(AUTH_TOKEN);
  prevState.AUTH_TOKEN = AUTH_TOKEN;
  prevState.isLoggedIn = true;
  prevState.userDetails = JwtDecoder.decode(AUTH_TOKEN);
  return prevState;
}

AccountState _setLogout(AccountState prevState) {
  removeAuthToken();
  prevState.AUTH_TOKEN = "";
  prevState.isLoggedIn = false;
  prevState.userDetails = {};
  return prevState;
}
