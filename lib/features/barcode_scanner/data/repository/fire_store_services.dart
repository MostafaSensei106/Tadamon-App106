import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tadamon/features/app_toast/app_toast.dart';
import 'package:tadamon/features/barcode_scanner/data/models/product_model.dart';

class FireStoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'TadamonProducts';
  final String _productReportCollection = 'TadamonUserReport';


  /// Adds a new product to the FireStore database.
  ///
  /// The product is added to the '_collectionName' collection.
  ///
  /// If the product is added successfully, nothing is returned.
  ///
  /// If the product cannot be added, a toast is shown with the error message.
  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore.collection(_collectionName).add(product.toMap());
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  /// Gets all products from the FireStore database.
  ///
  /// The products are retrieved from the '_collectionName' collection.
  ///
  /// If the products are retrieved successfully, a list of [ProductModel] is returned.
  ///
  /// If the products cannot be retrieved, a toast is shown with the error message and an empty list is returned.
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

  /// Updates an existing product in the FireStore database.
  ///
  /// The product is updated in the '_collectionName' collection using the provided [documnetId].
  ///
  /// If the product is updated successfully, no action is taken.
  ///
  /// If the product cannot be updated, a toast is shown with the error message.

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

  /// Deletes an existing product from the FireStore database.
  ///
  /// The product is deleted from the '_collectionName' collection using the provided [documnetId].
  ///
  /// If the product is deleted successfully, no action is taken.
  ///
  /// If the product cannot be deleted, a toast is shown with the error message.

  Future<void> deleteProduct(String documnetId) async {
    try {
      await _firestore.collection(_collectionName).doc(documnetId).delete();
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  /// Gets a product from the FireStore database using the provided [serialNumber].
  ///
  /// The product is retrieved from the '_collectionName' collection.
  ///
  /// If the product is found, a [ProductModel] is returned.
  ///
  /// If the product is not found, a [ProductModel] with [onError] set to 'Product not found' is returned.
  ///
  /// If an error occurs while retrieving the product, a toast is shown with the error message and a [ProductModel] with [onError] set to 'An error occurred' is returned.
  Future<dynamic> getProductBySerialNumber(String serialNumber) async {
    try {
      final snapshot =
          await _firestore.collection(_collectionName).doc(serialNumber).get();
      final data = snapshot.data();
      if (data != null) {
        return ProductModel.fromMap(data);
      } else {
        return ProductModel(serialNumber: serialNumber, onError: 'Product not found');
      }
    } catch (e) {
      AppToast.showErrorToast(e.toString());
      return ProductModel(serialNumber: serialNumber, onError: 'An error occurred');
    }
  }

  /// Searches for products in the FireStore database using the provided [productName].
  ///
  /// The products are retrieved from the '_collectionName' collection using the provided [productName].
  ///
  /// If the products are found, they are returned as a list of [ProductModel].
  ///
  /// If no products are found, an empty list is returned.
  ///
  /// If an error occurs while searching for the products, a toast is shown with the
  /// error message and an empty list is returned.
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

  /// Searches for products in the FireStore database using the provided [productCategory] list.
  ///
  /// The products are retrieved from the '_collectionName' collection where the 'productCategory' field
  /// contains any of the categories specified in the [productCategory] list.
  ///
  /// If the products are found, they are returned as a list of [ProductModel].
  ///
  /// If no products are found, an empty list is returned.
  ///
  /// If an error occurs while searching for the products, a toast is shown with the error message and an empty list is returned.

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

  /// Searches for products in the FireStore database using the provided [productManufacturer].
  ///
  /// The products are retrieved from the '_collectionName' collection using the provided [productManufacturer].
  ///
  /// If the products are found, they are returned as a list of [ProductModel].
  ///
  /// If no products are found, an empty list is returned.
  ///
  /// If an error occurs while searching for the products, a toast is shown with the
  /// error message and an empty list is returned.

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

  /// Searches for products in the FireStore database using the provided [productBoycottResonLink].
  ///
  /// The products are retrieved from the '_collectionName' collection where the 'productBoycottResonLink' field matches the provided [productBoycottResonLink].
  ///
  /// If the products are found, they are returned as a list of [ProductModel].
  ///
  /// If no products are found, an empty list is returned.
  ///
  /// If an error occurs while searching for the products, a toast is shown with the error message and an empty list is returned.
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

  /// Searches for products in the FireStore database using the provided [isTrusted].
  ///
  /// The products are retrieved from the '_collectionName' collection where the 'isTrusted' field matches the provided boolean.
  ///
  /// If the products are found, they are returned as a list of [ProductModel].
  ///
  /// If no products are found, an empty list is returned.
  ///
  /// If an error occurs while searching for the products, a toast is shown with the error message and an empty list is returned.
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



  /// Sends a product report to the FireStore database.
  ///
  /// The report is added to the '_productReportCollection' collection using the
  /// product name as the document ID.
  ///
  /// Takes a [productReport] map containing the report details.
  ///
  /// If the report is sent successfully, nothing is returned.
  ///
  /// If an error occurs while sending the report, an exception is thrown.

  Future<void> sendReportToBackEnd (Map<String,dynamic> productReport) async {
    String productName = productReport['productName'];
    DocumentReference documentReference = _firestore.collection(_productReportCollection).doc(productName);
    await documentReference.set(productReport);
  }
}
