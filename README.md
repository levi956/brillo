# BrilloConnect Mobile Engineer Assessment


## Installation
1. Find attached an apk file in the "apk" folder directory of the project.

or 

1. Make sure you have [Flutter](https://flutter.dev/docs/get-started/install) and its dependencies installed on your device.
2. Clone the repository: `git clone https://github.com/yourusername/my-app.git`
3. Go to the project directory: `cd my-app`
4. Run `flutter pub get` to install the dependencies.
5. Run `flutter run` to start the app on an emulator or connected device.


## User Interface
The application features the principle "Component Driven Design" which enables a clean and user-friendly interface, with widgets broken down into several components, following the DRY principle to enable easier maitenance and usabiliy.

## Technical details
- The application is built with Flutter, using the Dart programming language.
- The major state management used is "Riverpod" & "Flutter Hooks".
- The app intends to follows functional, object oriented and imperative programming paradigms.
- The application uses [Supabase](https://supabase.com/), a backend software as a service to authenticate and store data.


## Feature Interface
- [x] Landing Page
- [x] Sign Up Page
- [x] Login Page
- [x] Select sport interest
- [x] Profile Dashboard
- [x] Settings and Privacy


## Screenshots

| Database relational table | 
|    :---:     |   
| <img src="graphics/schema.png" width="500">   | 



| Get Started Screen | Sign In | 
|    :---:     |     :---:      |  
| <img src="graphics/landing.png" width="500">   | <img src="graphics/login.png" width="500">   |

| Forgot Password | Register Screen | 
|    :---:     |     :---:      |  
| <img src="graphics/forgot_password.png" width="500">   | <img src="graphics/register.png" width="500">   |

| Select Sport Interest | 
|    :---:     |   
| <img src="graphics/interest.png" width="500">   | 

|  Home |  Settings | 
|    :---:     |     :---:      |  
| <img src="graphics/home.png" width="500">   | <img src="graphics/settings.png" width="500">   |



## Running Tests 

To run all unit tests use the following command:

```flutter test```

