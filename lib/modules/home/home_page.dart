import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge/modules/home/widgets/drawer_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:challenge/core/utils/enums.dart';

import '../../core/services/routing.dart';
import 'cubit/home_cubit.dart';
import '../../core/ui/widgets/entity_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeCubit>().init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onPressed: () async {
                  if (!context.mounted) return;
                  context.read<HomeCubit>().reset();
                  await context.read<HomeCubit>().getHouseRules();
                },
                icon: const Icon(Icons.refresh),
              );
            },
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  await context
                      .pushNamed(AppRoutes.entity.name)
                      .then((value) async {
                    final result = value is bool;
                    if (result && value) {
                      if (!context.mounted) return;
                      context.read<HomeCubit>().reset();
                      await context.read<HomeCubit>().getHouseRules();
                    }
                  });
                },
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
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                if (state.entitiesList.length > 10 &&
                    state.status == Status.completed) {
                  state.scrollController
                      .jumpTo(state.scrollController.position.maxScrollExtent);
                }
              });
            },
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
                    controller: state.scrollController,
                    itemCount: state.entitiesList.length + 1,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.grey[400],
                        height: 2,
                      );
                    },
                    itemBuilder: (context, index) {
                      if (index < state.entitiesList.length) {
                        return EntityCard(
                          onDeletePressed: () async {
                            await context
                                .read<HomeCubit>()
                                .deleteHouseRules(state.entitiesList[index]);
                          },
                          onTap: () async {
                            await context.pushNamed(
                              AppRoutes.entity.name,
                              extra: {
                                'entity': state.entitiesList[index],
                              },
                            ).then((value) async {
                              final result = value is bool;
                              if (result && value) {
                                if (!context.mounted) return;
                                context.read<HomeCubit>().reset();
                                await context.read<HomeCubit>().getHouseRules();
                              }
                            });
                          },
                          entities: state.entitiesList[index],
                        );
                      } else {
                        return state.page == state.totalPages
                            ? const Padding(
                                padding: EdgeInsets.symmetric(vertical: 30),
                                child: Text(
                                  'No more data to load',
                                  textAlign: TextAlign.center,
                                ))
                            : const Center(
                                child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 30),
                                child: CircularProgressIndicator(),
                              ));
                      }
                    },
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
