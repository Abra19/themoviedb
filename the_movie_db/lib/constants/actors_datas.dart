class Actor {
  Actor({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
  });

  int id;
  final String name;
  final String image;
  final String description;
}

List<Actor> actorsData = <Actor>[
  Actor(
    id: 1,
    name: 'Ewan Gordon McGregor',
    description:
        'Scottish actor, producer, screenwriter and director. Winner of the Emmy Award (2021), Golden Globe Award (2018), two-time BAFTA Award winner (1997, 2004). The actor appears in both independent films and high-budget Hollywood projects. The most famous films with his participation are "Trainspotting" (1996), "Intimate Diary" (1996), "Moulin Rouge!" (2001), "Big Fish" (2003), "To hell with love!" (2003), "The Island" (2005), three episodes of the Star Wars film saga (1999, 2002, 2005), "I Love You Phillip Morris" (2009) and the film adaptation of Dan Browns novel "Angels and Demons" (2009). Currently one of the most sought-after actors in the UK. At the end of 2012, McGregor became a Commander of the Order of the British Empire for his contribution to the development of dramatic art and charitable work.',
    image: 'assets/images/actors/ewan_mcgregor.jpeg',
  ),
  Actor(
    id: 2,
    name: 'David John Bradley',
    description:
        'British stage, film and television actor. He is best known for his roles as Argus Filch in the Harry Potter film series, Walder Frey in the Game of Thrones television series, and Abraham Setrakian in the television series The Strain. Winner of BAFTA TV awards and Laurence Olivier Awards',
    image: 'assets/images/actors/david_bradley.jpeg',
  ),
  Actor(
    id: 3,
    name: 'Burn Hugh Winchester Gorman',
    description:
        'British actor and musician of American origin. He is best known for his roles as Dr. Owen Harper in the TV series Torchwood, Adam in the TV series Eternity and William Guppy in the mini-series Bleak House, and Karl Tanner in the TV series Game of Thrones. Parishioner of the Church of the Venerable Dementra.',
    image: 'assets/images/actors/burn_gorman.jpeg',
  ),
  Actor(
    id: 4,
    name: 'Ronald Francis Perlman',
    description:
        'American film, television and voice actor of Jewish descent, best known for his role as Hellboy in the film "Hellboy: The Hero". From the "Inferno" and "Hellboy 2: The Golden Army", the role of Clay Morrow in the series "Sons of Anarchy", the role of Reinhardt in the film "Blade 2", as well as voicing the narrator in the series of post-apocalyptic games Fallout.',
    image: 'assets/images/actors/ron_perlman.jpg',
  ),
  Actor(
    id: 5,
    name: 'August Diehl',
    description:
        'German actor, best known for his roles in the films "Inglourious Basterds" and "The Dark Knight".',
    image: 'assets/images/actors/august_diehl.jpeg',
  ),
  Actor(
    id: 6,
    name: 'Evgeny Eduardovich Tsyganov',
    description:
        'Russian theater, film and dubbing actor, theater and film director, screenwriter, composer. Laureate of the Government of the Russian Federation Prize (2015).',
    image: 'assets/images/actors/eugeniy_tsyganov.jpeg',
  ),
  Actor(
    id: 7,
    name: 'Yulia Viktorovna Snigir',
    description: 'Russian film actress , TV presenter and fashion model.',
    image: 'assets/images/actors/yulia_snigir.jpeg',
  ),
  Actor(
    id: 8,
    name: 'Claes Kasper Bang',
    description:
        'Danish theater, film and television actor, musician. Winner of the 2017 European Film Academy Award in the category "Best European Actor" for his role in the film "Square".',
    image: 'assets/images/actors/claes_bang.jpeg',
  ),
  Actor(
    id: 9,
    name: 'Yuri Andreevich Kolokolnikov',
    description:
        'Russian theater and film actor, film director and film producer.',
    image: 'assets/images/actors/yuri_kolokolnikov.jpg',
  ),
  Actor(
    id: 10,
    name: 'Taisho Sugo',
    description:
        'Taisho Sugo better known as Masaki Suda is a Japanese actor and singer. He is best known for his role as Philip in the Kamen Rider Double series (2009–2010), in the eponymous season of the Kamen Rider series. He also played leading roles in the series "Delete Life" (2018), "Class 3A, from now on you are hostage" (2019), "Oh, wildness" (2017), the "Gintama" duology (2017-2018), "Tapestry"(2020) and voiced Gray Heron in The Boy and the Bird (2023).',
    image: 'assets/images/actors/masaki_suda.jpeg',
  ),
  Actor(
    id: 11,
    name: 'Takura Kimura',
    description:
        'Japanese singer, musician and actor, radio host and former lead singer of the group SMAP.',
    image: 'assets/images/actors/takuya_kimura.png',
  ),
  Actor(
    id: 12,
    name: 'Ko Shibasaki',
    description: 'Japanese actress and singer.',
    image: 'assets/images/actors/shibasaki_ko.jpeg',
  ),
  Actor(
    id: 13,
    name: 'Joaquin Rafael Phoenix',
    description:
        'American actor. Younger brother of actor River Phoenix and brother of actress Summer Phoenix. Two-time winner of the Golden Globe Award, winner of the Cannes Film Festival and winner of the Volpi Cup of the Venice Film Festival, winner of the Grammy music award, winner of the Oscar and BAFTA awards and the American Screen Actors Guild award. In 2020, The New York Times declared Phoenix one of the greatest actors of the 21st century.',
    image: 'assets/images/actors/joaquin_phoenix.jpeg',
  ),
  Actor(
    id: 14,
    name: 'Robert Anthony De Niro',
    description:
        'American actor, producer, and director. He is best known for his work in crime films, thrillers and his collaborations with director Martin Scorsese. Winner of the Golden Globe (1981, 2011) and Oscar (1975, 1981) awards.',
    image: 'assets/images/actors/robert_de_niro.jpeg',
  ),
  Actor(
    id: 15,
    name: 'Zazie Olivia Beetz',
    description:
        'German-American actress. She is best known for her role as Vanessa "Van" Kiefer in the TV series Atlanta (2016 - present), which earned her a Primetime Emmy Award nomination. She also appeared in the Netflix anthology series As Easy As Easy (2016–2017).',
    image: 'assets/images/actors/zazie_beetz.jpg',
  ),
  Actor(
    id: 16,
    name: 'Frances Hardman Conroy',
    description:
        'American actress. Winner of the Golden Globe Award, and nominated for the Tony and Emmy Awards. She is best known for her role as Ruth Fisher in the television series Six Feet Under (2001–2005).Conroy is also known for her roles in the films "Lovers" (1984), "Scent of a Woman" (1992), "Sleepless in Seattle" (1993), "Catwoman" (2004), "The Aviator" (2004), "Broken Flowers" (2005), "Darkness Rising" (2007), "Love Happens" (2009), "Waking Madison" (2011) and "Joker" (2019), as well as the series "American Horror Story" (2011-2021).',
    image: 'assets/images/actors/frances_conroy.jpeg',
  ),
  Actor(
    id: 17,
    name: 'Brett Cullen',
    description:
        'American actor. He is best known for his role as Barton Blaze in the film Ghost Rider.',
    image: 'assets/images/actors/brett_cullen.jpeg',
  ),
  Actor(
    id: 18,
    name: 'William Camp',
    description:
        'American character actor. He became known for his supporting roles in many films, such as "Lincoln" (2012), "12 Years a Slave" (2013), "Love and Mercy" (2015), "Loving" (2016), "The Great Game" (2017), "Power" (2018), "Wildlife" (2018) and "Joker" (2019), as well as in the HBO miniseries One Night (2016) and The Outsider (2020) and miniseries Netflix "The Queens Move" (2020)',
    image: 'assets/images/actors/bill_camp.jpeg',
  ),
  Actor(
    id: 19,
    name: 'Franklin Shea Whigham',
    description:
        'American actor, best known for his role as Eli Thompson in the TV series Boardwalk Empire.',
    image: 'assets/images/actors/shea_whigham.jpeg',
  ),
  Actor(
    id: 20,
    name: 'Emily Jean "Emma" Stone',
    description:
        'American actress. Winner of numerous awards, including two Oscars, two Golden Globes and two BAFTAs. In 2017, she became the highest paid actress in the world with an annual income of \$26 million and was included in the list of 100 most influential people according to Time magazine .',
    image: 'assets/images/actors/emma_stone.jpg',
  ),
  Actor(
    id: 21,
    name: 'Dame Emma Thompson',
    description:
        'British actress and screenwriter. She gained fame after the release of the television series "Tutti Frutti" and "Fortune of War" in 1987. She became famous in the cinema after playing the main role in the film "Big Man". Winner of two Oscars, two Golden Globes and two BAFTA awards for the films Sense and Sensibility (for best screenplay) and Howards End (for best actress). On 9 June 2018 she was awarded the title of Dame Commander of the Order of the British Empire (DBE).',
    image: 'assets/images/actors/emma_thompson.jpeg',
  ),
  Actor(
    id: 22,
    name: 'Joel Fry',
    description:
        'English actor and musician.  Graduate of the Royal Academy of Dramatic Art. Joel Fry has appeared in a variety of UK television series, notably The White Van, Trolled and The Plebeians, and played Hizdahr zo Loraq in the cult series Game of Thrones.',
    image: 'assets/images/actors/joel_fry.jpeg',
  ),
  Actor(
    id: 23,
    name: 'Paul Walter Hauser',
    description:
        'American actor and comedian. Known for his roles as Sean Eckhardt in the film "Tonya Against the World" and Dale in the film "Whatever Happened to Virginia" and Keith in the television series "Kingdom". He also played the role of Dashawn in the Amazon web series "Betas", starred in Super Troopers 2, and as Ivanhoe in "Spike Lees BlacK Klansman", both 2018 films. He was involved as a guest star in the television series "Unbreakable Kimmy Schmidt", "Too Late with Adam Carolla", "Night Shift", "Supermarket", and others. In 2019, he was cast as Richard Jewell in Clint Eastwood\'s The Richard Jewell Case.',
    image: 'assets/images/actors/paul_hauser.jpeg',
  ),
  Actor(
    id: 24,
    name: 'Emily Beecham',
    description:
        'English actress. Born into the family of an English pilot and his American wife (from Arizona), she has dual citizenship. From 2003 to 2006 she studied at the London Academy of Musical and Dramatic Art. She is best known for her role as the Widow in the television series "Into the Desert of Death". In 2011, she received the award for "Best Actress" at the London Independent Film "Festival".',
    image: 'assets/images/actors/emily_beecham.jpeg',
  ),
  Actor(
    id: 25,
    name: 'Mark Strong',
    description:
        'British actor, nominated for a BAFTA TV Award (2004) and a Tony Award (2016). Known for the films "Sherlock Holmes", "Kick-Ass", "Body of Lies", " Rock \'n\' Rolla", "Stardust", "Robin Hood", "Tinker Tailor Soldier Spy!", "The Imitation Game", "Kingsman: The Secret Service", " Kingsman: The Golden Circle", "Shazam!"and others.',
    image: 'assets/images/actors/mark_strong.jpeg',
  ),
  Actor(
    id: 26,
    name: 'Timothée Hal Chalamet',
    description:
        "American and French actor. Winner of numerous awards, including an Oscar nomination, three BAFTAs, two Golden Globes, five Screen Actors Guild Awards and five Critics' Choice Awards.",
    image: 'assets/images/actors/timothee_chalamet.jpeg',
  ),
  Actor(
    id: 27,
    name: 'Rebecca Louisa Ferguson Sundström',
    description:
        'Swedish actress. She played the lead role of Anna Gripenhelm in the TV series "Modern Times and later" and played Chrissie in the Swedish-American TV series "Ocean Avenue".',
    image: 'assets/images/actors/rebecca_ferguson.jpeg',
  ),
  Actor(
    id: 28,
    name: 'Oscar Isaac Hernández Estrada',
    description:
        'American actor. In 2017, Vanity Fair magazine recognized Isaac as the best actor of his generation, and The New York Times in 2020 - one of the 25 greatest actors of the 21st century. Golden Globe winner and Emmy nominee. In 2016, he was included in the list of the hundred most influential people in the world according to Time magazine.',
    image: 'assets/images/actors/oscar_isaac.jpeg',
  ),
  Actor(
    id: 29,
    name: 'Josh James Brolin',
    description:
        'American actor. Nominated for an Oscar in the Best Supporting Actor category for his role as Dan White in "Milk".',
    image: 'assets/images/actors/josh_brolin.jpeg',
  ),
  Actor(
    id: 30,
    name: 'Stellan John Skarsgård',
    description:
        'Swedish actor. Prize-winner of the Berlin Film Festival and winner of the Golden Globe Award. He is known for his long-term collaboration with Danish director Lars von Trier, who directed Skarsgard in five of his films: "Breaking the Waves", "Dancer in the Dark", "Dogville", "Melancholia" and "Nymphomaniac". He is also well known to the general public for his roles in Hollywood films such as "Pirates of the Caribbean: Dead Man\'s Chest", "Thor", "The Avengers", "The Girl with the Dragon Tattoo", "Mamma Mia!", "Ghosts of Goya", "Dune".',
    image: 'assets/images/actors/stellan_skarsgard.jpeg',
  ),
  Actor(
    id: 31,
    name: 'David Michael Bautista Jr.',
    description:
        'American actor, former wrestler and bodybuilder who became famous for his performances in WWE under the name Batista from 2002 to 2010 year, in 2014 and last time in 2018-2019. Outside of wrestling, he is known for his acting career, best known as the character Drax the Destroyer in the Marvel Cinematic Universe.',
    image: 'assets/images/actors/dave_bautista.jpeg',
  ),
  Actor(
    id: 32,
    name: 'Zendaya Maree Stoermer Coleman',
    description:
        'American actress, singer, dancer and model. She is best known for her role as Michelle "MJ" Jones-Watson in "Spider-Man: Homecoming", "Spider-Man: Far From Home and Spider-Man: No Way Home".',
    image: 'assets/images/actors/zendaya.jpeg',
  ),
  Actor(
    id: 33,
    name: 'Tessa Charlotte Rampling',
    description:
        'British actress, Officer of the Order of the British Empire, winner of many international and national awards. Nominated for an Oscar.',
    image: 'assets/images/actors/charlotte_rampling.jpeg',
  ),
  Actor(
    id: 34,
    name: 'Javier Ángel Encinas Bardem',
    description:
        'Spanish actor and environmental activist. Winner of the Oscar for Best Supporting Actor in the film "No Country for Old Men". Winner of the Cannes Film Festival for Best Actor in the Mexican-Spanish film "Beautiful". Bardem\'s most famous paintings are "Living Flesh", "The Sea Within", "Goya\'s Ghosts", "Vicky Cristina Barcelona" and "007: Skyfall".',
    image: 'assets/images/actors/javier_bardem.jpeg',
  ),
  Actor(
    id: 35,
    name: 'Joseph Jason Namakaeha Momoa',
    description:
        'American actor, director, screenwriter and producer of Hawaiian descent. He became famous for his roles as warlike heroes in sci-fi action and fantasy films, such as "Conan the Barbarian"", "Game of Thrones", "Aquaman", "Stargate: Atlantis", "Fast and Furious 10", "Fast and Furious 11".',
    image: 'assets/images/actors/jason_momoa.jpeg',
  ),
  Actor(
    id: 36,
    name: 'Adam Douglas Driver',
    description:
        'American actor. Two-time Oscar and Golden Globe nominee, as well as an Emmy and Tony Award nominee.Driver is a veteran of the United States Marine Corps. He was also the founder of Arts in the Armed Forces, a non-profit organization that provided free arts programs to American military personnel, veterans, support personnel and their families around the world.',
    image: 'assets/images/actors/adam_driver.jpeg',
  ),
  Actor(
    id: 37,
    name: 'Penelope Cruz Sánchez',
    description:
        'Spanish actress and model. One of the most famous actresses in Spain and the first among them to achieve widespread success in her homeland and in Hollywood.',
    image: 'assets/images/actors/penelope_cruz.jpeg',
  ),
  Actor(
    id: 38,
    name: 'Shailene Diann Woodley',
    description:
        'American model and actress. She gained fame for her role as Amy Jurgens in the television series "The Secret Life of the American Teenager" (2008–2013), a role that earned Shailene five Teen Choice Awards nominations. Her next famous role was Alexandra King in the film "The Descendants" (2011), which allowed Shailene to receive an Independent Spirit Award and a Golden Globe Award nomination in 2012.',
    image: 'assets/images/actors/shailene_woodley.jpeg',
  ),
  Actor(
    id: 39,
    name: 'Sarah Lynn Gadon',
    description:
        'Canadian actress, known for David Cronenberg\'s "A Dangerous Method, Cosmopolis and Maps to the Stars", and Denis Villeneuve\'s "Enemy", as well as the role of Sadie Dunhill in the mini-series "11.22.63 ".',
    image: 'assets/images/actors/sarah_gadon.jpeg',
  ),
  Actor(
    id: 40,
    name: "Jack O'Connell",
    description:
        'British actor. For his roles in the films "Unbroken" (2014) and "From Bell to Bell" (2013), he was awarded the US National Board of Film Review Award in the Breakthrough of the Year category and the BAFTA Award in the Rising Star category.',
    image: 'assets/images/actors/jack_oconnell.jpeg',
  ),
  Actor(
    id: 41,
    name: 'Patrick Galen Dempsey',
    description:
        'American actor and race driver, best known for his role as Dr. Derek Shepard in the TV series "Grey\'s Anatomy". Emmy and Golden Globe nominee. Also known for the films "Stylish Thing", "Enchanted", "The Bridesmaid", "Bridget Jones 3", "Transformers 3: Dark of the Moon". Silver medalist of the 24 Hours of Le Mans race in the LMGTE Am class (2015).',
    image: 'assets/images/actors/patrick_dempsey.jpeg',
  ),
  Actor(
    id: 42,
    name: 'Willard Carroll "Will" Smith II',
    description:
        "American actor, director and hip-hop artist. Winner of Oscar, BAFTA, Screen Actors Guild and Golden Globe awards, as well as two Grammy awards. In 2008, Will Smith topped Forbes's list of Hollywood's highest-paid actors, earning \$80 million in a year. Smith became the first actor in Hollywood history to have eight films in a row gross more than \$100 million",
    image: 'assets/images/actors/will_smith.jpeg',
  ),
  Actor(
    id: 43,
    name: 'Jared Joseph Leto',
    description:
        'American actor and musician. Known for his dedication to method acting in his roles, he has received numerous awards during his thirty-year career, including an Academy Award, a Golden Globe Award, and a Screen Actors Guild Award. In addition, Leto received recognition for his musical work and eccentric stage persona as the vocalist of the alternative rock band "Thirty Seconds to Mars". For his role as a transgender woman in the drama "Dallas Buyers Club" he was awarded an Oscar, a Golden Globe, and a Screen Actors Guild award in the Best Supporting Actor category.',
    image: 'assets/images/actors/jared_leto.webp',
  ),
  Actor(
    id: 44,
    name: 'Margot Elise Robbie',
    description:
        'Australian actress and producer. Known for her roles in blockbusters and independent films. He has received numerous awards and nominations, including nominations for three Oscars, six British Academy Film Awards and four Golden Globes. In 2017, she was included in the list of 100 most influential people according to Time magazine. In 2019, she was recognized as one of the highest paid actresses in the world according to Forbes magazine.',
    image: 'assets/images/actors/margot_robbie.jpeg',
  ),
  Actor(
    id: 45,
    name: 'Charles Joel Nordström Kinnaman',
    description:
        'Swedish and American actor. Winner of the Golden Bug Award in the category "Best Actor" for the film "Easy Money". Also known for the films "RoboCop", "Suicide Squad", "The Girl with the Dragon Tattoo" and the television series "The Killing" and "Altered Carbon".',
    image: 'assets/images/actors/joel_kinnaman.jpeg',
  ),
  Actor(
    id: 46,
    name: 'Viola Davis',
    description:
        'American actress and producer. One of 19 artists awarded the title "EGOT" (Oscar, Emmy, Grammy and Tony awards).',
    image: 'assets/images/actors/viola_davis.jpeg',
  ),
  Actor(
    id: 47,
    name: 'Jai Stephen Courtney',
    description:
        'Australian actor, known for his role as Varro in the TV series "Spartacus: Blood and Sand" and roles in the films "Divergent and Jack Reacher", "Die Hard: A Good Day to Die", "Terminator Genisys" and "Suicide Squad".',
    image: 'assets/images/actors/jai_courtney.jpeg',
  ),
  Actor(
    id: 48,
    name: 'Jay Hernandez',
    description: 'American actor.',
    image: 'assets/images/actors/jay_hernandez.jpeg',
  ),
  Actor(
    id: 49,
    name: 'Adewale Akinnuoye-Agbaje',
    description:
        'British actor. Known for the films "The Mummy Returns" and "The Bourne Identity", as well as for the television series "Lost" and "Oz Prison".',
    image: 'assets/images/actors/adewale_agbaje.png',
  ),
  Actor(
    id: 50,
    name: 'Ike Barinholtz',
    description:
        'American actor, screenwriter, and comedian. He became famous for his role as Morgan Tookers in the comedy television series "The Mindy Project".',
    image: 'assets/images/actors/ike_barinholtz.jpeg',
  ),
  Actor(
    id: 51,
    name: 'Scott Eastwood',
    description: 'American actor and model.',
    image: 'assets/images/actors/scott_eastwood.jpeg',
  ),
  Actor(
    id: 52,
    name: 'Cara Jocelyn Delevingne',
    description:
        'British supermodel and actress. One of the "stylish people in the fashion industry under the age of 45" according to the American version of Vogue magazine. In the ranking of "50 Supermodels of the World" by the professional portal Models.com, the model takes 5th place, and in the British Evening Standard ranking of "1000 most influential people of 2011" she is in the "most invited" category. Kara also wrote her first book, "Mirror, Mirror" which was published on October 5, 2017.',
    image: 'assets/images/actors/cara_delevingne.jpeg',
  ),
  Actor(
    id: 53,
    name: 'Mosiah Bikila Gilligan',
    description:
        'British stand-up comedian, television presenter and content creator. He is known for his observational comedy. After several years of uploading comedy clips to social media, he found global success in 2017. He hosted "The Lateish Show with Mo Gilligan" on Channel 4. He currently co-hosts "The Big Narstie Show" on Channel 4, and is a judge on "The Masked Singer UK" since the second series in 2020, and a judge on "The Masked Dancer UK" since 2021.',
    image: 'assets/images/actors/mo_gilligan.jpeg',
  ),
  Actor(
    id: 54,
    name: 'Simone Ashley',
    description:
        'British actress. She is known for her role in the Netflix period drama "Bridgertons" and "Sex Education".',
    image: 'assets/images/actors/simone_ashley.jpeg',
  ),
  Actor(
    id: 55,
    name: 'Sophie Okonedo',
    description:
        'British actress, Oscar  nominee (2005), Tony winner in 2014. Commander of the Order of the British Empire (CBE, 2018).',
    image: 'assets/images/actors/sophie_okonedo.jpeg',
  ),
  Actor(
    id: 56,
    name: 'Zain Javadd Malik',
    description:
        'British singer. Malik has received several awards, including an American Music Award and an MTV Video Music Award. He is the only artist to have won the Billboard Music Award for New Artist of the Year twice, winning once as a member of One Direction in 2013 and again in 2017 as a soloist.',
    image: 'assets/images/actors/zane_malik.jpeg',
  ),
  Actor(
    id: 57,
    name: 'William Francis Nighy',
    description:
        'English actor, winner of the Golden Globe and BAFTA awards. He is best known for his roles in the films: "Rock Wave", "Love Actually", "Underworld", "Pirates of the Caribbean", "Shaun of the Dead", "Harry Potter and the Deathly Hallows: Part 1 ".',
    image: 'assets/images/actors/bill_nighy.jpeg',
  ),
  Actor(
    id: 58,
    name: 'Keegan-Michael Key',
    description:
        'American actor, comedian, screenwriter and producer. He is known for his appearances on the Comedy Central sketch show "Key & Peele", the USA Network comedy series "House of Games", and as a contestant on Mad TV. He also starred in the first season of the FX series "Fargo" and had a recurring role in the sixth and seventh seasons of "Parks and Recreation". Kay hosted the American version of Animal Planet\'s Funniest Animals from 2005 until the program\'s demise in 2008.',
    image: 'assets/images/actors/keegan_key.jpeg',
  ),
  Actor(
    id: 59,
    name: 'Sally Cecilia Hawkins',
    description:
        'British actress. Her performance as Poppy in the 2008 film "Carefree" earned her several international awards, including the Golden Globe for Best Actress – Comedy or Musical. Also known for her roles as Mrs. Mary Brown in "The Adventures of Paddington" and "The Adventures of Paddington 2", Susan in the film "Vera Drake" (2004), Sue Trinder in the BBC series "Fingers of Velvet" (2005), Anne in the film "Persuasion" (2007) and Eliza Esposito in "The Shape of Water"(2017).',
    image: 'assets/images/actors/sally_hawkins.jpeg',
  ),
  Actor(
    id: 60,
    name: 'Rowan Sebastian Atkinson',
    description:
        'British stage, film, television and voice-  over actor, screenwriter, producer and writer. He is best known in the world for his comic role as Mr. Bean in the television series of the same name. Winner of two BAFTA awards (1981, 1990), the second of which was received for his role in the sitcom "Blackadder".',
    image: 'assets/images/actors/rowan_atkinson.jpeg',
  ),
  Actor(
    id: 61,
    name: 'Sarah Caroline Sinclair',
    description:
        'English actress. Winner of Oscar and Emmy awards, four BAFTA awards, three Golden Globe awards and the Volpi Cup of the Venice International Festival.',
    image: 'assets/images/actors/olivia_colman.jpeg',
  ),
  Actor(
    id: 62,
    name: 'James Edward "Jim" Carter',
    description:
        'English actor  best known for his role as the butler Mr. Carson in "Downton Abbey" (twice nominated for Best Supporting Actor in a Drama Series on Prime-Time Emmy Award in 2012 and 2013). Member of the popular Boston comedy troupe Madhouse Company Of London in the 1970s. He starred in such films as "The Madness of King George" (1994), "Richard III" (1995), "Shakespeare in Love"(1998) and "Ella Enchanted" (2004).',
    image: 'assets/images/actors/jim_carter.jpeg',
  ),
];
