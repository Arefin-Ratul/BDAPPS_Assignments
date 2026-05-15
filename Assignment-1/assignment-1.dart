import 'dart:io';
void main() {
  print('===== Personal Finance Tracker of Ratul =====');
  stdout.write('Enter your total income: ');
  String? incomeInput = stdin.readLineSync();
  double income = double.tryParse(incomeInput ?? '0') ?? 0;
  stdout.write('How many expenses do you have? ');
  String? countInput = stdin.readLineSync();
  int count = int.tryParse(countInput ?? '0') ?? 0;
  List<String> names      = [];
  List<double?> amounts   = []; // nullable — null safety for missing amounts
  List<String> categories = [];
  Map<String, double> categoryTotals = {
    'food'     : 0,
    'rent'     : 0,
    'transport': 0,
    'other'    : 0,
  };
  for (int i = 1; i <= count; i++) {
    print('\n--- Expense $i of $count ---');
    stdout.write('  Name: ');
    String? name = stdin.readLineSync();
    names.add(name ?? 'Unknown');

    stdout.write('  Amount (press Enter to skip): ');
    String? amountInput = stdin.readLineSync();
    double? amount = double.tryParse(amountInput ?? '');
    amounts.add(amount); // stored as null if skipped
    stdout.write('  Category (food / rent / transport / other): ');
    String? catInput = stdin.readLineSync();
    String cat = catInput ?? 'other';

    if (cat == 'food' || cat == 'rent' || cat == 'transport') {
      categories.add(cat);
    } else {
      categories.add('other');
      cat = 'other';
    }
    if (amount != null) {
      categoryTotals[cat] = (categoryTotals[cat] ?? 0) + amount;
    }
  }
  double totalExpenses = 0;
  int skippedCount     = 0;
  for (int i = 0; i < amounts.length; i++) {
    if (amounts[i] != null) {
      totalExpenses += amounts[i]!; // null assertion — safe here after check
    } else {
      skippedCount++;
    }
  }
  double balance        = income - totalExpenses;
  double savingsPercent = income > 0 ? (balance / income) * 100 : 0;
  print('\n===== Financial Summary =====');
  print('Total Income      : \$${income.toStringAsFixed(2)}');
  print('Total Expenses    : \$${totalExpenses.toStringAsFixed(2)}');
  print('Remaining Balance : \$${balance.toStringAsFixed(2)}');
  print('Savings Rate      : ${savingsPercent.toStringAsFixed(1)}%');
  if (skippedCount > 0) {
    print('\nNote: $skippedCount expense(s) had no amount — excluded from total.');
  }
  if (balance < 0) {
    print('\nWarning: You are OVER budget!');
  } else if (savingsPercent >= 20) {
    print('\nGreat job! You are saving well.');
  } else {
    print('\nTip: Try to save at least 20% of your income.');
  }
  print('\n===== Expense by Category =====');
  categoryTotals.forEach((category, total) {
    if (total > 0) {
      print('  $category : \$${total.toStringAsFixed(2)}');
    }
  });s
}