import 'package:chat/global/environment.dart';
import 'package:chat/models/mensajes_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_services.dart'; 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ChatService with ChangeNotifier {

  Usuario? usuarioPara;

  Future<List<Mensaje>> getChat( String usuarioID ) async {
    
    final uri = Uri.parse('${ Environment.apiUrl }/mensajes/$usuarioID');
    final token = await AuthService.getToken();

    final resp = await http.get(uri, 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token!
      }
    );

    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;

  }
}