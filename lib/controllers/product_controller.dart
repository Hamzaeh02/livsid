import 'package:get/get.dart';
import '../models/product_list_model.dart';
import '../models/product_model.dart';
import '../models/promoted_product.dart';
import '../outh_file/local_db_key.dart';
import '../services/base_url.dart'; // Ensure BaseService is here
import '../services/endpoint.dart';
import '../utils/shared_prefrences_methods.dart';
import '../widgets/util.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productId = "".obs;
  var product = Rxn<ProductModel>();
  var promotedProductResponse = Rxn<ProductResponse>();

  var productListResponse = Rxn<ProductListModel>();
  var allProducts = <ProductListData>[].obs;
  var allPromotedProducts = <ProductData>[].obs;
  final prefs = SharedPreferencesMethod.storage;

  BaseService baseService = BaseService();

  @override
  void onInit() {
    super.onInit();


    getAllProducts();// Screen load hote hi API call hogi
    getPromotedProducts();
    if (Get.arguments != null) {
      productId.value = Get.arguments;
    }
  }

  Future<void> getProductDetails({String? productId}) async {
    try {
      isLoading(true);
      final response = await baseService.baseGetAPI(ApiEndPoints.productDetail(productId ?? ''));

      if (response != null && response['success'] == true) {
        // Raw JSON ko Model mein convert kar ke observable mein daal diya
        product.value = ProductModel.fromJson(response);
      } else {
        Utils.showToast(response?['msg'] ?? "Error fetching data", true);
      }
    } catch (e) {
      Utils.showToast("Server Error: ${e.toString()}", true);
    } finally {
      isLoading(false);
    }
  }


  Future<void> getAllProducts() async {
    try {
      isLoading(true);
      // API call
      final response = await baseService.baseGetAPI(ApiEndPoints.moreProductDetail);

      if (response != null && response['success'] == true) {
        // ✅ Naye List Model mein data map kar rahe hain
        ProductListModel model = ProductListModel.fromJson(response);
        productListResponse.value = model;

        // Agar data list null nahi hai to allProducts ko update karein
        if (model.data != null) {
          allProducts.assignAll(model.data!);
        }
      } else {
        Utils.showToast(response?['msg'] ?? "Error fetching data", true);
      }
    } catch (e) {
      Utils.showToast("Server Error: ${e.toString()}", true);
      print("Error logic: $e");
    } finally {
      isLoading(false);
    }
  }


  Future<void> getPromotedProducts() async {
    try {
      isLoading(true);

      // API call
      final response = await baseService.baseGetAPI(ApiEndPoints.getPromotedProducts);

      if (response != null && response['success'] == true) {
        // 1. Model mapping (Model ka naam check karein)

        ProductResponse model = ProductResponse.fromJson(response);

        if (model.success == true) {
          // 2. Full response store karna
          promotedProductResponse.value = model;

          // 3. List update karna (Null check ke saath)
          if (model.data != null) {
            allPromotedProducts.assignAll(model.data!);
          } else {
            allPromotedProducts.clear(); // Agar data null aaye toh list empty kar dein
          }
        } else {
          // API success false hone par message dikhayein
          Utils.showToast(response['message'] ?? "Something went wrong", true);
        }
      }
    } catch (e) {
      // 4. Detailed Error Handling
      Utils.showToast("Server Error: ${e.toString()}", true);
      print("Error logic: $e");
    } finally {
      isLoading(false);
    }
  }
}