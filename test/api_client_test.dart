import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  const baseUrl = 'http://localhost:8000';

  group('ApiClient Experience & Auth', () {
    test('getExperiences parses snake_case JSON and defaults on 200', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.toString(), '$baseUrl/api/v1/experiences/');
        expect(request.headers['Accept'], 'application/json');

        return http.Response(
          jsonEncode([
            {
              'id': 'exp-uuid-1',
              'title': 'Software Engineer Intern',
              'description': 'Built REST APIs and Flutter UI.',
              'category': 'internship',
              'category_display': 'Internship',
              'thumbnail': null,
              'is_ongoing': true,
              'star_count': 3,
              'is_starred': false,
              'experience_img': null,
              'starred_by_names': 'alice, bob',
            },
          ]),
          200,
        );
      });

      final apiClient = ApiClient(client: mockClient, baseUrl: baseUrl);
      final experiences = await apiClient.getExperiences();

      expect(experiences, hasLength(1));
      expect(experiences.first.id, 'exp-uuid-1');
      expect(experiences.first.title, 'Software Engineer Intern');
      expect(experiences.first.categoryDisplay, 'Internship');
      expect(experiences.first.thumbnail, '');
      expect(experiences.first.experienceImg, '');
      expect(experiences.first.isOngoing, isTrue);
      expect(experiences.first.starCount, 3);
      expect(experiences.first.starredByNames, 'alice, bob');
    });

    test(
      'createExperience sends Token header and omits read-only fields on 201',
      () async {
        final mockClient = MockClient((request) async {
          expect(request.method, 'POST');
          expect(request.url.toString(), '$baseUrl/api/v1/experiences/');
          expect(request.headers['Authorization'], 'Token test-token-123');
          expect(request.headers['Content-Type'], contains('application/json'));

          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['title'], 'Teaching Assistant');
          expect(body['category'], 'academic');
          expect(body.containsKey('id'), isFalse);
          expect(body.containsKey('category_display'), isFalse);
          expect(body.containsKey('is_ongoing'), isFalse);
          expect(body.containsKey('star_count'), isFalse);
          expect(body.containsKey('is_starred'), isFalse);
          expect(body.containsKey('experience_img'), isFalse);
          expect(body.containsKey('starred_by_names'), isFalse);

          return http.Response(
            jsonEncode({
              'id': 'exp-uuid-2',
              'title': body['title'],
              'description': body['description'],
              'category': body['category'],
              'category_display': 'Academic',
              'thumbnail': body['thumbnail'],
              'is_ongoing': false,
              'star_count': 0,
              'is_starred': false,
              'experience_img': '',
              'starred_by_names': '',
            }),
            201,
          );
        });

        final apiClient = ApiClient(client: mockClient, baseUrl: baseUrl);
        const payload = Experience(
          id: 'should-not-be-sent',
          title: 'Teaching Assistant',
          description: 'Assisted PBP lab sessions.',
          category: 'academic',
          thumbnail: 'https://example.com/thumb.png',
        );

        final created = await apiClient.createExperience(
          payload,
          token: 'test-token-123',
        );

        expect(created.id, 'exp-uuid-2');
        expect(created.categoryDisplay, 'Academic');
      },
    );

    test(
      'createExperience throws ApiException(401) on invalid token',
      () async {
        final mockClient = MockClient(
          (_) async => http.Response('{"detail": "Invalid token."}', 401),
        );

        final apiClient = ApiClient(client: mockClient, baseUrl: baseUrl);
        const payload = Experience(
          title: 'Test',
          description: 'Test description',
          category: 'work',
        );

        await expectLater(
          () => apiClient.createExperience(payload, token: 'expired-token'),
          throwsA(
            isA<ApiException>().having((e) => e.statusCode, 'statusCode', 401),
          ),
        );
      },
    );

    test('getExperiences throws ApiException(500) on server error', () async {
      final mockClient = MockClient(
        (_) async => http.Response('Internal Server Error', 500),
      );

      final apiClient = ApiClient(client: mockClient, baseUrl: baseUrl);

      await expectLater(
        apiClient.getExperiences,
        throwsA(
          isA<ApiException>().having((e) => e.statusCode, 'statusCode', 500),
        ),
      );
    });

    test('obtainToken and logout interact with auth endpoints', () async {
      final mockClient = MockClient((request) async {
        if (request.url.path == '/api/v1/auth/token/') {
          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['username'], 'admin');
          expect(body['password'], 'secret');
          return http.Response(jsonEncode({'token': 'abc-token'}), 200);
        }
        if (request.url.path == '/api/v1/auth/logout/') {
          expect(request.headers['Authorization'], 'Token abc-token');
          return http.Response('', 204);
        }
        return http.Response('Not Found', 404);
      });

      final apiClient = ApiClient(client: mockClient, baseUrl: baseUrl);
      final token = await apiClient.obtainToken('admin', 'secret');
      expect(token, 'abc-token');

      await apiClient.logout(token: token);
    });
  });
}
