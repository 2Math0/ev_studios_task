import 'package:ev_studios_task/bloc/articles-bloc.dart';
import 'package:ev_studios_task/model/articles-model.dart';
import 'package:ev_studios_task/page/water_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  @override
  ArticlesPageState createState() => ArticlesPageState();
}

class ArticlesPageState extends State<ArticlesPage> {
  final ArticlesBloc _articlesBloc = ArticlesBloc();

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorMessage(
          state, context) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message!),
        ),
      );
  @override
  void initState() {
    _articlesBloc.add(GetArticlesList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Articles')),
      body: _buildListArticles(),
      floatingActionButton: ElevatedButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (builder) => const WaterAnimationPage())),
          child: const Text('Water Animation')),
    );
  }

  Widget _buildListArticles() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _articlesBloc,
        child: BlocListener<ArticlesBloc, ArticlesState>(
          listener: (context, state) {
            if (state is ArticlesError) {
              errorMessage(state, context);
            }
          },
          child: BlocBuilder<ArticlesBloc, ArticlesState>(
            builder: (context, state) {
              if (state is ArticlesInitial) {
                return _buildLoading();
              } else if (state is ArticlesLoading) {
                return _buildLoading();
              } else if (state is ArticlesLoaded) {
                return _buildCard(context, state.articlesList!);
              } else if (state is ArticlesError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, List<ArticlesModel> modelList) {
    return ListView.builder(
      itemCount: modelList.length,
      itemBuilder: (context, index) {
        ArticlesModel model = modelList[index];
        return Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: const Color.fromARGB(255, 196, 193, 193), width: 0.5)),
          child: Column(
            children: [
              ExpansionTile(
                title: Text('About the Writer: ${model.name!.first}'),
                children: [
                  Text(
                      "Name: ${model.name!.first} ${model.name!.middle} ${model.name?.last}"
                          .toUpperCase()),
                  const SizedBox(height: 10),
                  Text(
                    "Gender ${model.gender}".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Species ${model.species}".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Home Plant ${model.homePlanet}".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Occupation ${model.occupation}".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "age ${model.age}".toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Image.network(
                "${model.images?.main}",
              ),
              ExpansionTile(
                title: const Text('His Sayings'),
                children: [
                  for (String saying in model.sayings!) Text(saying),
                ],
              ),
            ],
          ),
        );
        // ExpansionPanel(headerBuilder: headerBuilder, body: body),
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}

class ExpandedItem {
  bool isExpanded;
  ExpandedItem(this.isExpanded);
}
