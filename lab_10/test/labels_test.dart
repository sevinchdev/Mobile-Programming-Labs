import 'package:flutter_test/flutter_test.dart';
import 'package:tm_classifier/services/labels.dart';

void main() {
  test('parses the normal case', () {
    expect(parseLabels('0 Mug\n1 Bottle\n'), ['Mug', 'Bottle']);
  });

  test('handles Windows line endings, blank line and spaces in labels', () {
    expect(
      parseLabels('0 Mug\r\n1 Bottle\r\n2 Car keys\r\n\r\n'),
      ['Mug', 'Bottle', 'Car keys'],
    );
  });
}