import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:todo_movies/src/modules/movies/external/tmdb_datasource.dart';
import 'package:todo_movies/src/modules/movies/infra/datasources/movie_datasource_base.dart';
import 'package:todo_movies/src/shared/modules/api_service/domain/services/api_service_base.dart';
import 'package:todo_movies/src/shared/modules/api_service/infra/services/api_service.dart';

void main() {
  group('TMDBDatasource', () {
    final Dio dio = Dio(BaseOptions());
    final DioAdapter dioAdapter = DioAdapter(dio: dio);
    final ApiServiceBase service = ApiService(apiKey: 'unussedKey', dio: dio);
    final MovieDatasourceBase datasource = TMDBDatasource(service);

    test('getMovieDetail', () async {
      const movieId = 639933;
      const endpoint = '/movie/$movieId';

      dioAdapter.onGet(endpoint, (server) => server.reply(200, rawGetMovieDetail));

      final data = await datasource.getMovieDetail(movieId);

      expect(data['adult'], false);
      expect(data['vote_average'], 7.3);
      expect(data['title'], 'O Homem do Norte');
      expect(data['release_date'], '2022-04-07');
      expect((data['production_companies'] as List).length, 4);
    });

    test('getMoviesGenres', () async {
      const endpoint = '/genre/movie/list';

      dioAdapter.onGet(endpoint, (server) => server.reply(200, rawGetMovieGenres));

      final data = await datasource.getMovieGenres();

      expect(data.length, 19);

      expect(data.first['id'], 28);
      expect(data.first['name'], 'Ação');
      expect(data.last['id'], 37);
      expect(data.last['name'], 'Faroeste');
    });

    test('getSimilarMovies', () async {
      const movieId = 639933;
      const endpoint = '/movie/$movieId/similar';

      dioAdapter.onGet(endpoint, (server) => server.reply(200, rawGetMovieRecommendations));

      final data = await datasource.getSimilarMovies(movieId);

      expect(data.length, 3);
      expect(data.first['id'], 453395);
      expect(data.first['title'], 'Doutor Estranho no Multiverso da Loucura');
      expect(data.last['id'], 752623);
      expect(data.last['title'], 'Cidade Perdida');
    });

    test('getMoviesNowPlaying', () async {
      const endpoint = '/movie/now_playing';

      dioAdapter.onGet(endpoint, (server) => server.reply(200, rawGetMoviesNowPlaying));

      final data = await datasource.getMoviesNowPlaying();

      expect(data.length, 3);
      expect(data.first['id'], 639933);
      expect(data.first['title'], 'O Homem do Norte');
      expect(data.last['id'], 507086);
      expect(data.last['title'], 'Jurassic World: Domínio');
    });
  });
}

const rawGetMovieDetail = {
  'adult': false,
  'backdrop_path': '/cqnVuxXe6vA7wfNWubak3x36DKJ.jpg',
  'belongs_to_collection': null,
  'budget': 70000000,
  'genres': [
    {'id': 28, 'name': 'Ação'},
    {'id': 12, 'name': 'Aventura'},
    {'id': 14, 'name': 'Fantasia'}
  ],
  'homepage': 'https://www.focusfeatures.com/the-northman',
  'id': 639933,
  'imdb_id': 'tt11138512',
  'original_language': 'en',
  'original_title': 'The Northman',
  'overview':
      'Baseado na obra de Shakespeare, Hamlet, e na lenda viking de Amelth. No ano de 914, o príncipe Amleth (Alexander Skarsgård) testemunha o brutal assassinato de seu pai, Horvendill (Ethan Hawke) por seu tio, Fjölnir (Claes Bang). O menino foge mas jura que voltará para vingar seu pai, salvar sua mãe e matar seu tio. Vinte anos depois conhece uma vidente que o lembra que é chegada a hora de cumprir sua promessa.',
  'popularity': 2440.073,
  'poster_path': '/mqCLGi2YxlqwWeGN7NRILYQOhm.jpg',
  'production_companies': [
    {
      'id': 10104,
      'logo_path': '/hNuGhsKVlmhnwSRcmOejDBDjh6w.png',
      'name': 'New Regency Pictures',
      'origin_country': 'US'
    },
    {
      'id': 10146,
      'logo_path': '/xnFIOeq5cKw09kCWqV7foWDe4AA.png',
      'name': 'Focus Features',
      'origin_country': 'US'
    },
    {
      'id': 10338,
      'logo_path': '/el2ap6lvjcEDdbyJoB3oKiYgXu9.png',
      'name': 'Perfect World Pictures',
      'origin_country': 'CN'
    },
    {'id': 123620, 'logo_path': null, 'name': 'Square Peg', 'origin_country': 'US'}
  ],
  'production_countries': [
    {'iso_3166_1': 'US', 'name': 'United States of America'}
  ],
  'release_date': '2022-04-07',
  'revenue': 68350700,
  'runtime': 137,
  'spoken_languages': [
    {'english_name': 'English', 'iso_639_1': 'en', 'name': 'English'},
    {'english_name': 'Icelandic', 'iso_639_1': 'is', 'name': 'Íslenska'}
  ],
  'status': 'Released',
  'tagline': '',
  'title': 'O Homem do Norte',
  'video': false,
  'vote_average': 7.3,
  'vote_count': 1502
};

const rawGetMovieGenres = {
  'genres': [
    {'id': 28, 'name': 'Ação'},
    {'id': 12, 'name': 'Aventura'},
    {'id': 16, 'name': 'Animação'},
    {'id': 35, 'name': 'Comédia'},
    {'id': 80, 'name': 'Crime'},
    {'id': 99, 'name': 'Documentário'},
    {'id': 18, 'name': 'Drama'},
    {'id': 10751, 'name': 'Família'},
    {'id': 14, 'name': 'Fantasia'},
    {'id': 36, 'name': 'História'},
    {'id': 27, 'name': 'Terror'},
    {'id': 10402, 'name': 'Música'},
    {'id': 9648, 'name': 'Mistério'},
    {'id': 10749, 'name': 'Romance'},
    {'id': 878, 'name': 'Ficção científica'},
    {'id': 10770, 'name': 'Cinema TV'},
    {'id': 53, 'name': 'Thriller'},
    {'id': 10752, 'name': 'Guerra'},
    {'id': 37, 'name': 'Faroeste'}
  ]
};

const rawGetMovieRecommendations = {
  'page': 1,
  'results': [
    {
      'adult': false,
      'backdrop_path': '/gUNRlH66yNDH3NQblYMIwgZXJ2u.jpg',
      'genre_ids': [14, 28, 12],
      'id': 453395,
      'media_type': 'movie',
      'title': 'Doutor Estranho no Multiverso da Loucura',
      'original_language': 'en',
      'original_title': 'Doctor Strange in the Multiverse of Madness',
      'overview':
          'Doutor Estranho, com a ajuda de aliados místicos antigos e novos, atravessa as perigosas realidades alternativas e alucinantes do Multiverso para enfrentar um novo adversário misterioso.',
      'popularity': 2080.956,
      'poster_path': '/boIgXXUhw5O3oVkhXsE6SJZkmYo.jpg',
      'release_date': '2022-05-04',
      'video': false,
      'vote_average': 7.411,
      'vote_count': 2274
    },
    {
      'adult': false,
      'backdrop_path': '/fIwiFha3WPu5nHkBeMQ4GzEk0Hv.jpg',
      'genre_ids': [28, 12, 878],
      'id': 545611,
      'media_type': 'movie',
      'title': 'Tudo em Todo o Lugar ao Mesmo Tempo',
      'original_language': 'en',
      'original_title': 'Everything Everywhere All at Once',
      'overview':
          'Michelle Yeoh interpreta Evelyn Wang, uma cansada mulher chinesa-americana que luta para se manter. As coisas ficam estranhas quando ela descobre que é a chave para salvar o multiverso, e pode acessar o conhecimento e os talentos de todos os seus vários “eus” através dos infinitos universos.',
      'popularity': 243.982,
      'poster_path': '/iCvQFLywQLuolTWjRJPRfWWbr1C.jpg',
      'release_date': '2022-03-24',
      'video': false,
      'vote_average': 8.345,
      'vote_count': 640
    },
    {
      'adult': false,
      'backdrop_path': '/1Ds7xy7ILo8u2WWxdnkJth1jQVT.jpg',
      'genre_ids': [28, 12, 35],
      'id': 752623,
      'media_type': 'movie',
      'title': 'Cidade Perdida',
      'original_language': 'en',
      'original_title': 'The Lost City',
      'overview':
          'Uma romancista reclusa acredita que nada seria pior que fazer a turnê do seu livro mais recente com o modelo que ilustra a capa. Tudo muda quando a autora e o modelo sofrem uma tentativa de sequestro, e, com isso, são levados para uma surpreendente aventura na selva.',
      'popularity': 3088.189,
      'poster_path': '/vsX9gj7t56ZlMYKNYccskeW5adT.jpg',
      'release_date': '2022-03-24',
      'video': false,
      'vote_average': 6.781,
      'vote_count': 1167
    }
  ],
  'total_pages': 2,
  'total_results': 40
};

const rawGetMoviesNowPlaying = {
  'dates': {'maximum': '2022-06-21', 'minimum': '2022-05-04'},
  'page': 1,
  'results': [
    {
      'adult': false,
      'backdrop_path': '/cqnVuxXe6vA7wfNWubak3x36DKJ.jpg',
      'genre_ids': [28, 12, 14],
      'id': 639933,
      'original_language': 'en',
      'original_title': 'The Northman',
      'overview':
          'Baseado na obra de Shakespeare, Hamlet, e na lenda viking de Amelth. No ano de 914, o príncipe Amleth (Alexander Skarsgård) testemunha o brutal assassinato de seu pai, Horvendill (Ethan Hawke) por seu tio, Fjölnir (Claes Bang). O menino foge mas jura que voltará para vingar seu pai, salvar sua mãe e matar seu tio. Vinte anos depois conhece uma vidente que o lembra que é chegada a hora de cumprir sua promessa.',
      'popularity': 2440.073,
      'poster_path': '/mqCLGi2YxlqwWeGN7NRILYQOhm.jpg',
      'release_date': '2022-05-12',
      'title': 'O Homem do Norte',
      'video': false,
      'vote_average': 7.3,
      'vote_count': 1500
    },
    {
      'adult': false,
      'backdrop_path': '/kiH3KPWi7BaRMvdAigcwrUFViHl.jpg',
      'genre_ids': [28, 53, 80],
      'id': 818397,
      'original_language': 'en',
      'original_title': 'Memory',
      'overview':
          'Em Assassino Sem Rastro, Alex Lewis é um assassino experiente com reputação de precisão discreta. Preso em um dilema moral, Alex se recusa a concluir um trabalho que viola seu código de ética e deve rapidamente caçar e matar as pessoas que o contrataram antes que eles e o agente do FBI Vincent Serra o encontrem primeiro. Alex tinha o objetivo de se vingar, mas, com uma memória que começa a vacilar, ele é forçado a questionar todas as suas ações, se perdendo na linha entre o certo e o errado.',
      'popularity': 2310.293,
      'poster_path': '/uEPJQY1kEEz9XoZZ8rP6p9JUrmv.jpg',
      'release_date': '2022-06-09',
      'title': 'Assassino Sem Rastro',
      'video': false,
      'vote_average': 7.3,
      'vote_count': 289
    },
    {
      'adult': false,
      'backdrop_path': '/wo3l9p0S7pcvwlzlndtKgq0peRJ.jpg',
      'genre_ids': [28, 12, 878],
      'id': 507086,
      'original_language': 'en',
      'original_title': 'Jurassic World Dominion',
      'overview':
          'Quatro anos após a destruição da Ilha Nublar, os dinossauros agora vivem – e caçam – ao lado de humanos em todo o mundo. Esse frágil equilíbrio remodelará o futuro e determinará, de uma vez por todas, se os seres humanos continuarão sendo os principais predadores em um planeta que agora compartilham com as criaturas mais temíveis da história.',
      'popularity': 2240.933,
      'poster_path': '/rvX8f3QuUkYtirO0hL9CoeXMzkv.jpg',
      'release_date': '2022-06-02',
      'title': 'Jurassic World: Domínio',
      'video': false,
      'vote_average': 6.7,
      'vote_count': 526
    }
  ],
  'total_pages': 5,
  'total_results': 91
};
