import 'package:shop_app/model/product_model.dart';
import 'package:shop_app/shared/network/remote/data/repository/popular_product_repo.dart';
import 'package:shop_app/shared/network/remote/data/repository/recommended_repo.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList =>_recommendedProductList ;

  bool _isLoaded =false;
  bool get isLoaded=>_isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode == 200) {
    //  print('got recommended');
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded =true;
      update();
    }else{
    }
  }
}