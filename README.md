<h1 align="center">Todo Movies 0</h1>

<div align="center">

Aplicativo desenvolvido como um teste tendo o objetivo de recriar parte do aplicativo [TodoMovies](https://apps.apple.com/br/app/todomovies-4id792499896) utilizando a [API](https://www.themoviedb.org) do The Movies Database.

![GitHub release (latest by date)](https://img.shields.io/github/v/release/schuberty/Todo-Movies)
![GitHub last commit](https://img.shields.io/github/last-commit/schuberty/Todo-Movies?color=yellow)

</div>

# Arquitetura

Aplicativo desenvolvido na versão 3.0.2 do [Flutter](https://flutter.dev) utilizando [BLoC](https://pub.dev/packages/flutter_bloc) e [Provider](https://pub.dev/packages/provider) para gerência de estados e injeção de dependências, pacote [Dio](https://pub.dev/packages/dio) para requisições da API e [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) como padrão da arquitetura do software.

# Como Usar o Repositório

Após clona-lo, certifique-se de:

1. Rodar o comando `flutter pub get` para obter os pacotes mencionados no [pubspec.yaml](./pubspec.yaml).
2. Adicionar a sua Chave da API no arquivo [app_secrets.dart](./lib/src/shared/app_secrets.dart) no valor da constante _apiKeyMovieDB_.
   - A chave pode ser obtida nas [Configurações de API](https://www.themoviedb.org/settings/api) da sua conta no TMDB.
3. Rodar o aplicativo a partir da sua IDE preferida ou com o comando `flutter run`.

# Tempo Desenvolvimento

Média do tempo do desenvolvimento dos módulos, testes e outros componentes do aplicativo pode ser observado na tabela abaixo.

| Tarefa                                          | Tempo Médio |
| ----------------------------------------------- | :---------: |
| Regra de negócio do módulo Movies e seus testes |   5 horas   |
| Módulo Home e componentes derivados             |   2 horas   |
| Página de detalhes do filme                     |  12 horas   |
|                                                 |             |
| Tempo requisitos básicos                        |  12 horas   |
| **Tempo total**                                 |  19 horas   |

Aplicativo foi testado somente na plataforma Android, não sabendo como pode se comportar em um dispositivos iOS.

