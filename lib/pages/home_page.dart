import 'package:flutter/material.dart';
import '../widgets/tv_focusable.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 300,
            color: Colors.grey.shade900,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TVFocusable(
                      focusKey: "slider_left",
                      leftFocusKey: "home",
                      rightFocusKey: "slider_right",
                      downFocusKey: "play",
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_arrow_left),
                      ),
                    ),
                    TVFocusable(
                      focusKey: "slider_right",
                      leftFocusKey: "slider_left",
                      downFocusKey: "my_list",
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TVFocusable(
                      focusKey: "play",
                      leftFocusKey: "home",
                      rightFocusKey: "my_list",
                      upFocusKey: "slider_left",
                      downFocusKey: "popular_movies",
                      child: Text("Play"),
                    ),
                    SizedBox(width: 30),
                    TVFocusable(
                      focusKey: "my_list",
                      leftFocusKey: "play",
                      upFocusKey: "slider_right",
                      downFocusKey: "popular_movies",
                      child: Text("My List"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const TVFocusable(
            focusKey: "popular_movies",
            leftFocusKey: "home",
            downFocusKey: "group:popular_movies_list",
            upFocusKey: "play",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular Movies"),
                Text("View All"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.separated(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return TVFocusable(
                  focusKey: "popular_movies_list_$index",
                  leftFocusKey:
                      index > 0 ? "popular_movies_list_${index - 1}" : "home",
                  rightFocusKey: "popular_movies_list_${index + 1}",
                  downFocusKey: "popular_tv_shows",
                  upFocusKey: "popular_movies",
                  focusGroup: "popular_movies_list",
                  child: Container(
                    width: 150,
                    height: 200,
                    color: Colors.grey.shade900,
                    alignment: Alignment.center,
                    child: Text("Movie ${index + 1}"),
                  ),
                );
              },
            ),
          ),
          const TVFocusable(
            focusKey: "popular_tv_shows",
            leftFocusKey: "popular_movies",
            downFocusKey: "group:popular_tv_shows_list",
            upFocusKey: "group:popular_movies_list",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular TV Shows"),
                Text("View All"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.separated(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return TVFocusable(
                  focusKey: "popular_tv_shows_list_$index",
                  leftFocusKey:
                      index > 0 ? "popular_tv_shows_list_${index - 1}" : "home",
                  rightFocusKey: "popular_tv_shows_list_${index + 1}",
                  upFocusKey: "popular_tv_shows",
                  downFocusKey: "popular_actors",
                  focusGroup: "popular_tv_shows_list",
                  child: Container(
                    width: 150,
                    height: 200,
                    color: Colors.grey.shade900,
                    alignment: Alignment.center,
                    child: Text("TV Show ${index + 1}"),
                  ),
                );
              },
            ),
          ),
          const TVFocusable(
            focusKey: "popular_actors",
            leftFocusKey: "popular_tv_shows",
            downFocusKey: "group:popular_actors_list",
            upFocusKey: "group:popular_tv_shows_list",
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Popular Actors"),
                Text("View All"),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.separated(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                return TVFocusable(
                  focusKey: "popular_actors_list_$index",
                  leftFocusKey:
                      index > 0 ? "popular_actors_list_${index - 1}" : "home",
                  rightFocusKey: "popular_actors_list_${index + 1}",
                  upFocusKey: "popular_actors",
                  focusGroup: "popular_actors_list",
                  child: Container(
                    width: 150,
                    height: 200,
                    color: Colors.grey.shade900,
                    alignment: Alignment.center,
                    child: Text("Actor ${index + 1}"),
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
