import 'package:flutter/material.dart';
import 'package:materelia/shared/widgets/animation_verticale.dart';

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
                        child: DefaultTextStyle.merge(
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          else {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SizedBox.expand(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'lib/assets/images/home.png',
                        fit: constraints.maxHeight > constraints.maxWidth
                            ? BoxFit.fitHeight
                            : BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(color: Colors.black.withValues(alpha: 0.15)),
                    ),
                    SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: constraints.maxHeight),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: DefaultTextStyle.merge(
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              child: child,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      )
    );
  }
}
