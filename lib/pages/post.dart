import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cdr_today/blocs/post.dart';
import 'package:cdr_today/blocs/_author.dart';
import 'package:cdr_today/widgets/post.dart';

class Post extends StatefulWidget {
  final SliverAppBar appBar;
  final SliverList title;
  Post({ this.appBar, this.title });
  
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is Posts) {
          return PostList(
            posts: state.posts,
            appBar: widget.appBar,
            title: widget.title,
            hasReachedMax: state.hasReachedMax,
          );
        }
        return PostList(
          appBar: widget.appBar,
          title: widget.title,
          loading: true,
        );
      }
    );
  }
}

class AuthorPostContainer extends StatefulWidget {
  final SliverAppBar appBar;
  final SliverList title;
  final String mail;
  AuthorPostContainer({ this.appBar, this.title, this.mail });
  
  @override
  _AuthorPostContainerState createState() =>_AuthorPostContainerState();
}

class _AuthorPostContainerState extends State<AuthorPostContainer> {
  Widget build(BuildContext context) {
    final AuthorPostBloc _bloc = BlocProvider.of<AuthorPostBloc>(context);
    return BlocBuilder<AuthorPostBloc, AuthorPostState>(
      builder: (context, state) {
        if (state is AuthorPostsUnFetched) {
          _bloc.dispatch(FetchAuthorPosts(mail: widget.mail));
          return PostList(
            appBar: widget.appBar,
            title: widget.title,
            loading: true,
          );
        } else if (state is AuthorPosts) {
          return PostList(
            posts: state.posts,
            appBar: widget.appBar,
            title: widget.title,
            hasReachedMax: state.hasReachedMax,
          );
        }
        return PostList(
          appBar: widget.appBar,
          title: widget.title,
          loading: true,
        );
      }
    );
  }
}
