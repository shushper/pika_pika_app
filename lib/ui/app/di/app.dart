import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:mwwm/mwwm.dart';
import 'package:network/network.dart';
import 'package:pika_pika_app/config/config.dart';
import 'package:pika_pika_app/config/env/env.dart';
import 'package:pika_pika_app/interactor/auth/auth_interactor.dart';
import 'package:pika_pika_app/interactor/auth/auth_repository/auth_repository.dart';
import 'package:pika_pika_app/interactor/initiative/initiative_interactor.dart';
import 'package:pika_pika_app/interactor/initiative/initiative_repository/initiative_repository.dart';
import 'package:pika_pika_app/interactor/leader/leader_interactor.dart';
import 'package:pika_pika_app/interactor/leader/leader_repository/leader_repository.dart';
import 'package:pika_pika_app/interactor/network/header_builder.dart';
import 'package:pika_pika_app/interactor/network/status_mapper.dart';
import 'package:pika_pika_app/interactor/profile/profile_interactor.dart';
import 'package:pika_pika_app/interactor/profile/profile_repository/profile_repository.dart';
import 'package:pika_pika_app/interactor/session/session_changed_interactor.dart';
import 'package:pika_pika_app/interactor/token/auth_token_storage.dart';
import 'package:pika_pika_app/ui/base/default_dialog_controller.dart';
import 'package:pika_pika_app/ui/base/error/standard_error_handler.dart';
import 'package:pika_pika_app/ui/base/material_message_controller.dart';
import 'package:pika_pika_app/util/sp_helper.dart';

/// Component per app
class AppComponent implements Component {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final navigator = GlobalKey<NavigatorState>();

  WidgetModelDependencies wmDependencies;
  MaterialMessageController messageController;
  DefaultDialogController dialogController;
  PreferencesHelper preferencesHelper = PreferencesHelper();
  AuthTokenStorage authTokenStorage;
  DioHttp http;
  SessionChangedInteractor scInteractor;
  AuthInteractor authInteractor;
  InitiativeInteractor initiativeInteractor;
  LeaderInteractor leaderInteractor;
  ProfileInteractor profileInteractor;

  AppComponent(BuildContext context) {
    rebuildDependencies();
  }

  void rebuildDependencies() {
    _initDependencies();
  }

  void _initDependencies() {
    messageController = MaterialMessageController(scaffoldKey);
    dialogController = DefaultDialogController(scaffoldKey);
    authTokenStorage = AuthTokenStorage(preferencesHelper);
    http = _initHttp(authTokenStorage);
    scInteractor = SessionChangedInteractor(authTokenStorage);

    authInteractor = AuthInteractor(
      AuthRepository(http),
    );

    initiativeInteractor = InitiativeInteractor(
      InitiativeRepository(http),
    );

    leaderInteractor = LeaderInteractor(
      LeaderRepository(http)
    );

    profileInteractor = ProfileInteractor(
      ProfileRepository(http)
    );

    wmDependencies = WidgetModelDependencies(
      errorHandler: StandardErrorHandler(
        messageController,
        DefaultDialogController(scaffoldKey),
        scInteractor,
      ),
    );
  }

  DioHttp _initHttp(AuthTokenStorage authStorage) {
    var proxyUrl = Environment<Config>.instance().config.proxyUrl;
    var dioHttp = DioHttp(
      config: HttpConfig(
        Environment<Config>.instance().config.url,
        Duration(seconds: 30),
        proxyUrl: proxyUrl,
      ),
      errorMapper: DefaultStatusMapper(),
      headersBuilder: DefaultHeaderBuilder(authStorage),
    );
    return dioHttp;
  }
}
