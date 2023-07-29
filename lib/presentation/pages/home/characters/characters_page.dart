import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/domain/models/characters.dart';
import 'package:rickmorty/presentation/pages/home/characters/detail_characters_page.dart';
import '../../../../constants/constants.dart';
import '../../../blocs/character/character_bloc.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late CharacterBloc characterBloc;
  String? _selectedRadioListTile;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    characterBloc = BlocProvider.of<CharacterBloc>(context);
    characterBloc.getListCharacters();
  }

  @override
  void dispose() {
    characterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                margin: EdgeInsets.only(top: 15),
                alignment: Alignment.topCenter,
                child: Wrap(
                  direction: Axis.vertical,
                  children: [searchTextFiel(context)],
                ),
              ),
            )),
        body: SingleChildScrollView(
            child: Column(
          children: [
            _filter(),
            _charactersList(context),
          ],
        )));
  }

  Widget searchTextFiel(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.79,
        child: TextField(
          onChanged: (value) => {
            if (value.isNotEmpty)
              {
                setState(() {
                  context
                      .read<CharacterBloc>()
                      .add(SearchCharacterEvent(value));
                }),
              }
          },
          decoration: InputDecoration(
              hintText: 'Buscar personaje...',
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintStyle: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.grey)),
              contentPadding: const EdgeInsets.all(15)),
        ),
      ),
    );
  }

  Widget _filter() {
    return Container(
      margin: EdgeInsets.only(left: 28, right: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExpansionTile(
            title: const Text(
              'Filtrar personajes',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold),
            ),
            onExpansionChanged: (value) {
              setState(() {
                _isExpanded = value;
              });
            },
            children: [
              RadioListTile<String>(
                title: Text('Personajes mayor a menor'),
                value: '1',
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    characterBloc.add(FilterCharacterEvent(value.toString()));
                    _selectedRadioListTile = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Personajes de menor mayor'),
                value: '2',
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    characterBloc.add(FilterCharacterEvent(value.toString()));
                    _selectedRadioListTile = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Femenino'),
                value: '3',
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    characterBloc.add(FilterCharacterEvent(value.toString()));

                    _selectedRadioListTile = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Masculino'),
                value: '4',
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    characterBloc.add(FilterCharacterEvent(value.toString()));
                    _selectedRadioListTile = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _charactersList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.70,
        child: StreamBuilder<List<Character>>(
          stream: characterBloc.characterController,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final pro = snapshot.data!;
              if (pro.length > 0) {
                return ListView.builder(
                  itemCount: pro.length,
                  itemBuilder: (context, index) {
                    final charac = pro[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(charac.image),
                          ),
                          title: Text(charac.name),
                          subtitle: Text(
                            '${charac.status} - ${charac.species}',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                          trailing: Icon(
                            charac.status == AppConstants.Alive
                                ? Icons.favorite
                                : charac.status == AppConstants.Dead
                                    ? Icons.cancel
                                    : Icons.help,
                            color: charac.status == AppConstants.Alive
                                ? Colors.green
                                : charac.status == AppConstants.Dead
                                    ? Colors.red
                                    : Colors.grey,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailCharactersPage(
                                        characterModel: charac)));
                          },
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 90),
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage('assets/cero-items.png'),
                        width: 140,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "No se encontró ningún personaje",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ));
              }
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar los posts'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
