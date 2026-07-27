class Invoice {
  final String invoiceId;
  double totalAmount;

  Invoice(this.invoiceId, this.totalAmount);

  void printInvoice() {
    print("Invoice $invoiceId | Total: $totalAmount");
  }
}
