// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../model/domain/configuration.dart';
import '../model/domain/domian.dart';
import 'pages/pages.dart';

class Routes {
  static const String loadingPage = '/';
  static const String homePage = '/home';
  static const String configurationPage = '/configure';
  static const String _cameraPage = '/configure/cameras/:id';
  static String cameraPage({@required dynamic id}) => '/configure/cameras/$id';
  static const String slotPage = '/configure/slots';
  static const String projectPage = '/project';
  static const all = <String>{
    loadingPage,
    homePage,
    configurationPage,
    _cameraPage,
    slotPage,
    projectPage,
  };
}

class VCCSRoute extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loadingPage, page: LoadingPage),
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(Routes.configurationPage, page: ConfigurationPage),
    RouteDef(Routes._cameraPage, page: CameraPage),
    RouteDef(Routes.slotPage, page: SlotPage),
    RouteDef(
      Routes.projectPage,
      page: ProjectPage,
      generator: ProjectPageRouter(),
    ),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LoadingPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => LoadingPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeft,
      );
    },
    HomePage: (data) {
      final args = data.getArgs<HomePageArguments>(
        orElse: () => HomePageArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            HomePage(key: args.key),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeft,
      );
    },
    ConfigurationPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ConfigurationPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeft,
      );
    },
    CameraPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => CameraPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    SlotPage: (data) {
      final args = data.getArgs<SlotPageArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => SlotPage(
          key: args.key,
          slot: args.slot,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    ProjectPage: (data) {
      final args = data.getArgs<ProjectPageArguments>(nullOk: false);
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => ProjectPage(
          key: args.key,
          projectName: args.projectName,
          projectLocation: args.projectLocation,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeft,
      );
    },
  };
}

class ProjectPageRoutes {
  static const String projectWelcome = '/';
  static const String _imagePage = '/slotimage/:set/:slot';
  static String imagePage({@required dynamic set, @required dynamic slot}) =>
      '/slotimage/$set/$slot';
  static const String cameraSetup = '/setup';
  static const String cameraSets = '/sets';
  static const String _setPage = '/sets/:id?';
  static String setPage({dynamic id = ''}) => '/sets/$id';
  static const String modelCreation = '/model';
  static const String settings = '/settings';
  static const all = <String>{
    projectWelcome,
    _imagePage,
    cameraSetup,
    cameraSets,
    _setPage,
    modelCreation,
    settings,
  };
}

class ProjectPageRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(ProjectPageRoutes.projectWelcome, page: ProjectWelcome),
    RouteDef(ProjectPageRoutes._imagePage, page: ImagePage),
    RouteDef(ProjectPageRoutes.cameraSetup, page: CameraSetup),
    RouteDef(ProjectPageRoutes.cameraSets, page: CameraSets),
    RouteDef(ProjectPageRoutes._setPage, page: SetPage),
    RouteDef(ProjectPageRoutes.modelCreation, page: ModelCreation),
    RouteDef(ProjectPageRoutes.settings, page: Settings),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    ProjectWelcome: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProjectWelcome(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    ImagePage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ImagePage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    CameraSetup: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => CameraSetup(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    CameraSets: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => CameraSets(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    SetPage: (data) {
      final args = data.getArgs<SetPageArguments>(
        orElse: () => SetPageArguments(),
      );
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => SetPage(
          key: args.key,
          set: args.set,
        ),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeft,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    ModelCreation: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ModelCreation(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    Settings: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => Settings(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.fadeIn,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// HomePage arguments holder class
class HomePageArguments {
  final Key key;
  HomePageArguments({this.key});
}

/// SlotPage arguments holder class
class SlotPageArguments {
  final Key key;
  final Slot slot;
  SlotPageArguments({this.key, @required this.slot});
}

/// ProjectPage arguments holder class
class ProjectPageArguments {
  final Key key;
  final String projectName;
  final String projectLocation;
  ProjectPageArguments(
      {this.key, @required this.projectName, @required this.projectLocation});
}

/// SetPage arguments holder class
class SetPageArguments {
  final Key key;
  final VCCSSet set;
  SetPageArguments({this.key, this.set});
}
