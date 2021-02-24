// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'pages/pages.dart';

class Routes {
  static const String homePage = '/';
  static const String projectPage = '/project';
  static const all = <String>{
    homePage,
    projectPage,
  };
}

class VCCSRoute extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homePage, page: HomePage),
    RouteDef(
      Routes.projectPage,
      page: ProjectPage,
      generator: ProjectPageRouter(),
    ),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
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
    ProjectPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => ProjectPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideLeft,
      );
    },
  };
}

class ProjectPageRoutes {
  static const String projectWelcome = '/';
  static const String cameraSetup = '/setup';
  static const String cameraSets = '/sets';
  static const String _setPage = '/sets/:id?';
  static String setPage({dynamic id = ''}) => '/sets/$id';
  static const String modelCreation = '/model';
  static const String settings = '/settings';
  static const all = <String>{
    projectWelcome,
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
    CameraSetup: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => CameraSetup(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    CameraSets: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => CameraSets(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    SetPage: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => SetPage(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    ModelCreation: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ModelCreation(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.zoomIn,
        transitionDuration: const Duration(milliseconds: 10),
      );
    },
    Settings: (data) {
      return PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) => Settings(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.zoomIn,
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
