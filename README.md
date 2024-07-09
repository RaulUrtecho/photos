# Photos App
This is a Flutter application that retrieves and displays photos from a remote API endpoint using MVVM architecture and reactive programming with Streams as simple state managment.

### Architecture used:
The application follows the **MVVM (Model-View-ViewModel)** architectural pattern to separate concerns and improve maintainability and testability. Where:

Model: The Photo model defines the structure of each photo retrieved from the API.

View: The PhotosScreen widget is responsible for rendering the list of photos using a StreamBuilder.

ViewModel:  The PhotosViewModel handles business logic, state management, and data manipulation. It interacts with the PhotosRepository to fetch photos and exposes them via a stream to the View.

**SOLID Principles**

Single Responsibility Principle:
- PhotosService is responsible for making HTTP requests to the API and handling responses.
- PhotosRepository manages the data access logic, abstracting the source of data.
- PhotosViewModel Manages the state and logic needed for the UI, including handling errors and loading states.

Open/Closed Principle
Most of the entities were designed to be open for extension (e.g., adding more features, integrating different APIs) 
but closed for modification to existing code that works.

Liskov Substitution Principle
Abstractions like PhotosRepository allow different implementations (e.g., different data sources) to be substituted without affecting the rest of the application logic.

Interface Segregation Principle
Components like PhotoViewModel and PhotoRepository have clear interfaces (fetchPhotos, photoStream) that segregate their responsibilities and make them easier to use and maintain.

Dependency Inversion Principle
High-level modules (PhotosViewModel) depend on abstractions (PhotosRepository) rather than concrete implementations (PhotoService). This allows for flexibility and easier unit testing.


### Getting Started
Clone the repository:


```sh
git clone https://github.com/your/repository.git
```
Navigate to the project directory:
```sh
cd photos
```
Install dependencies:

```sh
flutter pub get
```
Connect a real device or use a emulator and run the application:

```sh
flutter run
```
### Integrations test

To run integration test connect a real device or use a emulator and run:

```sh
flutter test integration_test/app_test.dart
```

### Folder Structure
models/: Contains data models like photo.dart.
services/: Handles data fetching logic from external sources (photos_service.dart).
repositories/: Manages data access logic, abstracting the data source (photos_repository.dart).
ui/: Holds UI components, including screens and widgets (app.dart and photos_screen.dart).
ui/view_model/: Contains business logic and state management for the PhotosScreen (photos_view_model.dart).
