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
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    receiveDataWhenStatusError: true,
    headers: headers,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
    sendTimeout: const Duration(seconds: 5),
  ))
    ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          // final login = TLocalStorage.getString(loginKey);
          // final password = TLocalStorage.getString(passwordKey);
          // final userToken = await Dio().post("$baseUrl$loginEndpoint", data: {'login': login, 'password': password}, options: Options(headers: {
          //   'Content-Type': 'application/json',
          //   'Accept': 'application/json',
          // }));
          // TLocalStorage.saveString(tokenKey, userToken.data['access_token']);
          handler.next(options);
        },
        onError: (DioException e, handler) {
          print(e.type.name);
          handler.next(e);
        }));

  ///  https://ctsbackend.uz/api/login
  ///  This method is used to login user
  Future<UserToken  > login(String login, String password) async {
    try {
      final response = await dio.post(loginEndpoint, data: {'login': login, 'password': password});
      TLoggerHelper.info(response.data.toString());
      if (response.statusCode == 200) {
        if (response.data['access_token'] == false) {
          throw ErrorException('Incorrect login or password');
        }

        return UserToken.fromJson(response.data);
      }

      throw ErrorException("Status code: ${response.statusCode}");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      }
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // write api doc
  // https://ctsbackend.uz/api/boss/data/payment
  Future<int> payment() async {
    // print(await TLocalStorage.getString(tokenKey));
    dio.options.headers['Authorization'] =
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2N0c2JhY2tlbmQudXovYXBpL2xvZ2luIiwiaWF0IjoxNzAwNDEyMDc5LCJleHAiOjE3MDA0MTU2NzksIm5iZiI6MTcwMDQxMjA3OSwianRpIjoib2Z6U2lpUllLdU9vMWUzUiIsInN1YiI6IjEiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.5n93n_3lU-W5zNjELBa1LEeniRPdHyBELawdA2rRy9U';
    try {
      final response = await dio.get(paymentEndpoint,
          options: Options(headers: {
            'Authorization': 'Bearer ${await TLocalStorage.getString(tokenKey)}',
          }));

      if (response.statusCode == 200) {
        print("fine");
        print(response.data);
        TLoggerHelper.info(response.data['data'].toString());
        return response.data['data'];
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      }
      print(e.response?.statusCode);
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      TLoggerHelper.error(e.toString());
      rethrow;
    }
  }

// https://ctsbackend.uz/api/boss/data/payments
  Future<PaymentModel> payments() async {
    print(await TLocalStorage.getString(tokenKey));
    dio.options.headers['Authorization'] = 'Bearer ${await TLocalStorage.getString(tokenKey)}';
    try {
      TLoggerHelper.info('Everything is fine');
      final response = await dio.get(paymentsEndpoint);
      if (response.statusCode == 200) {
        TLoggerHelper.info(response.data['data'].toString());
        return PaymentModel.fromJson(response.data['data']);
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      }
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      TLoggerHelper.error(e.toString());
      rethrow;
    }
  }

  Future<List<RegionModel>> regions() async {
    dio.options.headers['Authorization'] = 'Bearer ${await TLocalStorage.getString(tokenKey)}';
    try {
      final response = await dio.get(regionsEndpoint);
      if (response.statusCode == 200) {
        TLoggerHelper.info(response.data['data'].toString());
        // return RegionModel.fromJson(response.data['data']);
        return List<RegionModel>.from(response.data['data'].map((x) => RegionModel.fromJson(x)));
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      print(e.type);
      print(e.response?.statusCode);
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      } else if (e.type == DioExceptionType.badResponse) {
        final login = await TLocalStorage.getString(loginKey);
        final password = await TLocalStorage.getString(passwordKey);
        if (login != null && password != null) {
          final UserToken userToken = await this.login(login, password);
          TLocalStorage.saveString(tokenKey, userToken.accessToken);
        } else {
          throw "Unauthorized";
        }
      }

      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<ContractModel> contracts() async {
    dio.options.headers['Authorization'] = 'Bearer ${await TLocalStorage.getString(tokenKey)}';
    try {
      final response = await dio.get(contractsEndpoint);
      if (response.statusCode == 200) {
        TLoggerHelper.info(response.data['data'].toString());
        return ContractModel.fromJson(response.data['data']);
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      }
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
  Future<ContractModel> getContractByPage(int page)async{
    dio.options.headers['Authorization'] = 'Bearer ${await TLocalStorage.getString(tokenKey)}';
    try {
      final response = await dio.get(contractsEndpoint,queryParameters: {'page':page});
      if (response.statusCode == 200) {
        TLoggerHelper.info(response.data['data'].toString());
        return ContractModel.fromJson(response.data['data']);
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      }
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CompanyModel>> companies() async {
    dio.options.headers['Authorization'] = 'Bearer ${await TLocalStorage.getString(tokenKey)}';
    try {
      final response = await dio.get(companiesEndpoint);
      if (response.statusCode == 200) {
        TLoggerHelper.info(response.data['data'].toString());
        return List<CompanyModel>.from(response.data['data'].map((x) => CompanyModel.fromJson(x)));
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      }
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BlockModel>> blocks() async {
    dio.options.headers['Authorization'] = 'Bearer ${await TLocalStorage.getString(tokenKey)}';
    print(await TLocalStorage.getString(tokenKey));
    try {
      final response = await dio.get(blocksEndpoint);
      if (response.statusCode == 200) {
        TLoggerHelper.info(response.data['data'].toString());
        return List<BlockModel>.from(response.data['data'].map((x) => BlockModel.fromJson(x)));
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      }
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ObjectModel>> objects() async {
    dio.options.headers['Authorization'] = 'Bearer ${await TLocalStorage.getString(tokenKey)}';
    print(await TLocalStorage.getString(tokenKey));
    try {
      final response = await dio.get(objectsEndpoint);
      if (response.statusCode == 200) {
        TLoggerHelper.info(response.data['data'].toString());
        return List<ObjectModel>.from(response.data['data'].map((x) => ObjectModel.fromJson(x)));
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      }
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SingleBlocModel>> blocs({int id = 1}) async {
    dio.options.headers['Authorization'] = 'Bearer ${await TLocalStorage.getString(tokenKey)}';
    print(await TLocalStorage.getString(tokenKey));
    try {
      final response = await dio.get("$blockEndpoint/$id");
      if (response.statusCode == 200) {
        TLoggerHelper.info(response.data['data'].toString());
        return List<SingleBlocModel>.from(
            response.data['data'].map((x) => SingleBlocModel.fromJson(x)));
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      print(e.type);
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      } else if (e.type == DioExceptionType.badResponse) {
        final login = await TLocalStorage.getString(loginKey);
        final password = await TLocalStorage.getString(passwordKey);
        if (login != null && password != null) {
          print("$login $password");
          final UserToken userToken = await this.login(login, password);
          print(userToken.accessToken);
          TLocalStorage.saveString(tokenKey, userToken.accessToken);
          // return await blocs();
        }
      }
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FreeHomeModel>> freeHome(int id) async {
    dio.options.headers['Authorization'] = 'Bearer ${await TLocalStorage.getString(tokenKey)}';
    print(await TLocalStorage.getString(tokenKey));
    try {
      final response = await dio.get("$freeHomesEndpoint/$id");
      if (response.statusCode == 200) {
        TLoggerHelper.info(response.data['data'].toString());
        return List<FreeHomeModel>.from(
            response.data['data'].map((x) => FreeHomeModel.fromJson(x)));
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      }
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<HomeModel> home(int id) async {
    dio.options.headers['Authorization'] = 'Bearer ${await TLocalStorage.getString(tokenKey)}';
    print(await TLocalStorage.getString(tokenKey));
    try {
      final response = await dio.get("$homesEndpoint/$id");
      if (response.statusCode == 200) {
        TLoggerHelper.info(response.data['data'].toString());
        return HomeModel.fromJson(response.data['data']);
      }
      throw 'Status code: ${response.statusCode}';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw 'Connection timeout';
      }
      TLoggerHelper.error(e.response.toString());
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
