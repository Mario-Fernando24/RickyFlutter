import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickmorty/domain/models/location.dart';
import 'package:rickmorty/presentation/blocs/location/location_bloc.dart';
import 'package:rickmorty/presentation/pages/home/location/detail_location.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late LocationBloc locationBloc;
  String ? _selectedRadioListTile;

  @override
  void initState() {
    super.initState();
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.getListLocation();
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
            _locationsList(context),
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
                   context.read<LocationBloc>().add(SearchLocationEvent(value));
                 }),
              }
          },
          decoration: InputDecoration(
              hintText: 'Buscar ubicaciones ...',
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
              'Filtrar ubicación',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold),
            ),
            children: [
              RadioListTile<String>(
                title: Text('Ubicación mayor a menor'),
                value: '1',
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    locationBloc.add(FilterLocationEvent(value.toString()));
                    _selectedRadioListTile = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: Text('Ubicación de menor mayor'),
                value: '2',
                groupValue: _selectedRadioListTile,
                onChanged: (value) {
                  setState(() {
                    locationBloc.add(FilterLocationEvent(value.toString()));
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

  Widget _locationsList(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.70,
        child: StreamBuilder<List<Location>>(
          stream: locationBloc.locationController,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final pro = snapshot.data!;
              if (pro.length > 0) {
                return ListView.builder(
                  itemCount: pro.length,
                  itemBuilder: (context, index) {
                    final locationss = pro[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text(locationss.name ?? ""),
                          subtitle: Text(
                              "Dimension: ${locationss.dimension}\nTipo: ${locationss.type}"),
                               onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailLocationPage(
                                        location: locationss)));
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
