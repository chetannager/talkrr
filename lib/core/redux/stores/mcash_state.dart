import 'package:flutter/material.dart';

@immutable
class mCashState {
  double currentWalletAmount = 0;

  mCashState({required this.currentWalletAmount});

  initialState() {
    mCashState(currentWalletAmount: 0);
  }
}
