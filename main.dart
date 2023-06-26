import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './mpgdeliverry.dart';

import 'dart:async';

import 'dart:convert';

import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    title: 'malandro',
    home: Uma(),
  ));
}
