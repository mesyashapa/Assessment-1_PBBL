import 'package:flutter_test/flutter_test.dart';
import 'package:todo_bloc_app/main.dart';

void main() {
testWidgets('App loads successfully', (WidgetTester tester) async {
await tester.pumpWidget(const MyApp());


expect(find.text('Todo App'), findsOneWidget);


});
}
