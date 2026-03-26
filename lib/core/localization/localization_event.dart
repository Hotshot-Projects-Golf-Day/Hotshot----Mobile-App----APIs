import 'package:flutter/material.dart';

abstract class LocalizationEvent {}

class ChangeLocaleEvent extends LocalizationEvent {
  final Locale locale;

  ChangeLocaleEvent(this.locale);
}
