import 'package:flutter/material.dart';
import 'package:tcc/components/menu_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre'),
        leading: const MenuWidget(),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline_rounded,
              size: 64,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            const SizedBox(
              height: 24,
            ),
            const Text('Versão 1.0.0'),
            const Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.copyright_rounded,
                      size: 16,
                    ),
                  ),
                  TextSpan(text: ' Todos os direitos reservados.'),
                ],
              ),
            ),
            const Text('2023'),
          ],
        ),
      ),
    );
  }
}
