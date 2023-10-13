import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_station/application/bloc/audio_player/audio_player_bloc.dart';
import 'package:radio_station/application/bloc/custom_bottom_navigation/custom_bottom_navigation_bloc.dart';
import 'package:radio_station/application/bloc/search_screen/search_screen_bloc.dart';
import 'package:radio_station/ui/screens/radio_station_screen/radio_station_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController textController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  final SearchScreenBloc bloc = GetIt.instance.get<SearchScreenBloc>();
  final CustomBottomNavigationBloc _customBottomNavigationBloc =
      GetIt.instance.get<CustomBottomNavigationBloc>();
  final AudioPlayerBloc _audioPlayerBloc =
      GetIt.instance.get<AudioPlayerBloc>();

  @override
  void dispose() {
    scrollController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (text) =>
                    bloc.add(SearchRadioStation(radioStationName: text)),
                controller: textController,
                decoration: InputDecoration(
                  labelText: "Enter a search term",
                  labelStyle: const TextStyle(color: Colors.white),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xFFF5897F), width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
          ),
          BlocBuilder<SearchScreenBloc, SearchScreenState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is SearchCompleted && state.radioStations.isNotEmpty) {
                return Column(
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.75,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      children: List.generate(
                        state.radioStations.length,
                        (index) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  _audioPlayerBloc.add(const StopAudioPlayer());
                                  _customBottomNavigationBloc.add(
                                    LoadPageScreen(
                                      pageScreen: PageScreen.home,
                                      child: RadioStationScreen(
                                        radioStation:
                                            state.radioStations[index]!,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          state.radioStations[index]!.image,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      state.radioStations[index]!.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else if (state is SearchCompleted &&
                  state.radioStations.isEmpty) {
                return const Text(
                  'No Results Found :( ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                );
              }
              return const Text(
                'Searching',
                style: TextStyle(
                  color: Colors.white,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
