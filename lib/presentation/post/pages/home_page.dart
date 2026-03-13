import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_manager_app/core/theme/theme.dart';
import 'package:post_manager_app/core/widgets/app_loader.dart';
import 'package:post_manager_app/core/widgets/empty_state.dart';
import 'package:post_manager_app/core/widgets/error_view.dart';
import 'package:post_manager_app/presentation/post/bloc/post_bloc.dart';
import 'package:post_manager_app/presentation/post/widgets/post_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const AppLoader(message: 'Loading posts…');
          }
          if (state is PostError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<PostBloc>().add(GetPostsEvent()),
            );
          }
          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<PostBloc>().add(RefreshPostsEvent());
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 200,
                    child: EmptyState(
                      title: 'No posts yet',
                      subtitle: 'Pull down to refresh and load posts from the server.',
                      icon: Icons.article_outlined,
                      onAction: () => context.read<PostBloc>().add(RefreshPostsEvent()),
                      actionLabel: 'Refresh',
                    ),
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<PostBloc>().add(RefreshPostsEvent());
              },
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  AppSizing.listPaddingH,
                  AppSizing.listPaddingV,
                  AppSizing.listPaddingH,
                  AppSizing.listPaddingBottom,
                ),
                itemCount: state.posts.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSizing.listItemGap),
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return PostCard(
                    id: post.id,
                    title: post.title,
                    body: post.body,
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
