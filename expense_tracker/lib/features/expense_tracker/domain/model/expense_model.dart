class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> json) => ExpenseModel(
    id: json['id'],
    title: json['title'],
    amount: json['amount'],
    date: DateTime.parse(json['date']),
    category: json['category'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'amount': amount,
    'date': date.toIso8601String(),
    'category': category,
  };
}
