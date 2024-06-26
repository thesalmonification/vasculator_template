import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:vasculink/state_manager.dart';

class ReduxDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<RiskFactor>>(
        converter: (store) => store.state.riskFactors,
        builder: (context, riskFactors) {
          var riskFactorButtons = riskFactors
              .map((riskFactor) => _buildRiskFactorButton(riskFactor))
              .toList();
          var totalScore = riskFactors
              .map((riskFactor) => riskFactor.value ? 1 : 0)
              .reduce((value, element) => value + element);
          riskFactorButtons.add(Text("Total risk score is $totalScore"));
          return Scaffold(
            appBar: AppBar(title: Text("Redux Demo")),
            body: Center(
                child: Column(
              children: riskFactorButtons,
            )),
          );
        });
  }

  Widget _buildRiskFactorButton(RiskFactor riskFactor) {
    return StoreConnector<AppState, VoidCallback>(converter: (store) {
      return () => store
          .dispatch(SetRiskFactorAction(riskFactor.index, !riskFactor.value));
    }, builder: (context, callback) {
      return TextButton(
        onPressed: callback,
        child: Text((riskFactor.value ? "Not " : "") + riskFactor.name),
      );
    });
  }
}
