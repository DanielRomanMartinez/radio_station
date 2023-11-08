import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:radio_station/application/bloc/audio_player/audio_player_bloc.dart';
import 'package:radio_station/application/bloc/custom_bottom_navigation/custom_bottom_navigation_bloc.dart';
import 'package:radio_station/application/bloc/favorite_screen/favorite_screen_bloc.dart';
import 'package:radio_station/ui/screens/radio_station_screen/radio_station_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final CustomBottomNavigationBloc _customBottomNavigationBloc =
      GetIt.instance.get<CustomBottomNavigationBloc>();

  final FavoriteScreenBloc _favoriteScreenBloc =
      GetIt.instance.get<FavoriteScreenBloc>();
  final AudioPlayerBloc _audioPlayerBloc =
      GetIt.instance.get<AudioPlayerBloc>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: BlocBuilder<FavoriteScreenBloc, FavoriteScreenState>(
          bloc: _favoriteScreenBloc,
          builder: (context, state) {
            if (state is FavoriteScreenLoaded) {
              if (state.radioStations.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 100,
                  child: const Center(
                    child: Text(
                      "You didn't add radio stations to favorites yet.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                );
              }
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
                                      radioStation: state.radioStations[index],
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
                                        state.radioStations[index].image,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    state.radioStations[index].name,
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
                  BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
                    bloc: _audioPlayerBloc,
                    builder: (context, audioPlayerState) {
                      if (audioPlayerState is AudioPlayerLoaded &&
                          (audioPlayerState is AudioPlaying ||
                              state is AudioPaused)) {
                        return const SizedBox(height: 80);
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              );
            } else if (state is FavoriteScreenStateInitial) {
              _favoriteScreenBloc.add(const LoadFavoriteScreen());
            }
            return const Center(
              child: Text('Loading...'),
            );
          },
        ),
      ),
    );
  }
}
