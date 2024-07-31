import 'package:go_router/go_router.dart';
import 'package:roomah/app/app_page.dart';
import 'package:roomah/app/auth/signin_page.dart';
import 'package:roomah/app/finance/finance_dashboard_page.dart';
import 'package:roomah/app/notes/notes_list_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (ctx, state) => const AppPage(),
    ),
    GoRoute(
      name: 'signInPage',
      path: '/auth/signin',
      builder: (ctx, state) => const SigninPage(),
    ),
    GoRoute(
      name: 'financePage',
      path: '/finance/dashboard',
      builder: (ctx, state) => const FinanceDashboardPage(),
    ),
    GoRoute(
      name: 'notesPage',
      path: '/notes/list',
      builder: (ctx, state) => const NotesListPage(),
    ),
  ],
);
