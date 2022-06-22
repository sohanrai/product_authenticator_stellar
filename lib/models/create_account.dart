import 'dart:typed_data';

import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';

Future<String?> createAccount({
  required StellarSDK sdk,
  required Network network,
  required String serialNo,
  required String modelName,
  required String dealerName,
  required String MRP,
}) async {
  final sourceKeyPair = KeyPair.fromSecretSeed(
    "SAEIHXPDK4LAZXIC6YZIGDTCNJQZHFJ5FMTYSXG6OUVBYLEB3LV5HMP5",
  );

  //GA7GMOVYB6QLXHKXVVTSZR3XOHM3KBCPLDV5YKSZAP4P56IYOAK6DPSO - Public Key

  final newAccountKeyPair = KeyPair.random();

  final createAccountBuilder = CreateAccountOperationBuilder(
    newAccountKeyPair.accountId,
    "20",
  );

  final setOptionsBuilder = SetOptionsOperationBuilder()
    ..setSourceAccount(newAccountKeyPair.accountId)
    ..setSigner(sourceKeyPair.xdrSignerKey, 1);

  final serialNoBuilder = ManageDataOperationBuilder(
    "Serial No",
    Uint8List.fromList(serialNo.codeUnits),
  )..setSourceAccount(newAccountKeyPair.accountId);

  final addModelNameBuilder = ManageDataOperationBuilder(
    "Model Name",
    Uint8List.fromList(modelName.codeUnits),
  )..setSourceAccount(newAccountKeyPair.accountId);

  final dealerNameBuilder = ManageDataOperationBuilder(
    "Dealer Name",
    Uint8List.fromList(dealerName.codeUnits),
  )..setSourceAccount(newAccountKeyPair.accountId);
  final MRPBuilder = ManageDataOperationBuilder(
    "MRP",
    Uint8List.fromList(MRP.codeUnits),
  )..setSourceAccount(newAccountKeyPair.accountId);

  final sourceAccount = await sdk.accounts.account(
    sourceKeyPair.accountId,
  );

  final transactionBuilder = TransactionBuilder(sourceAccount)
    ..addOperation(createAccountBuilder.build())
    ..addOperation(setOptionsBuilder.build())
    ..addOperation(serialNoBuilder.build())
    ..addOperation(addModelNameBuilder.build())
    ..addOperation(dealerNameBuilder.build())
    ..addOperation(MRPBuilder.build());

  final transaction = transactionBuilder.build()
    ..sign(sourceKeyPair, network)
    ..sign(newAccountKeyPair, network);

  final result = await sdk.submitTransaction(transaction);

  return sourceKeyPair.accountId;
  // return newAccountKeyPair.accountId;
}
