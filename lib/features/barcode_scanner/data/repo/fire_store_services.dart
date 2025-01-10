import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/features/barcode_scanner/data/mode/product_model.dart';

class FireStoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'TadamonProducts';

  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection(_collectionName).add(product.toMap());
    } catch (e) {
      AppToast.showErrorToast(e.toString());
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

  //search by serial number
  Future<ProductModel> getProductBySerialNumber(String serialNumber) async {
    try {
      final snapshot =
          await _firestore.collection(_collectionName).doc(serialNumber).get();
      final data = snapshot.data();
      if (data != null) {
        return ProductModel.fromMap(data);
      } else {
        return ProductModel(serialNumber: serialNumber , onError: 'لم يتم العثور على المنتج');
      }
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return ProductModel(serialNumber: serialNumber);
    }
  }

  //search by product name
  Future<List<ProductModel>> searchProductByName(String productName) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('poductrName', isEqualTo: productName)
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return [];
    }
  }

  //search by product category
  Future<List<ProductModel>> searchProductByCategory(
      List<String> productCategory) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('productCategory', arrayContainsAny: productCategory)
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return [];
    }
  }

  //search by product manufacturer
  Future<List<ProductModel>> searchProductByManufacturer(
      String productManufacturer) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('productManufacturer', isEqualTo: productManufacturer)
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return [];
    }
  }

  //search by product manufacturer
  Future<List<ProductModel>> searchProductByBoycottLink(
      String productBoycottResonLink) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('productBoycottResonLink', isEqualTo: productBoycottResonLink)
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return [];
    }
  }

  //search by product isTrusted
  Future<List<ProductModel>> searchProductByIsTrusted(bool isTrusted) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('isTrusted', isEqualTo: isTrusted)
          .get();
      return snapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return [];
    }
  }
}
