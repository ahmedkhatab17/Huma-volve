import 'bank_account.dart';

class BankBranch {
  final List<BankAccount> _accounts = [];

  void addAccount(BankAccount account) {
    _accounts.add(account);
    print("Account ${account.accountNumber} added to branch.");
  }

  void applyAnnualInterestToAll() {
    print("\n=== Applying annual interest to all accounts ===");
    for (BankAccount account in _accounts) {
      double interest = account.calculateInterest();
      account.deposit(interest);
    }
  }

  bool transferFunds(BankAccount sender, BankAccount receiver, double amount, String senderPin) {
    print("\nTransferring $amount from ${sender.accountNumber} to ${receiver.accountNumber}...");
    bool withdrawSuccess = sender.withdraw(amount, senderPin);
    if (!withdrawSuccess) {
      print("Transfer canceled: sender withdrawal failed.");
      return false;
    }
    receiver.deposit(amount);
    print("Transfer complete.");
    return true;
  }
}
