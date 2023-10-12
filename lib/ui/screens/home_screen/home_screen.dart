import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_station/application/bloc/audio_player/audio_player_bloc.dart';
import 'package:radio_station/application/bloc/home_screen/home_screen_bloc.dart';
import 'package:radio_station/domain/model/objects/radio_station.dart';
import 'package:radio_station/ui/common/widgets/loading_btn/loading_btn.dart';
import 'package:radio_station/ui/common/widgets/play_pause_btn/play_pause_btn.dart';
import 'package:radio_station/ui/common/widgets/stop_btn/stop_btn.dart';
import 'package:radio_station/ui/screens/radio_station_screen/radio_station_screen.dart';

part 'widgets/list_radio_stations/list_radio_stations.dart';
part 'widgets/mini_audio_player/mini_audio_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final HomeScreenBloc _homeScreenBloc = GetIt.instance.get<HomeScreenBloc>();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/splash_screen/radio_station_logo.png',
          width: 150,
        ),
        title: const Text('Radio Station'),
      ),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          BlocBuilder<HomeScreenBloc, HomeScreenState>(
            bloc: _homeScreenBloc,
            builder: (context, state) {
              if (state is HomeLoaded) {
                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                        childAspectRatio: state.radioStations.length / 2.5,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        children: List.generate(
                          state.radioStations.length,
                          (index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blueGrey,
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(5),
                                      topLeft: Radius.circular(5),
                                    ),
                                    child: Image.network(
                                      state.radioStations[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      state.radioStations[index].name.length >
                                              15
                                          ? '${state.radioStations[index].name.substring(0, 15)}...'
                                          : state.radioStations[index].name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.radioStationsByCountry.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, int i) {
                          return ListRadioStations(
                            title:
                                '${state.radioStationsByCountry[i]['country_name']}',
                            radioStations: state.radioStationsByCountry[i]
                                ['radio_stations'],
                          );
                        },
                      ),
                    ],
                  ),
                );
              }

              _homeScreenBloc.add(const LoadHome());

              return const Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.white,
                ),
              );
            },
          ),
          MiniAudioPlayer(),
        ],
      ),
    );
  }
}
