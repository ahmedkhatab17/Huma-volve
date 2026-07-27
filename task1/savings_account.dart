import 'bank_account.dart';

class SavingsAccount extends BankAccount {
  final double interestRate;
  int _withdrawCountThisMonth = 0;

  SavingsAccount(
    String accountNumber,
    String holderName,
    double balance,
    String pin,
    this.interestRate,
  ) : super(accountNumber, holderName, balance, pin);

  @override
  bool withdraw(double amount, String pin) {
    if (!checkPin(pin)) {
      print("Withdrawal failed: incorrect PIN.");
      return false;
    }
    if (_withdrawCountThisMonth >= 3) {
      print("Withdrawal failed: monthly limit of 3 withdrawals reached.");
      return false;
    }
    if (amount <= 0) {
      print("Withdrawal failed: amount must be greater than zero.");
      return false;
    }
    if (amount > rawBalanceForChildren) {
      print("Withdrawal failed: insufficient funds.");
      return false;
    }
    setBalance(rawBalanceForChildren - amount);
    _withdrawCountThisMonth++;
    print("Withdrew $amount. Withdrawals remaining this month: ${3 - _withdrawCountThisMonth}");
    return true;
  }

  @override
  double calculateInterest() {
    double interest = rawBalanceForChildren * interestRate;
    print("Savings interest: $interest (rate: $interestRate)");
    return interest;
  }
}
