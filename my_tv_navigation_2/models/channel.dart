class Channel {
  final String id;
  final String name;
  final String logoUrl;
  final String category;
  final bool isHD;
  final String? currentShow;
  final bool isLive;

  const Channel({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.category,
    this.isHD = true,
    this.currentShow,
    this.isLive = false,
  });

  // Sample data for testing
  static List<Channel> getSampleChannels() {
    return [
      Channel(
        id: '1',
        name: 'Sports HD',
        logoUrl: 'https://via.placeholder.com/150?text=Sports+HD',
        category: 'Sports',
        currentShow: 'Live: Premier League',
        isLive: true,
      ),
      Channel(
        id: '2',
        name: 'Movies Now',
        logoUrl: 'https://via.placeholder.com/150?text=Movies+Now',
        category: 'Movies',
        currentShow: 'The Dark Knight',
      ),
      Channel(
        id: '3',
        name: 'Discovery HD',
        logoUrl: 'https://via.placeholder.com/150?text=Discovery',
        category: 'Documentary',
        currentShow: 'Planet Earth II',
      ),
      Channel(
        id: '4',
        name: 'Kids Zone',
        logoUrl: 'https://via.placeholder.com/150?text=Kids+Zone',
        category: 'Kids',
        currentShow: 'SpongeBob SquarePants',
      ),
      Channel(
        id: '5',
        name: 'News 24/7',
        logoUrl: 'https://via.placeholder.com/150?text=News+24/7',
        category: 'News',
        currentShow: 'Breaking News',
        isLive: true,
      ),
      Channel(
        id: '6',
        name: 'Music Hits',
        logoUrl: 'https://via.placeholder.com/150?text=Music+Hits',
        category: 'Music',
        currentShow: 'Top 40 Countdown',
      ),
      // Add more channels for each category
      Channel(
        id: '7',
        name: 'ESPN HD',
        logoUrl: 'https://via.placeholder.com/150?text=ESPN+HD',
        category: 'Sports',
        currentShow: 'NBA Live',
        isLive: true,
      ),
      Channel(
        id: '8',
        name: 'HBO HD',
        logoUrl: 'https://via.placeholder.com/150?text=HBO+HD',
        category: 'Movies',
        currentShow: 'Game of Thrones',
      ),
      Channel(
        id: '9',
        name: 'Nat Geo Wild',
        logoUrl: 'https://via.placeholder.com/150?text=Nat+Geo+Wild',
        category: 'Documentary',
        currentShow: 'Wild Africa',
      ),
      Channel(
        id: '10',
        name: 'Cartoon Network',
        logoUrl: 'https://via.placeholder.com/150?text=Cartoon+Network',
        category: 'Kids',
        currentShow: 'Adventure Time',
      ),
    ];
  }

  static List<Channel> getByCategory(String category) {
    return getSampleChannels()
        .where((channel) => channel.category == category)
        .toList();
  }

  static List<String> getCategories() {
    return getSampleChannels()
        .map((channel) => channel.category)
        .toSet()
        .toList();
  }
}
