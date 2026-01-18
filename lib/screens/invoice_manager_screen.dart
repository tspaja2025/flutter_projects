import "package:flutter/material.dart";

// Add Logic

class InvoiceManagerScreen extends StatefulWidget {
  const InvoiceManagerScreen({super.key});

  @override
  State<StatefulWidget> createState() => InvoiceManagerScreenState();
}

class InvoiceManagerScreenState extends State<InvoiceManagerScreen> {
  final invoices = InvoiceRepository().invoices;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Invoice Manager"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: Column(
                crossAxisAlignment: .end,
                children: [
                  FilledButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CreateNewInvoiceScreen(),
                        ),
                      );
                    },
                    child: const Text("New Invoice"),
                  ),
                  const SizedBox(height: 16),
                  // Empty state
                  if (invoices.isEmpty) ...{
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: Padding(
                          padding: const .all(16),
                          child: Column(
                            children: [
                              Text(
                                "No Invoices yet.",
                                style: TextTheme.of(context).titleLarge,
                              ),
                              const Text(
                                "Get started by creating your first invoice.",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  } else ...{
                    ...invoices.map((invoice) {
                      return _buildInvoiceCard();
                    }),
                  },
                ],
              ),
            ),
          ),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateNewInvoiceScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add_outlined),
                ),
        );
      },
    );
  }

  Widget _buildInvoiceCard() {
    return Card(
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 8,
              children: [
                Text(
                  "INV-27122025",
                  style: TextTheme.of(
                    context,
                  ).titleMedium?.copyWith(fontWeight: .bold),
                ),
                Chip(padding: const .all(4), label: const Text("Draft")),
                const Spacer(),
                MenuAnchor(
                  menuChildren: [
                    MenuItemButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const CreateNewInvoiceScreen(),
                          ),
                        );
                      },
                      leadingIcon: const Icon(Icons.visibility_outlined),
                      child: const Text("Preview"),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const CreateNewInvoiceScreen(),
                          ),
                        );
                      },
                      leadingIcon: const Icon(Icons.edit_outlined),
                      child: const Text("Edit"),
                    ),
                    MenuItemButton(
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Confirm Invoice Deletion"),
                              content: const Text(
                                "Are you sure you want to delete this Invoice?",
                              ),
                              actions: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text("Invoice deleted."),
                                      ),
                                    );
                                  },
                                  child: const Text("Delete Invoice"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      leadingIcon: const Icon(Icons.delete_outline),
                      child: const Text("Delete"),
                    ),
                  ],
                  builder: (context, controller, child) {
                    return IconButton(
                      onPressed: () {
                        if (controller.isOpen) {
                          controller.close();
                        } else {
                          controller.open();
                        }
                      },
                      icon: const Icon(Icons.more_vert),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text("John Doe", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            const Text(
              "john.doe@john.doe",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
            const Text(
              "Date: 27/12/2025 | Due: 18/01/2026 | Items: 1 | Amount: \$9.99",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

const List<String> dropdownList = <String>["Draft", "Sent", "Paid", "Overdue"];

class CreateNewInvoiceScreen extends StatefulWidget {
  const CreateNewInvoiceScreen({super.key});

  @override
  State<CreateNewInvoiceScreen> createState() => CreateNewInvoiceScreenState();
}

class CreateNewInvoiceScreenState extends State<CreateNewInvoiceScreen> {
  final _invoiceNumberController = TextEditingController();
  final _clientNameController = TextEditingController();
  final _clientEmailController = TextEditingController();
  final _clientAddressController = TextEditingController();
  final _notesController = TextEditingController();

  final _descController = TextEditingController();
  final _qtyController = TextEditingController(text: "1");
  final _priceController = TextEditingController();
  final _taxController = TextEditingController(text: "0");

  final List<InvoiceLineItem> _items = [];

  String dropdownValue = dropdownList.first;
  DateTime? selectedDate;
  DateTime? dueDate;

  Future<void> _selectedDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 12, 27),
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  Future<void> _dueDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2025, 12, 27),
      firstDate: DateTime(2025),
      lastDate: DateTime(2026),
    );

    setState(() {
      dueDate = pickedDate;
    });
  }

  void _addLineItem() {
    if (_descController.text.isEmpty) return;

    setState(() {
      _items.add(
        InvoiceLineItem(
          description: _descController.text,
          quantity: int.tryParse(_qtyController.text) ?? 1,
          unitPrice: double.tryParse(_priceController.text) ?? 0,
          taxRate: double.tryParse(_taxController.text) ?? 0,
        ),
      );

      _descController.clear();
      _qtyController.text = "1";
      _priceController.clear();
      _taxController.text = "0";
    });
  }

  void _saveInvoice() {
    if (_items.isEmpty) return;

    final invoice = Invoice(
      invoiceNumber: _invoiceNumberController.text,
      status: InvoiceStatus.draft,
      issueDate: selectedDate ?? DateTime.now(),
      dueDate: dueDate ?? DateTime.now().add(const Duration(days: 14)),
      clientName: _clientNameController.text,
      clientEmail: _clientEmailController.text,
      clientAddress: _clientAddressController.text,
      items: _items,
      notes: _notesController.text,
    );

    InvoiceRepository().add(invoice);

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _invoiceNumberController.dispose();
    _clientNameController.dispose();
    _clientEmailController.dispose();
    _clientAddressController.dispose();
    _notesController.dispose();
    _descController.dispose();
    _qtyController.dispose();
    _priceController.dispose();
    _taxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isLargeScreen = constraints.maxWidth >= 720;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Create New Invoice"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const .all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const .all(16),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            // Invoice Details
                            const Text("Invoice Details"),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: const Text("Invoice Number"),
                                      hintText: "INV-27122025",
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                DropdownButton(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownValue = value!;
                                    });
                                  },
                                  items: dropdownList.map((String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              spacing: 8,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      selectedDate != null
                                          ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                          : "No date selected",
                                    ),
                                    OutlinedButton(
                                      onPressed: _selectedDate,
                                      child: const Text("Select date"),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      dueDate != null
                                          ? "${dueDate!.day}/${dueDate!.month}/${dueDate!.year}"
                                          : "No date selected",
                                    ),
                                    OutlinedButton(
                                      onPressed: _dueDate,
                                      child: const Text("Due date"),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 32),
                            const Divider(),
                            const SizedBox(height: 24),

                            // Client Information
                            const Text("Client Information"),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: const Text("Client Name"),
                                      hintText: "John Doe",
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      label: const Text("Client Email"),
                                      hintText: "john@example.com",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                label: const Text("Client Address"),
                                hintText: "123 Main St, City, Country",
                              ),
                            ),

                            const SizedBox(height: 32),
                            const Divider(),
                            const SizedBox(height: 24),

                            // Line Items
                            Row(
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                const Text("Line Items"),
                                FilledButton.icon(
                                  onPressed: _addLineItem,
                                  icon: const Icon(Icons.add),
                                  label: const Text("Add item"),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // New Line item form
                            Container(
                              padding: const .all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: .circular(8),
                              ),
                              child: Row(
                                crossAxisAlignment: .end,
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: const Text("Description"),
                                        hintText: "Description",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  SizedBox(
                                    width: 100,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: const Text("Qty"),
                                        hintText: "0",
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  SizedBox(
                                    width: 140,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: const Text("Unit Price"),
                                        hintText: "0.00",
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  SizedBox(
                                    width: 120,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: const Text("Tax Rate"),
                                        hintText: "0",
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  SizedBox(
                                    width: 140,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        label: const Text("Amount"),
                                        hintText: "0.00",
                                      ),
                                      enabled: false,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton.outlined(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Totals
                            Align(
                              alignment: .centerRight,
                              child: Container(
                                width: 300,
                                padding: const .all(16),
                                decoration: BoxDecoration(
                                  border: .all(color: Colors.grey),
                                  borderRadius: .circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: .end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        const Text(
                                          "Subtotal: ",
                                          style: TextStyle(fontWeight: .w600),
                                        ),
                                        Text("\$0.00"),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        const Text(
                                          "Tax: ",
                                          style: TextStyle(fontWeight: .w600),
                                        ),
                                        Text("\$0.00"),
                                      ],
                                    ),
                                    const Divider(),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        const Text(
                                          "Total: ",
                                          style: TextStyle(fontWeight: .bold),
                                        ),
                                        Text("\$0.00"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 32),
                            const Divider(),
                            const SizedBox(height: 24),

                            // Notes
                            const Text("Notes"),
                            const SizedBox(height: 16),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText:
                                    "Payment terms, additional information, etc",
                              ),
                              maxLines: 3,
                            ),

                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: .end,
                              children: [
                                FilledButton(
                                  onPressed: _saveInvoice,
                                  child: const Text("Save"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: isLargeScreen
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.save_outlined),
                ),
        );
      },
    );
  }
}

enum InvoiceStatus { draft, sent, paid, overdue }

class InvoiceLineItem {
  String description;
  int quantity;
  double unitPrice;
  double taxRate;

  InvoiceLineItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.taxRate,
  });

  double get subtotal => quantity * unitPrice;

  double get taxAmount => subtotal * (taxRate / 100);

  double get total => subtotal + taxAmount;
}

class Invoice {
  String invoiceNumber;
  InvoiceStatus status;
  DateTime issueDate;
  DateTime dueDate;
  String clientName;
  String clientEmail;
  String clientAddress;
  List<InvoiceLineItem> items;
  String notes;

  Invoice({
    required this.invoiceNumber,
    required this.status,
    required this.issueDate,
    required this.dueDate,
    required this.clientName,
    required this.clientEmail,
    required this.clientAddress,
    required this.items,
    required this.notes,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.subtotal);

  double get tax => items.fold(0, (sum, item) => sum + item.taxAmount);

  double get total => subtotal + tax;
}

class InvoiceRepository {
  static final InvoiceRepository _instance = InvoiceRepository._internal();
  factory InvoiceRepository() => _instance;
  InvoiceRepository._internal();
  final List<Invoice> _invoices = [];

  List<Invoice> get invoices => List.unmodifiable(_invoices);

  void add(Invoice invoice) {
    _invoices.add(invoice);
  }

  void remove(Invoice invoice) {
    _invoices.remove(invoice);
  }

  void update(int index, Invoice invoice) {
    _invoices[index] = invoice;
  }
}
