import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_challenge/core/services/dependency_injection.dart';
import 'package:github_challenge/modules/home/widgets/drawer_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:github_challenge/core/utils/enums.dart';

import '../../core/services/routing.dart';
import 'cubit/home_cubit.dart';
import '../../core/ui/widgets/entity_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = locator<HomeCubit>();
        cubit.getHouseRules();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Flutter Challenge',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () async =>
                      await context.read<HomeCubit>().getHouseRules(),
                  icon: const Icon(Icons.refresh),
                );
              },
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () async =>
                      await context.read<HomeCubit>().getHouseRules(),
                  icon: const Icon(Icons.add),
                );
              },
            ),
          ],
        ),
        drawer: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) => DrawerWidget(
            userData: context.read<HomeCubit>().getUser(),
            onLogoutPressed: () =>
                context.read<HomeCubit>().logout().whenComplete(
                      () => context.pushReplacementNamed(AppRoutes.login.name),
                    ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                switch (state.status) {
                  case Status.initial:
                    return const SizedBox.shrink();
                  case Status.error:
                    return Center(
                      child: Column(
                        children: [
                          const Text('Error searching user.'),
                          ElevatedButton(
                            onPressed: () => context.read<HomeCubit>().reset(),
                            child: const Text('Try again'),
                          ),
                        ],
                      ),
                    );
                  case Status.loading:
                    return const Center(child: CircularProgressIndicator());
                  case Status.completed:
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.entitiesList.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.grey[400],
                          height: 2,
                        );
                      },
                      itemBuilder: (context, index) => EntityCard(
                        onDeletePressed: () {},
                        onTap: () {
                          context.pushNamed(
                            AppRoutes.entity.name,
                            extra: {
                              'entity': state.entitiesList[index],
                            },
                          );
                        },
                        entities: state.entitiesList[index],
                      ),
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
