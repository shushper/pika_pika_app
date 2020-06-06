import 'package:network/network.dart';
import 'package:pika_pika_app/domain/post_message.dart';

/// Репозиторий

const _tmpBody = '''
В ноябре 2018 года началось строительство новой железнодорожной ветки 
Мга-Кириши-Будогощь. 
Все бы ничего, но строительство новой ветки РЖД сопровождается регулярной 
доставкой песка большегрузами компании застройщика, с карьеров Малукса. 
Около 10-15 авто 24 часа в сутки, 7 дней в неделю возят песок с карьеров 
по грунтовой дороге, которая помимо того, что ведет к карьерам, она еще ведет 
к участкам садоводческих товариществ, которых около 20, а численность 
населения в сезон достигает более 25 тысяч человек. Дорога с наступлением 
сезона пришла в состояние "каши".
''';

class InitiativeRepository {
  final DioHttp _http;

  final _posts = [
    PostMessage(
      id: '1',
      title: 'Разбитые дороги на Каслинской в ужасном состоянии',
      body: _tmpBody,
      firstName: 'Иван',
      lastName: 'Иваненко',
      userId: '1',
      likes: 687,
      views: 394,
      createDate: DateTime.now().toString(),
      modifyDate: DateTime.now().toString(),
    ),
    PostMessage(
      id: '2',
      title: 'Разбитые дороги на Каслинской в ужасном состоянии',
      body: _tmpBody,
      firstName: 'Сергей',
      lastName: 'Пушной',
      userId: '2',
      likes: 187,
      views: 1394,
      createDate: DateTime.now().toString(),
      modifyDate: DateTime.now().toString(),
    ),
    PostMessage(
      id: '3',
      title: 'Разбитые дороги на Каслинской в ужасном состоянии',
      body: _tmpBody,
      firstName: 'Александр',
      lastName: 'Невский',
      userId: '3',
      likes: 187,
      views: 1394,
      createDate: DateTime.now().toString(),
      modifyDate: DateTime.now().toString(),
    ),
  ];

  InitiativeRepository(this._http);

  Future<List<PostMessage>> getPosts() async {
    return Future.value(_posts);
  }
}