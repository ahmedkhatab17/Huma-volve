import 'bank_branch.dart';
import 'savings_account.dart';
import 'checking_account.dart';
import 'investment_account.dart';

void main() {
  var savings    = SavingsAccount("SAV001", "Ahmed", 1000, "1111", 0.05);
  var checking   = CheckingAccount("CHK001", "Sara", 500, "2222", 200);
  var investment = InvestmentAccount("INV001", "Omar", 2000, "3333", RiskLevel.high);

  var branch = BankBranch();
  branch.addAccount(savings);
  branch.addAccount(checking);
  branch.addAccount(investment);

  savings.printInfo();
  checking.printInfo();
  investment.printInfo();

  savings.deposit(-50);
  savings.withdraw(100, "0000");
  savings.withdraw(100, "1111");

  checking.withdraw(600, "2222");

  branch.applyAnnualInterestToAll();

  branch.transferFunds(investment, savings, 300, "3333");
  branch.transferFunds(checking, savings, 999999, "2222");

  print("\n=== Final Balances ===");
  savings.printInfo();
  checking.printInfo();
  investment.printInfo();
}
