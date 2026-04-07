import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:tasks_project/features/auth/data/dataresource/auth_remote_data_source.dart';
import 'package:tasks_project/features/auth/data/repos/auth_repository_impl.dart';
import 'package:tasks_project/features/auth/domin/repositries/authrepositry.dart'
    show AuthRepository;
import 'package:tasks_project/features/auth/domin/usecase/deleteusecase.dart';
import 'package:tasks_project/features/auth/domin/usecase/login_usecase.dart';
import 'package:tasks_project/features/auth/domin/usecase/registerusecas.dart';
import 'package:tasks_project/features/auth/domin/usecase/resendverifycation_usecase.dart';
import 'package:tasks_project/features/auth/domin/usecase/verify_email_usecase.dart';
import 'package:tasks_project/features/auth/presntation/bloc/delete/dalete_account_bloc.dart';
import 'package:tasks_project/features/auth/presntation/bloc/login/login_bloc.dart';
import 'package:tasks_project/features/auth/presntation/bloc/regster/register_bloc.dart';
import 'package:tasks_project/features/auth/presntation/bloc/resendverification/resendverification_bloc.dart';
import 'package:tasks_project/features/auth/presntation/bloc/verifyEmail/verify_email_bloc.dart';
import 'package:tasks_project/features/tasks/data/datasource/task_remot_datasource.dart';
import 'package:tasks_project/features/tasks/data/repositries/tasks_repositry_impl.dart';
import 'package:tasks_project/features/tasks/domin/repositries/tasks_repository.dart';
import 'package:tasks_project/features/tasks/domin/usecase/create_task_usecase.dart';
import 'package:tasks_project/features/tasks/domin/usecase/get_tasks_usecase.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/bloc_list/task_list_bloc.dart';
import 'package:tasks_project/features/tasks/presentation/bloc/post_task/create_task_bloc.dart';

import '../network/dio_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  sl.registerLazySingleton<DioClient>(() => DioClient(secureStorage: sl()));

  sl.registerLazySingleton<Dio>(() => sl<DioClient>().dio);

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => ResendVerificationUseCase(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAccountUseCase(sl()));

  sl.registerFactory(() => RegisterBloc(sl()));
  sl.registerFactory(() => VerifyEmailBloc(sl()));
  sl.registerFactory(() => ResendVerificationBloc(sl()));
  sl.registerFactory(() => LoginBloc(sl(), sl()));
  sl.registerFactory(() => DeleteAccountBloc(sl()));

  sl.registerLazySingleton(() => CreateTaskUseCase(sl()));
  sl.registerFactory(() => CreateTaskBloc(sl()));
  sl.registerLazySingleton<TasksRemoteDataSource>(
    () => TasksRemoteDataSourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<GetTasksUseCase>(() => GetTasksUseCase(sl()));

  sl.registerFactory<TaskListBloc>(() => TaskListBloc(sl(), sl()));
}
