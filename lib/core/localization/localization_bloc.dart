import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'localization_event.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, Locale> {
  LocalizationBloc() : super(const Locale('en')) {
    on<ChangeLocaleEvent>((event, emit) {
      emit(event.locale);
    });
  }
}
