import 'dart:io';

void main() {
  // ════════════════════════════════
  //  INPUT — Income
  // ════════════════════════════════
  print('===== Personal Finance Tracker =====');

  stdout.write('Enter your total income: ');
  String? incomeInput = stdin.readLineSync();
  double income = double.tryParse(incomeInput ?? '0') ?? 0;

  // ════════════════════════════════
  //  INPUT — Number of expenses
  // ════════════════════════════════
  stdout.write('How many expenses do you have? ');
  String? countInput = stdin.readLineSync();
  int count = int.tryParse(countInput ?? '0') ?? 0;

  // ════════════════════════════════
  //  LISTS — store expense data
  // ════════════════════════════════
  List<String> names      = [];
  List<double?> amounts   = []; // nullable — null safety for missing amounts
  List<String> categories = [];

  // ════════════════════════════════
  //  MAP — category totals (bonus)
  // ════════════════════════════════
  Map<String, double> categoryTotals = {
    'food'     : 0,
    'rent'     : 0,
    'transport': 0,
    'other'    : 0,
  };

  // ════════════════════════════════
  //  LOOP — collect each expense
  // ════════════════════════════════
  for (int i = 1; i <= count; i++) {
    print('\n--- Expense $i of $count ---');

    // name
    stdout.write('  Name: ');
    String? name = stdin.readLineSync();
    names.add(name ?? 'Unknown');

    // amount — NULL SAFETY: user can skip by pressing Enter
    stdout.write('  Amount (press Enter to skip): ');
    String? amountInput = stdin.readLineSync();
    double? amount = double.tryParse(amountInput ?? '');
    amounts.add(amount); // stored as null if skipped

    // category
    stdout.write('  Category (food / rent / transport / other): ');
    String? catInput = stdin.readLineSync();
    String cat = catInput ?? 'other';

    // CONDITION — validate category
    if (cat == 'food' || cat == 'rent' || cat == 'transport') {
      categories.add(cat);
    } else {
      categories.add('other');
      cat = 'other';
    }

    // MAP — add amount to correct category
    if (amount != null) {
      categoryTotals[cat] = (categoryTotals[cat] ?? 0) + amount;
    }
  }

  // ════════════════════════════════
  //  ARITHMETIC — calculations
  // ════════════════════════════════
  double totalExpenses = 0;
  int skippedCount     = 0;

  // LOOP through amounts list
  for (int i = 0; i < amounts.length; i++) {
    if (amounts[i] != null) {
      totalExpenses += amounts[i]!; // null assertion — safe here after check
    } else {
      skippedCount++;
    }
  }

  double balance        = income - totalExpenses;
  double savingsPercent = income > 0 ? (balance / income) * 100 : 0;

  // ════════════════════════════════
  //  OUTPUT — formatted summary
  //  using string interpolation
  // ════════════════════════════════
  print('\n===== Financial Summary =====');
  print('Total Income      : \$${income.toStringAsFixed(2)}');
  print('Total Expenses    : \$${totalExpenses.toStringAsFixed(2)}');
  print('Remaining Balance : \$${balance.toStringAsFixed(2)}');
  print('Savings Rate      : ${savingsPercent.toStringAsFixed(1)}%');

  // NULL SAFETY — inform user about skipped amounts
  if (skippedCount > 0) {
    print('\nNote: $skippedCount expense(s) had no amount — excluded from total.');
  }

  // CONDITION — budget status
  if (balance < 0) {
    print('\nWarning: You are OVER budget!');
  } else if (savingsPercent >= 20) {
    print('\nGreat job! You are saving well.');
  } else {
    print('\nTip: Try to save at least 20% of your income.');
  }

  // MAP — category breakdown (bonus)
  print('\n===== Expense by Category =====');
  categoryTotals.forEach((category, total) {
    if (total > 0) {
      print('  $category : \$${total.toStringAsFixed(2)}');
    }
  });

  print('\n===== End of Report =====');
}