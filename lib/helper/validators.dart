import 'package:form_field_validator/form_field_validator.dart';

final creatorValidator =
    MultiValidator([RequiredValidator(errorText: 'Creator name is required')]);

final movie =
    MultiValidator([RequiredValidator(errorText: 'Movie name is required')]);

final imdbValidator = MultiValidator(
  [RequiredValidator(errorText: 'IMDB is required')],
);
