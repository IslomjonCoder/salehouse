import 'package:crm/data/models/block_model.dart';
import 'package:crm/data/models/company_model.dart';
import 'package:crm/data/models/contract_model.dart';
import 'package:crm/data/models/free_home_model.dart';
import 'package:crm/data/models/home_model.dart';
import 'package:crm/data/models/object_model.dart';
import 'package:crm/data/models/payment_model.dart';
import 'package:crm/data/models/region_model.dart';
import 'package:crm/data/models/single_bloc_model.dart';
import 'package:crm/data/models/user_token_model.dart';
import 'package:crm/utils/constants/api_constants.dart';
import 'package:crm/utils/exceptions/exceptions.dart';
import 'package:crm/utils/local_storage/storage_utility.dart';
import 'package:crm/utils/logging/logger.dart';
import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      headers: headers,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout: const Duration(seconds: 5),
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TLocalStorage.getString(tokenKey);
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (DioException e, handler) => handler.next(e),
      ),
    );

  ApiService();

  Future<void> refreshToken() async {
    try {
      final login = await TLocalStorage.getString(loginKey);
      final password = await TLocalStorage.getString(passwordKey);

      final response = await dio.post(loginEndpoint, data: {"login": login, "password": password});
      TLoggerHelper.info('refreshToken');
      if (response.data['access_token'] != null) {
        final newToken = response.data['access_token'];

        TLocalStorage.saveString(tokenKey, newToken);
      }
    } catch (error) {
      TLoggerHelper.error(error.toString());
      if (error is DioException) {
        final message = errorHandler(error);
        throw message;
      }
    }
  }

  static String errorHandler(DioException error) {
    String errorMessage = 'Network Error'; // Default error message

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Ulanish muddati tugadi';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "So'rovnoma muddati tugadi";
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Ma\'lumotlarni olish muddati tugadi';
        break;
      case DioExceptionType.cancel:
        errorMessage = 'So\'rovnoma bekor qilindi';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'Server bilan bog\'lanishda xato';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Yomon sertifikat';
        break;
      case DioExceptionType.badResponse:
        errorMessage = 'Noma\'lum xatolik';
      case DioExceptionType.connectionError:
        errorMessage = "Internet mavjud emas";
    }

    return errorMessage;
  }

  ///  https://ctsbackend.uz/api/login
  ///  This method is used to login user
  Future<UserToken> login(String login, String password) async {
    try {
      final response = await dio.post(loginEndpoint, data: {'login': login, 'password': password});
      if (response.statusCode == 200) {
        if (response.data['access_token'] == false) {
          throw ErrorException('Incorrect login or password');
        }

        return UserToken.fromJson(response.data);
      }
      throw ErrorException("Status code: ${response.statusCode}");
    } on DioException catch (e) {
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  // write api doc
  // https://ctsbackend.uz/api/boss/data/payment
  Future<int> payment() async {
    try {
      final response = await dio.get(paymentEndpoint);
      if (response.statusCode == 200) {
        return response.data['data'];
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().payment();
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

// https://ctsbackend.uz/api/boss/data/payments
  Future<PaymentModel> payments(int page) async {
    try {
      final response = await dio.get(paymentsEndpoint, queryParameters: {'page': page});
      if (response.statusCode == 200) {
        return PaymentModel.fromJson(response.data['data']);
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().payments(page);
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RegionModel>> regions() async {
    try {
      final response = await dio.get(regionsEndpoint);
      if (response.statusCode == 200) {
        // return RegionModel.fromJson(response.data['data']);
        return List<RegionModel>.from(response.data['data'].map((x) => RegionModel.fromJson(x)));
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().regions();
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<ContractModel> contracts() async {
    try {
      final response = await dio.get(contractsEndpoint);
      if (response.statusCode == 200) {
        return ContractModel.fromJson(response.data['data']);
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().contracts();
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<ContractModel> getContractByPage(int page) async {
    try {
      final response = await dio.get(contractsEndpoint, queryParameters: {'page': page});
      if (response.statusCode == 200) {
        return ContractModel.fromJson(response.data['data']);
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().getContractByPage(page);
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CompanyModel>> companies() async {
    try {
      final response = await dio.get(companiesEndpoint);
      if (response.statusCode == 200) {
        return List<CompanyModel>.from(response.data['data'].map((x) => CompanyModel.fromJson(x)));
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().companies();
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BlockModel>> blocks() async {
    try {
      final response = await dio.get(blocksEndpoint);
      if (response.statusCode == 200) {
        return List<BlockModel>.from(response.data['data'].map((x) => BlockModel.fromJson(x)));
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().blocs() as List<BlockModel>;
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ObjectModel>> objects() async {
    try {
      final response = await dio.get(objectsEndpoint);
      if (response.statusCode == 200) {
        return List<ObjectModel>.from(response.data['data'].map((x) => ObjectModel.fromJson(x)));
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().objects();
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SingleBlocModel>> blocs({int id = 1}) async {
    try {
      final response = await dio.get("$blockEndpoint/$id");
      if (response.statusCode == 200) {
        return List<SingleBlocModel>.from(
          response.data['data'].map((x) => SingleBlocModel.fromJson(x)),
        );
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().blocs();
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FreeHomeModel>> freeHome(int id) async {
    try {
      final response = await dio.get("$freeHomesEndpoint/$id");
      if (response.statusCode == 200) {
        return List<FreeHomeModel>.from(
          response.data['data'].map((x) => FreeHomeModel.fromJson(x)),
        );
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().freeHome(id);
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<HomeModel> home({required int page, int bloc = 1}) async {
    try {
      final response = await dio.get("$homesEndpoint/$bloc", queryParameters: {'page': page});
      if (response.statusCode == 200) {
        return HomeModel.fromJson(response.data['data']);
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        await refreshToken();
        final response = await ApiService().home(page: page, bloc: bloc);
        return response;
      }
      throw errorHandler(e);
    } catch (e) {
      rethrow;
    }
  }
}
