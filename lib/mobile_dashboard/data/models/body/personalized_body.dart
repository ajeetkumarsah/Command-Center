class PesonalizedHeaderBody {
  final String header;
  final List<PersonalizedBody> items;

  const PesonalizedHeaderBody({
    required this.header,
    required this.items,
  });
}

class PersonalizedBody {
  final String title;
  final void Function(bool)? onChanged;
  final bool value;

  PersonalizedBody({
    required this.title,
    required this.onChanged,
    required this.value,
  });
}
