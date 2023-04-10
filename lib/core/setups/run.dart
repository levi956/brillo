// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:brillo_assessment/core/config/device/device_potrait.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

SupabaseClient? supabase;

class Setups {
  static Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Environmentals.loadEnv();
    await Server.runServer();
    SetPotrait.init();
  }
}

class Server {
  static Future<void> runServer() async {
    final _url = dotenv.env['URL'] ?? _null;
    final _anonKey = dotenv.env['ANONKEY'] ?? _null;
    await Supabase.initialize(url: _url, anonKey: _anonKey, debug: true);
    supabase = Supabase.instance.client;
  }
}

class Environmentals {
  static Future<void> loadEnv() async {
    await dotenv.load(fileName: '.env');
  }
}

const _null = 'NULL';
