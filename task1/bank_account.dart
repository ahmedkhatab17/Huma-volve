abstract class BankAccount {
  final String _accountNumber;
  final String _holderName;
  double _balance;
  final String _pin;

  BankAccount(this._accountNumber, this._holderName, this._balance, this._pin);

  String get accountNumber => _accountNumber;
  String get holderName => _holderName;
  double get balance => _balance;

  bool checkPin(String enteredPin) => enteredPin == _pin;

  void deposit(double amount) {
    if (amount <= 0) {
      print("Deposit failed: amount must be greater than zero.");
      return;
    }
    _balance += amount;
    print("Deposited $amount. New balance: $_balance");
  }

  void setBalance(double newBalance) {
    _balance = newBalance;
  }

  double get rawBalanceForChildren => _balance;

  bool withdraw(double amount, String pin);
  double calculateInterest();

  void printInfo() {
    print("---- Account Info ----");
    print("Number : $_accountNumber");
    print("Holder : $_holderName");
    print("Balance: $_balance");
    print("----------------------");
  }
}
