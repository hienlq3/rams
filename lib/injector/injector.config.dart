// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../modules/dio_module.dart' as _i948;
import '../repositories/document_local_repository.dart' as _i529;
import '../repositories/document_repository.dart' as _i466;
import '../services/base_service.dart' as _i301;
import '../services/document_service.dart' as _i569;
import '../services/file_downloader.dart' as _i70;
import '../ui/rams_documents_page/bloc/rams_documents_bloc.dart' as _i459;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i529.DocumentLocalRepository>(
      () => _i529.DocumentLocalRepository(),
    );
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio());
    gh.singleton<_i70.FileDownloader>(
      () => _i70.FileDownloader(
        dio: gh<_i361.Dio>(),
        documentLocalRepository: gh<_i529.DocumentLocalRepository>(),
      ),
    );
    gh.singleton<_i301.BaseService>(
      () => _i301.BaseService(dio: gh<_i361.Dio>()),
    );
    gh.singleton<_i569.DocumentService>(
      () => _i569.DocumentService(baseService: gh<_i301.BaseService>()),
    );
    gh.singleton<_i466.DocumentRepository>(
      () => _i466.DocumentRepository(
        documentService: gh<_i569.DocumentService>(),
      ),
    );
    gh.factory<_i459.RamsDocumentsBloc>(
      () => _i459.RamsDocumentsBloc(
        dio: gh<_i361.Dio>(),
        documentLocalRepository: gh<_i529.DocumentLocalRepository>(),
        documentRepository: gh<_i466.DocumentRepository>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i948.DioModule {}
