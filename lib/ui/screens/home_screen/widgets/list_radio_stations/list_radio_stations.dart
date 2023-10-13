part of '../../home_screen.dart';

class ListRadioStations extends StatefulWidget {
  final String title;
  final List<RadioStation> radioStations;

  const ListRadioStations({
    super.key,
    required this.title,
    required this.radioStations,
  });

  @override
  State<ListRadioStations> createState() => _ListRadioStationsState();
}

class _ListRadioStationsState extends State<ListRadioStations> {
  final ScrollController scrollController = ScrollController();
  final CustomBottomNavigationBloc _customBottomNavigationBloc =
      GetIt.instance.get<CustomBottomNavigationBloc>();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.radioStations.length,
              itemBuilder: (_, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  child: InkWell(
                    onTap: () => _customBottomNavigationBloc.add(
                      LoadPageScreen(
                        pageScreen: PageScreen.home,
                        child: RadioStationScreen(
                          radioStation: widget.radioStations[index],
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              widget.radioStations[index].image,
                              height: 120,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.radioStations[index].name.length > 15
                              ? '${widget.radioStations[index].name.substring(0, 15)}...'
                              : widget.radioStations[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
