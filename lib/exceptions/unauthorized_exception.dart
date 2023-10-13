import 'dart:io';

class UnauthorizedException extends HttpException {
  UnauthorizedException(
    super.message, {
    super.uri,
  });
}
