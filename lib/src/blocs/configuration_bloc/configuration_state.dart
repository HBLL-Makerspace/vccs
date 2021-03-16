part of 'configuration_bloc.dart';

@immutable
abstract class ConfigurationState {}

class ConfigurationInitial extends ConfigurationState {}

class ConfigurationLoadingState extends ConfigurationState {}

class ConfigurationDataState extends ConfigurationState {
  final Configuration configuration;

  ConfigurationDataState(this.configuration);
}
