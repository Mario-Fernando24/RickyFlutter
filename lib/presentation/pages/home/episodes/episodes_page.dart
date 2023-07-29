import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/domain/models/episodes.dart';
import 'package:rickmorty/presentation/blocs/episode/episode_bloc.dart';
import 'package:rickmorty/presentation/pages/home/episodes/detail_episode.dart';

class EpisodesPage extends StatefulWidget {
  const EpisodesPage({super.key});

  @override
  State<EpisodesPage> createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  late EpisodeBloc episodeBloc;
  String? _selectedRadioListTile;

  @override
  void initState() {
    super.initState();
    episodeBloc = BlocProvider.of<EpisodeBloc>(context);
    episodeBloc.getListEpisode();
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
            _episodeList(context),
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
                  context.read<EpisodeBloc>().add(SearchEpisodesEvent(value));
                }),
              }
          },
          decoration: InputDecoration(
              hintText: 'Buscar Episodios...',
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
              'Filtrar Episodios',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold),
            ),
            children: [
              RadioListTile<String>(
                title: Text('Episodios mayor a menor'),
                value: '1',
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    episodeBloc.add(FilterEpisodesEvent(value.toString()));
                    _selectedRadioListTile = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Episodios de menor mayor'),
                value: '2',
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    episodeBloc.add(FilterEpisodesEvent(value.toString()));
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

  Widget _episodeList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.70,
        child: StreamBuilder<List<Episodes>>(
          stream: episodeBloc.episodeController,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final pro = snapshot.data!;
              if (pro.length > 0) {
                return ListView.builder(
                  itemCount: pro.length,
                  itemBuilder: (context, index) {
                    final episode = pro[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(episode.name),
                          subtitle: Row(
                            children: [
                              const Text(
                                'Fecha emisión: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(episode.air_date ?? "")
                            ],
                          ),
                           onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailEpisodePage(
                                        episodeModel: episode)));
                          },
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                    child: Container(
                  margin: const EdgeInsets.only(top: 90),
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage('assets/cero-items.png'),
                        width: 140,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "No se encontró ningún episodio",
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
