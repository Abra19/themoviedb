class Movie {
  Movie({
    required this.id,
    required this.image,
    required this.bigImage,
    required this.title,
    required this.data,
    required this.fullData,
    required this.description,
    required this.genre,
    required this.duration,
    required this.country,
    required this.director,
    required this.novel,
    required this.actorOne,
    required this.actorTwo,
    required this.casts,
  });

  final int id;
  final String image;
  final String bigImage;
  final String title;
  final String data;
  final String fullData;
  final String description;
  final String genre;
  final String duration;
  final String country;
  final String director;
  final String novel;
  final String actorOne;
  final String actorTwo;
  final List<int> casts;
}

class AppMoviesDatas {
  static List<Movie> movies = <Movie>[
    Movie(
      id: 1,
      image: 'assets/images/movies/pinokkio.jpeg',
      bigImage: 'assets/images/movies/big_pinokkio.jpeg',
      title: 'Pinocchio',
      data: '2022',
      fullData: '10/15/2022',
      description:
          'American stop-motion animated musical drama film in the dark fantasy genre directed by Guillermo del Toro and Mark Gustafson, based on a script by del Toro and Patrick McHale and based on the story by del Toro and Matthew Robbinson based on the tale of the Italian author Carlo Collodi "The Adventures of Pinocchio" and inspired by the illustrations of Gris Grimley for the 2002 edition',
      genre: 'Musical, Dark fantasy, Drama',
      duration: '1h 57m',
      country: 'USA',
      director: 'Guillermo del Toro',
      novel: 'Matthew Robbins',
      actorOne: 'Ewan McGregor',
      actorTwo: 'David Bradley',
      casts: <int>[1, 2, 3, 4],
    ),
    Movie(
      id: 2,
      image: 'assets/images/movies/master.jpeg',
      bigImage: 'assets/images/movies/big_master.jpeg',
      title: 'The Master and Margarita',
      data: '2024',
      fullData: '01/25/2024',
      description:
          'Russian fantasy drama film directed by Mikhail Lokshin based on the novel of the same name by Mikhail Bulgakov',
      genre: 'Fantasy, Drama, Dieselpunk',
      duration: '2h 37m',
      country: 'Russia',
      director: 'Mikhail Lokshin',
      novel: 'Roman Kantor',
      actorOne: 'August Diehl',
      actorTwo: 'Evgeniy Tsyganov',
      casts: <int>[5, 6, 7, 8, 9],
    ),
    Movie(
      id: 3,
      image: 'assets/images/movies/boy_and_bird.jpeg',
      bigImage: 'assets/images/movies/big_boy_and_bird.jpeg',
      title: 'The Boy and the Bird',
      data: '2023',
      fullData: '07/14/2023',
      description:
          'Full-length anime film directed by Hayao Miyazaki. The original title is taken from Yoshino Genzaburos 1937 book of the same name, but the plot of the film is in no way related to the novel',
      genre: 'Fantasy, Drama, Adventure',
      duration: '2h 4m',
      country: 'Japan',
      director: 'Hayao Miyazaki',
      novel: 'Hayao Miyazaki',
      actorOne: 'Taisho Sugo',
      actorTwo: 'Takuya Kimura',
      casts: <int>[10, 11, 12],
    ),
    Movie(
      id: 4,
      image: 'assets/images/movies/cruella.jpeg',
      bigImage: 'assets/images/movies/big_cruella.jpeg',
      title: 'Cruella',
      data: '2021',
      fullData: '05/18/2021',
      description:
          'American crime-comedy film directed by Craig Gillespie and written by Dana Fox and Tony McNamara, dedicated to the character Cruella De Vil from Dodie Smiths novel 101 Dalmatians',
      genre: 'Crime comedy',
      duration: '2h 14min',
      country: 'USA',
      director: 'Craig Gillespie',
      novel: 'Dana Fox',
      actorOne: 'Emma Stone',
      actorTwo: 'Emma Thompson',
      casts: <int>[20, 21, 22, 23, 24, 25],
    ),
    Movie(
      id: 5,
      image: 'assets/images/movies/djoker.jpeg',
      bigImage: 'assets/images/movies/big_djoker.jpeg',
      title: 'Joker',
      data: '2019',
      fullData: '08/31/2019',
      description:
          'American psychological thriller directed by Todd Phillips from a script written by Phillips together with Scott Silver. The main role is played by Joaquin Phoenix. The plot of the film is a version of the backstory of the supervillain Joker, one of the key antagonists of Batman in the comics of DC Comics',
      genre: 'Psychological thriller, Drama',
      duration: '2h 2m',
      country: 'USA',
      director: 'Todd Phillips',
      novel: 'Scott Silver',
      actorOne: 'Joaquin Phoenix',
      actorTwo: 'Robert De Niro',
      casts: <int>[13, 14, 15, 16, 17, 18, 19],
    ),
    Movie(
      id: 6,
      image: 'assets/images/movies/duna.jpeg',
      bigImage: 'assets/images/movies/big_duna.jpeg',
      title: 'Dune',
      data: '2021',
      fullData: '09/03/2021',
      description:
          'American epic fantasy film directed by Denis Villeneuve, for which he himself wrote the script together with John Spates and Eric Roth. This is the first film in a new series of film adaptations of Frank Herberts 1965 novel of the same name, part of a large media franchise.',
      genre: 'Epic fantasy',
      duration: '2h 35m',
      country: 'USA',
      director: 'Denis Villeneuve',
      novel: 'John Spates',
      actorOne: 'Timothee Chalamet',
      actorTwo: 'Rebecca Ferguson',
      casts: <int>[26, 27, 28, 29, 30, 31, 32, 33, 34, 35],
    ),
    Movie(
      id: 7,
      image: 'assets/images/movies/ferrari.jpeg',
      bigImage: 'assets/images/movies/big_ferrari.jpeg',
      title: 'Ferrari',
      data: '2023',
      fullData: '08/31/2023',
      description:
          'American biographical sports drama directed by Michael Mann and written by Troy Kennedy Martin. The film is based on the 1991 biography Enzo Ferrari: The Man, the Machines, the Race by sports journalist Brock Yates, and follows the personal life and professional career of Enzo Ferrari during the summer of 1957.',
      genre: 'Drama, Biographical film',
      duration: '2h 10m',
      country: 'USA',
      director: 'Michael Mann',
      novel: 'Troy Kennedy Martin',
      actorOne: 'Adam Driver',
      actorTwo: 'Penelope Cruz',
      casts: <int>[36, 37, 38, 39, 40, 41],
    ),
    Movie(
      id: 8,
      image: 'assets/images/movies/otryad.jpeg',
      bigImage: 'assets/images/movies/big_otryad.jpeg',
      title: 'Suicide Squad',
      data: '2016',
      fullData: '08/01/2016',
      description:
          'American superhero film directed by David Ayer, based on the comic book of the same name by DC Comics and the third film in the DC Extended Universe after Batman v Superman: Dawn of Justice.',
      genre: 'Superheroics, Action movie, Comedy, Techno-fantasy, Adventures',
      duration: '2h 14m',
      country: 'USA',
      director: 'David Ayer',
      novel: 'David Ayer',
      actorOne: 'Will Smith',
      actorTwo: 'Jared Leto',
      casts: <int>[42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52],
    ),
    Movie(
      id: 9,
      image: 'assets/images/movies/ten_lifes.jpeg',
      bigImage: 'assets/images/movies/big_ten_lifes.jpeg',
      title: '10 Lives',
      data: '2024',
      fullData: '01/20/2024',
      description:
          'Researcher Rose, going through a personal and professional crisis, accidentally finds a cute gray kitten with different eyes: one blue, the other yellow-green. She was not ready for such a turn: work for her seems to be more important for now than family, but the cat is charm itself. Although, apparently, Beckett—Rose, who studies bees, named it after the Old English word for "hive"—is only that way in appearance. Cats, which are known to have nine lives, are quite cunning creatures.',
      genre: 'Cartoon, Fantasy, Comedy, Family',
      duration: '1h 28m',
      country: 'UK, Canada',
      director: 'Chris Jenkins',
      novel: 'Ash Brannon',
      actorOne: 'Mosiah Bikila Gilligan',
      actorTwo: 'Simone Ashley',
      casts: <int>[53, 54, 55, 56, 57],
    ),
    Movie(
      id: 10,
      image: 'assets/images/movies/vonka.jpeg',
      bigImage: 'assets/images/movies/big_vonka.jpeg',
      title: 'Wonka',
      data: '2023',
      fullData: '12/15/2023',
      description:
          'Musical fantasy film directed by Paul King from a script he co-wrote with Simon Farnaby.  The film is a prequel to Willy Wonka and the Chocolate Factory, the first film adaptation of Roald Dahls fairy tale novel Charlie and the Chocolate Factory',
      genre: 'Musical, Fantasy, Comedy',
      duration: '1h 56m',
      country: 'USA, UK',
      director: 'Paul King',
      novel: 'Simon Farnaby',
      actorOne: 'Timothée Chalamet',
      actorTwo: 'Keegan-Michael Kay',
      casts: <int>[26, 58, 59, 60, 61, 62],
    ),
  ];

  static const String profile = 'assets/images/profile.png';
}
