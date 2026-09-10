# Building a Spotify Like Clone

## What do we use here

1. MVVM Architecture
2. Flutter for Frontend
3. FastAPI for Backend
4. PostgresSql for Database
5. Hive for local DataStorage
6. Riverpod for StateManagement
7. Auth State Persistant

## Extensions and Other Needed Information

### Extension

1. Flutter Widget Snippets by Alexis Villegas Torres
2. Error Lens by Alexander (If needed install, not required)

## Dart Foundations

1. How to write class.

   ```dart
   class ClassName{
      String variableName;
      bool variable2;
      ClassName({required this.variableName, this.variable2 = False})
   }
   ```

2. What is ```factory```?
   * ```factory``` is a constructor for a calss, but we can customize how we need the data to be passed (As per my understanding).

   ```dart
   class GetStudents{
      String name;
      String email;
      bool topStudent;
      GetStudents({required this.name, required this.email, this.topStudent = True})

      factory GetStudents.fromMap(<String, dynamic>map){
         return GetStudents(
            name:map['name'] as String, 
            email: map['email'] as String, 
            topStudent: map['topStudent'] as bool
         );
      }

      factory GetStudent.fromJson(String source){ // Factory will return an object with the class model
         return GetStudent(
            name:map['name'] as String, 
            email:map['email'] as String
         );
      }
   }
   ```

## Pub Dependency Needed

### Production

1. flutter_riverpod :> Provides us with various providers.
2. riverpod_annotation :> Provides us with @riverpods which helps us to generate providers

### Dev

1. riverpod_lint
2. riverpod_generator :> Allows us to generat our providers, it will see the @riverpod/annotation
3. flutter_lints :
   1. Will provide a lot of clean code practices when using riverpod
   2. Convert a Widget.
   3. Convert a stateless widget -> Consumer Widget
   4. Convert a Consumer Widget -> Consumer Stateful Widget
4. build_runner :> Help us to generate code just as riverpod_generator do

## Riverpod

1. Let's learn in this manner:

   ```
   1. What is State?
         ↓
   2. Why do we need State Management?
         ↓
   3. What is Riverpod?
         ↓
   4. What is a Provider?
         ↓
   5. ProviderScope
         ↓
   6. ref
         ↓
   7. ref.watch()
         ↓
   8. ref.read()
         ↓
   9. Changing State
         ↓
   10. Notifier
         ↓
   11. AsyncNotifier
         ↓
   12. API calls
         ↓
   13. Authentication state
         ↓
   14. Riverpod + Flutter architecture
         ↓
   15. Code generation
   ```

### State

* Data that can change when the app is running.
* For instances, Variables that can change it's value when the app is running.

### StateManagement

* Consider that we have multiple pages, and all the pages needs to know what user is currently loggedin.
* If we dont have a proper state management, then we need to pass the current logged in user manually as a function or a class to all the pages.
* However, if there is a statemanagement, we can create a file and manage the state there and all the other pages will be automatically updated when there is a change.

### Riverpod

* Riverpod is like a container that can store all the applicatin state(variable).
* This is like a shared storage box.

  ```
                   Riverpod
              ┌─────────────┐
              │             │
              │ currentUser │
              │             │
              │ counter     │
              │             │
              │ isLoading   │
              │             │
              └─────────────┘
                ↑    ↑    ↑
                │    │    │
              Home Profile Settings
  ```

* All the pages/widgets can access the state from the riverpod state

### Provider

* This is the first riverpod we need to understand.
* A ```Provider``` is basically something that provides a value/state to the application

* ```dart
  final nameProvider=Provider<String>((ref){
   return "SVP";
  });
  ```

* This above code says, ```I am a provider, and I provide a String and the value I provide is SVP```

### Provider Scope

* This answers the question: ```How does flutter access the state/provider```.
* At the top of the flutter app, we can have a ```ProviderScope``` which says, all the child widgets can have access to the provider.
* So everything under the ProviderScope can use Riverpod

* ```dart
  void main(){
   runApp(const ProviderScope(child: MyApp()));
  }
  ```

* ```
   ProviderScope
         │
         └── MyApp
               │
               ├── Home
               ├── Profile
               └── Settings
  ```

* ProviderScope is the container/environment that allows Riverpod providers to work.

### Reading a Provider

* ```dart
  final nameProvider = Provider<String>((ref) {
  return "SVP";
   });
  ```

* In a ```ConsumerWidget```:

  ```dart
  class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(nameProvider);

    return Text(name);
   }
   }
  ```

* There are only 2 things:
  1. ConsumerWidget
  2. ref

### Ref

* Ref is like a handle/connection to Riverpod.
* Through ```ref``` we can interact with ```Providers```

* ```
   ref

   │
   ├── watch()
   ├── read()
   └── listen()

  ```

### ref.watch()

* ref.watch(provider) says: ```Riverpod, give me the provider's value and keep watching it```.
* Also, we can say: ```Give me the provider's value and rebuild the widget's if the value changes```.

### ref.read()

* ref.read(provider) says: ```Riverpod, give me the provider's value and I don't need to watch it```.
* This just collects the data and leaves, if the value changes the widget's wont be updated as this is only read not watch.

### Notifier

* A ```Notifier``` is an object that owns and controls a piece of state

* ```
                Notifier
                 │
        ┌────────┴────────┐
        │                 │
      State            Actions
        │                 │
     counter          increment()
        │                 │
        0                 +
  ```

* The ```Notifier``` knows it's state and can also change it's state.

#### Create a Notifier

```dart
class NewNotifier extends Notifier<int>{
   @override 
   int build(){
      return 0;
   }
}
```

* The above class extends Notifier which has a type of int and the @override override's the parent's build function and return the initial state which is 0 in this case.
* We can also say, this class is a RiverPod Notifier and the state it manages is int.

* ```
  Notifier<int>
       ↑
       │
    state type
  ```

### Still Need a Provider

* Needs a provider, becuase that's how we can read, watch the state

* ```dart
  final newProvider=NotifierProvider<NewNotifier, int>(
   NewNotifier.new, 
  )
  ```

* What does this do:

  ```
   CounterNotifier
         ↓
   counterProvider
         ↓
   Flutter widgets
  ```

* Now we can do: ```final newValue=ref.watch(newProvider);```

### How to change the value

```dart
class CounterNotifier extends Notifier<int>{
   @override 
   int build(){
      return 0
   }

   void increment(){
      state++; //State comes from the Notifier, and holds the current state value
   }
}

final counterProvider=NotifierProvider<CounterNotifier, int>(
   CounterNotifier.new
);
```

* The above code snippets shows how to build and notifier and provider.
* To watch we can simply this following code: ```ref.watch(counterProvider)```
* To call the increment function to update/increment the value we can do this: ```ref.read(counterProvider.notifier).increment()```
* This ref.read() will call the notifier first from the provider and then calls the increment function to run.
* ref.read(provider) will only give the current state, but ref.read(provider.notifier) says give the Notifier itsef.

* ```
  counterProvider
      │
      ├──────────────→ state
      │                  0
      │
      └──────────────→ notifier
                         │
                         └── increment()
  ```

* Also,

  ```
                Riverpod
                 │
        ┌────────┴────────┐
        ↓                 ↓
      STATE            NOTIFIER
        │                 │
        ↓                 ↓
     watch()            read()
        │                 │
        ↓                 ↓
      display          perform action
  ```

## Other Needed Information

1. How to do formatting?
   1. ```ctl + p``` to go to settings on Windows.
   2. Search for ```format on save``` and enable ```Editor: Format On Save``` Option

## Main Folder Required Files/Folder

1. Client :> flutter create . (Which create all the file & folder with this command)
2. Server :>

## MVVM Architecutre

1. View :> V
2. ViewModel :> VM
3. Model :> M

![alt text](data/images/image.png)

### What are each components and how do they interact with each other?

#### Model (Contains repository/ Database/ API)

1. Represent the data and business logic of the application.
2. It is responsible to handle data that is coming from database, or API or anyother source

#### View (UI)

1. Represent the UI Components that display the data
2. All UI related stuffs.

#### ViewModel (State Management)

1. Acts as a birdge between View and Model.
2. Handles the logic to present the data to view and respond to user's actions.
3. It manages what state the view is showing eg(Is it showing a circular progress indicator or is it showing a data? or is it showing an error message? etc..)
4. VM determines weather view should show it or not.

## Structuring Folders/Dir

Basic Folder Structure:

1. Inside Lib:
   * core :> That contains all resources that are shared across all the features in the application.
     * theam/
       * app_pallet.dart:
         * ![alt text](data/images/pallete.png)
       * theme.dart:
         * ![alt text](data/images/app_theme.png)
       * a
       * a
       * a

2. Because the folders can pile up a lot of files a lot quickly.
3. We can use ```feature vise development```
   1. Auth feature
   2. Home feature
4. All the feature will have it's own View, Model and ViewModel
5. We use this because, if needed to clean up this will be easy because.
   * Files and classes created inside auth feature cannot be used in home feature.
   * If auth features are called inside the home feature then deleting the auth feature will have errors across all features eliminating the purpose of Feature-Wise development.

### Inside View Folder

1. We will have 2 sub folder.
   1. pages.
   2. widgets. (Reusabe widgets across the view folder)
