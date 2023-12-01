import 'package:talkrr/core/redux/reducers/account_reducer.dart';
import 'package:talkrr/core/redux/stores/app_state.dart';

AppState rootReducers(AppState state, action) => AppState(
      accountStateReducer(state.account, action),
    );
