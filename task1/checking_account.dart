import 'bank_account.dart';

class CheckingAccount extends BankAccount {
  final double overdraftLimit;

  CheckingAccount(
    String accountNumber,
    String holderName,
    double balance,
    String pin,
    this.overdraftLimit,
  ) : super(accountNumber, holderName, balance, pin);

  @override
  bool withdraw(double amount, String pin) {
    if (!checkPin(pin)) {
      print("Withdrawal failed: incorrect PIN.");
      return false;
    }
    if (amount <= 0) {
      print("Withdrawal failed: amount must be greater than zero.");
      return false;
    }
    double balanceAfter = rawBalanceForChildren - amount;
    if (balanceAfter < -overdraftLimit) {
      print("Withdrawal failed: exceeds overdraft limit of $overdraftLimit.");
      return false;
    }
    setBalance(balanceAfter);
    print("Withdrew $amount. Balance now: $balanceAfter");
    return true;
  }

  @override
  double calculateInterest() {
    print("Checking account accrues no interest.");
    return 0;
  }
}
