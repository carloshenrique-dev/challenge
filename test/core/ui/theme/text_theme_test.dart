import 'package:flutter_test/flutter_test.dart';
import 'package:challenge/core/ui/theme/text_theme.dart';

void main() {
  test('Test AppTheme default values', () {
    final theme = AppTheme.theme;

    expect(theme.useMaterial3, true);

    expect(theme.textTheme.bodyLarge!.fontFamily, 'Hubot');
    expect(theme.textTheme.bodyLarge!.fontSize, 18);

    expect(theme.textTheme.bodyMedium!.fontFamily, 'Hubot');
    expect(theme.textTheme.bodyMedium!.fontSize, 16);

    expect(theme.textTheme.bodySmall!.fontFamily, 'Hubot');
    expect(theme.textTheme.bodySmall!.fontSize, 14);

    expect(theme.textTheme.titleLarge!.fontFamily, 'Hubot');
    expect(theme.textTheme.titleLarge!.fontSize, 18);

    expect(theme.textTheme.titleMedium!.fontFamily, 'Hubot');
    expect(theme.textTheme.titleMedium!.fontSize, 16);

    expect(theme.textTheme.titleSmall!.fontFamily, 'Hubot');
    expect(theme.textTheme.titleSmall!.fontSize, 14);

    expect(theme.textTheme.labelLarge!.fontFamily, 'Hubot');
    expect(theme.textTheme.labelLarge!.fontSize, 16);
  });
}
