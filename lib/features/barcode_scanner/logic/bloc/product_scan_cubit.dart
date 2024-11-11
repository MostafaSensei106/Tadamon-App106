import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'product_scan_state.dart';

class ProductScanCubit extends Cubit<ProductScanState> {
  ProductScanCubit() : super(ProductScanInitial());
}
