part of 'home_cubit.dart';

enum HomeTab { discover, orders, vouchers, friends }

class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.discover,
    this.reTab = 0,
  });

  final HomeTab tab;
  final int reTab;

  @override
  List<Object> get props => [tab, reTab];
}
