import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:pika_pika_app/interactor/leader/leader_interactor.dart';
import 'package:pika_pika_app/ui/app/di/app.dart';
import 'package:pika_pika_app/ui/base/di/widget_component.dart';

class LeaderDetailsScreenComponent extends WidgetComponent {
  LeaderInteractor leaderInteractor;

  final String leaderId;

  LeaderDetailsScreenComponent(
    BuildContext context,
    this.leaderId,
  ) : super(context) {
    var app = Injector.of<AppComponent>(context).component;

    leaderInteractor = app.leaderInteractor;
  }
}
