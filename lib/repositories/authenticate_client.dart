import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/repositories/base_client.dart';
import 'package:oke_car_flutter/utils/app_util.dart';

class AuthenticateClient extends BaseClient {
  final client = BaseClient.instance.dio;

  //Auth
  Future<Response> login(String email, String password) async {
    return BaseClient.instance.dio.post('$authServiceBaseUrl/login',
        data: {'userName': email, 'password': password});
  }

  Future<Response> register(Map<String, dynamic> data) async {
    return client.post(
      '$authServiceBaseUrl/confirm-register',
      data: data,
    );
  }

  Future<Response> verifedEmail(String email) async {
    return client.post(
      '$authServiceBaseUrl/pre-register',
      data: {'email': email},
    );
  }

  Future<Response> verifedForgot(String email) async {
    return client.post(
      '$authServiceBaseUrl/pre-forgot-pass',
      data: {'email': email},
    );
  }

  Future<Response> confirmRegisterOTP(String email, int code) async {
    return client.post(
      '$authServiceBaseUrl/verify-otp',
      data: {'email': email, 'code': code},
    );
  }


  Future<Response> confirmForgotOTP(String email, int code) async {
    return client.post(
      '$authServiceBaseUrl/verify-otp-forget',
      data: {'email': email, 'code': code},
    );
  }

  Future<Response> resetPasscode(String email, String  passcode) async {
    return client.post(
      '$authServiceBaseUrl/reset-password',
      data: {'email': email, 'newPassword': passcode},
    );
  }

  Future<Response> forgotPassword(String email) async {
    return client.post(
      '$authServiceBaseUrl/auth/forgot-password',
      data: {'email': email},
    );
  }

  Future<Response> verifyCode(String otp, String email) async {
    return client.post(
      '$authServiceBaseUrl/auth/forgot-password/active',
      data: {'email': email, 'keyactive': otp},
    );
  }

  Future<Response> changePassword(
      String email, String oldPassword, String newPass) async {
    return client.post(
      '$apiHostReal/auth/change-password',
      data: {
        'email': email,
        'oldPassword': oldPassword,
        'newPassword': newPass
      },
    );
  }

  Future<Response> confirmReset(String email, String resetCode) async {
    return client.post('$authServiceBaseUrl/confirm-reset',
        data: {'email': email, 'resetCode': resetCode});
  }

  Future<Response> creteNews(Map<String, dynamic> data) async {
    return client.post('$apiHostReal/products', data: data);
  }

  Future<Response> getAccountInfo() async {
    return client.get('$apiHostReal/users/me');
  }

  Future<Response> getBanner() async {
    return client.get('$authServiceBaseUrl/banners?banner_type=main_banner');
  }

//Product

  Future<Response> fetchLatestCar({String? status, int offset = 0}) async {
    final String statusPost =
        (status != null) ? '&status=$status' : '&status=$APPROVED';
    return client
        .get('$apiHostReal/public/products?limit=50$statusPost&offset=$offset');
  }

  Future<Response> search(String keyword, {int offset = 0}) async {
    return client.get(
        '$apiHostReal/public/products?keyword=$keyword&limit=100&status=$APPROVED&offset=$offset');
  }

  // Future<Response> fetchLatestCar() async {
  //   return client.get('$authServiceBaseUrl/products?type=latest&limit=10');
  // }

  Future<Response> fetchVipProduct({int offset = 0, int limit = 5}) async {
    return client.get(
        '$authServiceBaseUrl/products?limit=$limit&type=vip&offset=$offset');
  }

  Future<Response> createOrder(
      String productId, Map<String, dynamic> data) async {
    return client.post(
      '$apiHostReal/order/create/$productId',
      data: AppUtil.filterRequestData(data),
    );
  }

// Showroom

  //notifications
  Future<Response> getListNotification({int limit = 50, int offset = 0}) async {
    return client.get('$apiHostReal/notifications?limit=$limit&offset=$offset');
  }

  Future<Response> getListNotificationId(String id) async {
    return client.get('$apiHostReal/notifications/$id');
  }

  Future<Response> getMyPost() async {
    return client.get('$apiHostReal/products/me?limit=50');
  }

  //car company
  Future<Response> getCarCompanyByType() {
    return client.get('$apiHostReal/product-company?limit=50');
  }

  //vehicles
  Future<Response> getListVehicleByCarId({String? brandId}) {
    return client.get('$apiHostReal/vehicles/by-product-company/$brandId');
  }

  Future<Response> getVersion({String? brandId}) {
    return client.get('$apiHostReal/version/by-vehicles/$brandId');
  }

  //images
  Future<Response> uploadImage(File image) async {
    dio.FormData formData = dio.FormData.fromMap({
      'image': await dio.MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });
    return client.post(
      '$apiHostReal/storage/image',
      data: formData,
    );
  }

  //admin
  Future<Response> fetchAdminProduct({int offset = 0, int limit = 20}) async {
    return client
        .get('$apiHostReal/admin/products?limit=$limit&offset=$offset');
  }

  Future<Response> changeStatus(String id, String status) async {
    return client.put('$apiHostReal/admin/products/confirm-status/$id',
        data: {'status': status});
  }

  Future<Response> cancelPost(String id, String status) async {
    return client.put('$apiHostReal/products/confirm-status/$id',
        data: {'status': status});
  }

  Future<Response> addCar(Map<String, dynamic> data) async {
    return client.post('$apiHostReal/product-company', data: data);
  }

  Future<Response> addVehicle(Map<String, dynamic> data) async {
    return client.post('$apiHostReal/vehicles', data: data);
  }

  Future<Response> editVehicle(String id, Map<String, dynamic> data) async {
    return client.put('$apiHostReal/vehicles/$id', data: data);
  }

  Future<Response> edit(String id, Map<String, dynamic> data) async {
    return client.put('$apiHostReal/product-company/$id', data: data);
  }

  //order

  Future<Response> getOrderSeller(
      {required String sellerId, String? status, int offset = 0}) async {
    final String statusPost =
        (status != null) ? '&status=$status' : '&status=$CONFIRMING';

    return client.get(
        '$apiHostReal/order/page?sellerId=$sellerId&limit=50$statusPost&offset=$offset');
  }

  Future<Response> getOrderBuyer(
      {required String buyerId, String? status, int offset = 0}) async {
    final String statusPost =
        (status != null) ? '&status=$status' : '&status=$CONFIRMING';

    return client.get(
        '$apiHostReal/order/page?buyerId=$buyerId&limit=50$statusPost&offset=$offset');
  }

  Future<Response> confirmOrder(String id) async {
    return client.post('$apiHostReal/order/confirm-order/$id');
  }

  Future<Response> cancelOredr(String id) async {
    return client.post('$apiHostReal/order/cancel-order/$id');
  }
}
