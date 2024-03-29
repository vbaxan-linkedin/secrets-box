part of auth_views;

final class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const HasUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is UserLoggedIn) {
          const SecretsScreenRoute().go(context);
        }
      },
      builder: (BuildContext context, AuthState state) {
        return switch (state) {
          AuthInitial() => AppScreen.blank(),
          FetchingHasUsers() => AppScreen.loadingWithoutAppBar(),
          HasUsersFetched(hasUsers: false) => const CreateProfileScreen(),
          HasUsersFetched(hasUsers: true) => const LoginScreen(),
          _ => AppScreen.normal(
              appBar: CustomAppBar.normal(
                context,
                title: 'Login',
              ),
              child: const SizedBox.shrink(),
            ),
        };
      },
    );
  }
}
