import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spenza/helpers/fireStore_pref_mixin.dart';
import 'package:spenza/ui/receipts/data/receipt_model.dart';
import 'package:spenza/utils/firestore_constants.dart';
import 'package:spenza/utils/spenza_extensions.dart';

part 'fetch_receipt_provider.g.dart';

@riverpod
class FetchReciptProvider extends _$FetchReciptProvider with FirestoreAndPrefsMixin{

  @override
  FutureOr<List<ReceiptModel>> build() {
    return [];
  }

  Future<List<ReceiptModel>> fetchReceipt(String path) async {
    try{
      state = AsyncValue.loading();
      final userId = await prefs.then((prefs) => prefs.getUserId());
      if(path.isEmpty){
        final snapShot = await fireStore.collection(ReceiptConstant.collectionName).where('uid', isEqualTo: userId).get();

        final List<ReceiptModel>  receipt = snapShot.docs.map((doc){
          final list = doc.data();
          final receiptList  = ReceiptModel.fromJson(list);
          return receiptList;
        }).toList();

        receipt.forEach((element) {
          print("receipts: ${element.name}");
        });

        state = AsyncValue.data(receipt);
        return receipt;
      }
      else{
        DocumentReference documentReference = fireStore.doc(path);
        final snapShot = await fireStore.collection(ReceiptConstant.collectionName).where('uid', isEqualTo: userId)
            .where('list_ref', isEqualTo: documentReference).get();

        final List<ReceiptModel>  receipt = snapShot.docs.map((doc){
          final list = doc.data();
          final receiptList  = ReceiptModel.fromJson(list);
          return receiptList;
        }).toList();

        receipt.forEach((element) {
          print("receipts: ${element.name}");
        });

        state = AsyncValue.data(receipt);
        return receipt;
      }




    }catch(error, stackTrace){
      state = AsyncValue.error(error, stackTrace);
      print("error $error");
      return [];
    }
  }

}