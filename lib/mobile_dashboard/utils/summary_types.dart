enum SummaryTypes { retailing, coverage, gp, fb }

extension SummaryTypesExtension on SummaryTypes {
  String get type {
    switch (this) {
      case SummaryTypes.retailing:
        return 'Retailing';
      case SummaryTypes.coverage:
        return 'Coverage';
      case SummaryTypes.gp:
        return 'Golden Points';
      case SummaryTypes.fb:
        return 'Focus Brand';
      default:
        return 'All';
    }
  }

  void talk() {

  }
}
