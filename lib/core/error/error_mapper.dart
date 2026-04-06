import 'package:dio/dio.dart';
import 'failures.dart';

class ErrorMapper {
  static Failure mapDioException(DioException e) {
    final statusCode = e.response?.statusCode;

    // print('================ ERROR DEBUG ================');
    // print('URL: ${e.requestOptions.uri}');
    // print('METHOD: ${e.requestOptions.method}');
    // print('REQUEST DATA: ${e.requestOptions.data}');
    // print('STATUS CODE: $statusCode');
    // print('RESPONSE DATA: ${e.response?.data}');
    // print('ERROR TYPE: ${e.type}');
    // print('ERROR MESSAGE: ${e.message}');
    // print('============================================');

    if (statusCode != null) {
      switch (statusCode) {
        case 401:
          return UnauthorizedFailure('انتهت الجلسة، سجل الدخول مرة أخرى');
        case 404:
          return NotFoundFailure('المورد غير موجود');
        case 422:
          return ValidationFailure('البيانات المدخلة غير صحيحة');
        case 500:
          return ServerFailure('حدث خطأ في الخادم');
        default:
          return ServerFailure('حدث خطأ غير متوقع');
      }
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return NetworkFailure('انتهت مهلة الاتصال');
    }

    if (e.type == DioExceptionType.connectionError) {
      return NetworkFailure('تحقق من اتصال الإنترنت');
    }

    if (e.type == DioExceptionType.badCertificate) {
      return NetworkFailure('هناك مشكلة في شهادة الأمان');
    }

    if (e.type == DioExceptionType.cancel) {
      return UnknownFailure('تم إلغاء الطلب');
    }

    if (e.type == DioExceptionType.unknown) {
      return UnknownFailure('حدث خطأ غير معروف');
    }

    return UnknownFailure('حدث خطأ غير معروف');
  }
}
