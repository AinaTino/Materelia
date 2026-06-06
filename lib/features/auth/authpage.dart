import 'package:flutter/material.dart';
import 'package:materelia/shared/widgets/animationverticale.dart';

class AuthPage extends StatelessWidget{
  final Widget child;
  const AuthPage({super.key, required this.child});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Expanded(
                  flex: 0,
                  child: Image(
                    image: AssetImage('lib/assets/images/home.png'),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: AnimationVerticale(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          else {
            return GestureDetector(
              onTap: () => FocusScope.of( context).unfocus(),
              child: child,
              );
          }
        }
      )
    );
  }
}
