import 'bank_account.dart';

enum RiskLevel { low, medium, high }

class InvestmentAccount extends BankAccount {
  final RiskLevel riskLevel;

  InvestmentAccount(
    String accountNumber,
    String holderName,
    double balance,
    String pin,
    this.riskLevel,
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
    if (amount > rawBalanceForChildren) {
      print("Withdrawal failed: insufficient funds.");
      return false;
    }
    setBalance(rawBalanceForChildren - amount);
    print("Withdrew $amount. Balance now: ${rawBalanceForChildren}");
    return true;
  }

  @override
  double calculateInterest() {
    double rate;
    switch (riskLevel) {
      case RiskLevel.low:
        rate = 0.02;
        break;
      case RiskLevel.medium:
        rate = 0.05;
        break;
      case RiskLevel.high:
        rate = 0.10;
        break;
    }
    double interest = rawBalanceForChildren * rate;
    print("Investment interest ($riskLevel risk): $interest");
    return interest;
  }
}
