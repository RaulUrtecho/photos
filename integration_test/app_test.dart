import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photos/ui/app.dart';
import 'package:photos/ui/photos_screen.dart';

void main() {
  // Ensure that Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  testWidgets('App displays photo items', (tester) async {
    // Build the widget tree
    await tester.pumpWidget(const App());

    // Verify that we're initially on the PhotoListScreen
    expect(find.byType(PhotosScreen), findsOneWidget);

    /// Redraw
    await tester.pump(const Duration(seconds: 3));

    // Verify that we're initially on the PhotoListScreen
    expect(find.byType(ListTile), findsAtLeast(1));

    // Delay before close app
    await tester.pump(const Duration(seconds: 2));
  });
}
