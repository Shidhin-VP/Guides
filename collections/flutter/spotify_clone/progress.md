# Tracking Each Step Progress

## <mark>As of (09/02/2026)</mark>

1. Learned how to structure folders by following MVVM Architucture.
   * In the lib folder, structure it as ```feature vise development```.
   * Create a ```feature``` folder and under it create sub feature folders, for instance: auth, home etc.
   * For each feature folder create 3 sub folders.
       1. model :> Should contain business logic
       2. view :> Should contain UI
       3. view_model :> Should be a bridge between Model and View
    * The lib folder should also contain one more folder which is: ```core``` which should contain logics that will be applied to the entire project for instance: theame.dart, app_pallete.dart etc..
    * Inside each ```feature``` folder we should also have a ```widget``` file where we can save common functions that we use for widgets when building UIs
2. Learned to seperate core logics like theame and color palletes in a different class.
   * ```app_pallete.dart```:

     * ```dart
        import 'package:flutter/material.dart';

        class Pallete{
        static const cardColor = Color.fromRGBO(30, 30, 30, 1);
        static const greenColor = Colors.green;
        static const subtitleText = Color(0xffa7a7a7);
        static const inactiveBottomBarItemColor = Color(0xffababab);

        static const Color backgroundColor = Color.fromRGBO(18, 18, 18, 1);
        static const Color gradient1 = Color.fromRGBO(187, 63, 221, 1); 
        static const Color gradient2 = Color.fromRGBO(251, 109, 169, 1);
        static const Color gradient3 = Color.fromRGBO(255, 159, 124, 1);
        static const Color borderColor = Color.fromRGBO(52, 51, 67, 1);
        static const Color whiteColor = Colors.white;
        static const Color greyColor = Colors.grey; 
        static const Color errorColor = Colors.redAccent; 
        static const Color transparentColor = Colors.transparent; 

        static const Color inactiveSeekColor = Colors.white38;
        }
       ```

    * ```theme.dart```:

      * ```dart
            import 'package:flutter/material.dart';
            import 'package:spotify_clone_client/core/theme/app_pallete.dart';

            class AppTheame {
            static OutlineInputBorder _border(Color borderSideColor) => OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: borderSideColor, width: 3),
            );
            static final darkThemeMode = ThemeData.dark().copyWith(
                scaffoldBackgroundColor: Pallete.backgroundColor,
                inputDecorationTheme: InputDecorationTheme(
                contentPadding: EdgeInsets.all(20),
                enabledBorder: _border(Pallete.borderColor), // Look of initial button
                focusedBorder: _border(Pallete.gradient2), // Will focus when the button is clicked to type
                ),
            );
            }
        ```

3. Key points that are learned in the ```lib\feature\auth\view\signup.dart```:
   1. Learned to Create a Column.
   2. Learned to Create a TextFormField() which is later saved to widget folder.
   3. And for the TextFormField() we also added the theam for decoration in the ```lib\core\theme\theme.dart``` file where we mention ```inputDecorationTheme: InputDecorationTheme()``` so that we can use the same theme for all the TextFormField() in the app but also can overwrite by mentioning what we need on the particular widget inputDecoration whenever needed.
   4. Learned to create a function ```static OutlineInputBorder _border()``` function.
   5. Learned to get data to function for dynamic changes.
   6. Also, Learned that we need to write variable under the ```extends State<PageName>{```
   7. Learned that we need to write ```dispose``` function after the variable declaration.

      ```dart
      @override 
      void dispose(): 
        nameController.dispose();
        super.dispose();
      ```

   8. Learned to add Elevated button widget.
   9. Learned to wrape Container on top of the Elevated Widget so that we can add gradient where the parant(Container) will pass it's properties to it's Child(Elevated Button)
   10. Moreover, after adding the container, on the Elevated widget's ```ElevatedButton.styleFrom()``` add backgroundColor and shadowColor to transparent color.
   11. Learned to add RichText to the page, for RichText it is understood that we need to create a TextSpan() for the text widget and then inside the TextSpan() we need to create a children where it contains a lot of other TextSpan to seperate text styles.
   12. Learned to wrape Column (Not the Padding which wrapped the Column) but only the Column with Form() so that we can add ```GlobalKey<FormState>()``` to the form so we can validate with required logic easily.
