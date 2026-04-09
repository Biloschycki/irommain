import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironkey/app_theme.dart';
import 'package:ironkey/password_generator.dart';
import 'package:ironkey/pin_password_generator.dart';
import 'package:ironkey/standard_password_generator.dart';

void main() {
  runApp(const IronKeyApp());
}

class IronKeyApp extends StatelessWidget {
  const IronKeyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const IronKeyScreen(),
    );
  }
}

class IronKeyScreen extends StatefulWidget {
  const IronKeyScreen({super.key});
  @override
  State<IronKeyScreen> createState() => _IronKeyScreenState();
}

class _IronKeyScreenState extends State<IronKeyScreen> {
  final TextEditingController _passwordController = TextEditingController();

  PasswordType passwordSelectedType = PasswordType.pin;
  
  
  bool isEditable = false;
  int maxCharacters = 12;
  bool isPin = false;
  void generatePassword() {
    late final PasswordGenerator generator;
    switch(passwordSelectedType){
      case PasswordType.pin:
      generator=PinPasswordGenerator();
      break;
      case PasswordType.standard:
      generator =StandardPasswordGenerator();
      break;
    }
  }

  void copyPassword(String password) {
    Clipboard.setData(ClipboardData(text: password));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Senha copiada!')));
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ClipOval(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          'images/ironman.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Senhas seguras',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      enabled: isEditable,
                      maxLength: maxCharacters,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: _passwordController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  copyPassword(_passwordController.text);
                                },
                                icon: const Icon(Icons.copy),
                              )
                            : null,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Tipo de senha")),
                    Row(
                      children: [
                        Expanded(child: 
                        RadioListTile(
                          value: PasswordType.pin,
                          groupValue: passwordSelectedType,
                          title: Text("Pin"),
                          onChanged: (value){
                            setState(() {
                             passwordSelectedType=value!;
                            });
                          }
                          )
                        ),
                        Expanded(child: 
                          RadioListTile(
                            value: PasswordType.standard, 
                            groupValue: passwordSelectedType,
                            title: Text("Senha Padrão"),
                            onChanged: (value){
                              setState(() {
                                passwordSelectedType=value!;
                              });
                            }
                          )
                        )

                      ],
                    ),
                    Divider(
                      color: colorScheme.outline,

                    ),
                    Row(
                      children: [
                        Icon(isEditable ? Icons.lock_open : Icons.lock),
                        SizedBox(width: 8),
                        Expanded(child: Text("Permitir editar a senha?")),
                        Switch(value: isEditable, onChanged: (value){
                          setState(() {
                            isEditable = value;
                          });
                        })
                      ],
                    ),
                    Divider(color: colorScheme.outline),
                    const SizedBox(height: 20),
                    if(isEditable)Text("Senha Customizada"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: generatePassword,
                    child: const Text('Gerar senha'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum PasswordType {pin, standard}
