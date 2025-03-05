import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/features/pages/search_page/data/model/search_product_model.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';

class FireStoreRepositorie {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _collectionName = 'TadamonProducts';
  static const String _productReportCollection = 'TadamonUserReport';

  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection(_collectionName).add(product.toMap());
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  Future<List<ProductModel>> downloadAllProductsFromFirebase() async {
    try {
      final snapshot = await _firestore.collection(_collectionName).get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return [];
    }
  }



  Future<List<ProductModel>> getAllProducts() async {
    try {
      final snapshot = await _firestore.collection(_collectionName).get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return [];
    }
  }

 



  Future<void> updateProduct(String documnetId, ProductModel product) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(documnetId)
          .update(product.toMap());
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }





  Future<void> deleteProduct(String documnetId) async {
    try {
      await _firestore.collection(_collectionName).doc(documnetId).delete();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }






  Future<dynamic> getProductBySerialNumber(String serialNumber) async {
    try {
      final snapshot =
          await _firestore.collection(_collectionName).doc(serialNumber).get();
      final data = snapshot.data();
      if (data != null) {
        return ProductModel.fromMap(data);
      } else {
        return ProductModel(
          name: 'غير موجود',
          serialNumber: serialNumber,
          manufacture: 'غير معروف المصنع',
          category: 'غير معروف',
          trusted: false,
          onError: 'Product not found',
        );
      }
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  Future<List<ProductSearchModel>> searchForProduct(
      String searchTerm, String filter) async {
    if (searchTerm.isEmpty) {
      return [];
    }

    searchTerm = searchTerm.toLowerCase();
    final CollectionReference productsCollection =
        _firestore.collection(_collectionName);

    Query query;
    if (filter == 'SerialNumber') {
      query = productsCollection
          .where('SerialNumber', isGreaterThanOrEqualTo: searchTerm)
          .where('SerialNumber', isLessThanOrEqualTo: '$searchTerm\uf8ff');
    } else if (filter == 'Name') {
      query = productsCollection
          .where('Name', isGreaterThanOrEqualTo: searchTerm)
          .where('Name', isLessThanOrEqualTo: '$searchTerm\uf8ff');
    } else if (filter == 'Manufacture') {
      query = productsCollection
          .where('Manufacture', isGreaterThanOrEqualTo: searchTerm)
          .where('Manufacture', isLessThanOrEqualTo: '$searchTerm\uf8ff');
    } else if (filter == 'Category') {
      query = productsCollection
          .where('Category', isGreaterThanOrEqualTo: searchTerm)
          .where('Category', isLessThanOrEqualTo: '$searchTerm\uf8ff');
    } else {
      query =
          productsCollection.where('Name', isGreaterThanOrEqualTo: searchTerm);
    }

    final querySnapshot = await query.get();

    return querySnapshot.docs
        .map((doc) => ProductSearchModel.fromDocument(doc))
        .toList();
  }





  Future<void> sendReportToBackEnd(Map<String, dynamic> productReport) async {
    String productName = productReport['productName'];
    DocumentReference documentReference =
        _firestore.collection(_productReportCollection).doc(productName);
    await documentReference.set(productReport);
  }

}
