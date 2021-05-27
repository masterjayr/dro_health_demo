class Drug {
  final String imageUrl, name, price, amount, category, type, manufacturer;
  bool isSelected;
  int quantity;
  final int id;
  Drug(
      {this.imageUrl,
      this.id,
      this.name,
      this.price,
      this.amount,
      this.category,
      this.type,
      this.manufacturer,
      this.quantity,
      this.isSelected});

  //fromJson goes here
  factory Drug.fromJson(Map<String, dynamic> json) => Drug(
      name: json["name"] ?? null,
      imageUrl: json["imageUrl"] ?? null,
      price: json["price"] ?? null,
      amount: json["amount"] ?? null,
      category: json["category"] ?? null,
      type: json["type"] ?? null,
      manufacturer: json["manufacturer"] ?? null,
      isSelected: false,
      id: json["id"],
      quantity: json["quantity"] ?? null);

  Map<String, dynamic> toMap() => {
        'id': id,
        'imageUrl': imageUrl,
        'name': name,
        'amount': amount,
        'type': type,
        'price': price,
        'quantity': quantity
      };

  static List<Drug> drugJsonParser(List<Map<String, dynamic>> response) {
    final list = List.from(response);
    return list.map((e) => Drug.fromJson(e)).toList();
  }
}

// creating a list of drugs to return data when called by datasource
List<Drug> allDrugs = [
  Drug(
      id: 1,
      price: '₦1820',
      name: 'Emzoclox',
      amount: '125mg',
      category: 'Cefuroxlime Aventil',
      type: 'Oral Suspension',
      imageUrl: 'assets/images/drug1.jpeg',
      manufacturer: "Emzor Paracetamols",
      quantity: 1),
  Drug(
      id: 2,
      price: '₦850',
      name: 'Zoretic',
      amount: '250mg',
      category: 'Cefuroxlime Aventil',
      type: 'Tablet',
      imageUrl: 'assets/images/drug2.jpeg',
      manufacturer: "Emzor Paracetamols",
      quantity: 1),
  Drug(
      id: 3,
      price: '₦385',
      name: 'Emprofen',
      amount: '650mg',
      category: 'Cefuroxlime Aventil',
      type: 'Tablet',
      imageUrl: 'assets/images/drug3.jpeg',
      manufacturer: "Emzor Paracetamols",
      quantity: 1),
  Drug(
      id: 4,
      price: '₦170',
      name: 'Metformin',
      amount: '455mg',
      category: 'Cefuroxlime Aventil',
      type: 'Oral Suspension',
      imageUrl: 'assets/images/drug4.jpeg',
      manufacturer: "Emzor Paracetamols",
      quantity: 1),
  Drug(
      id: 5,
      price: '₦170',
      name: 'Emzo Vitamin',
      amount: '385mg',
      category: 'Folic Acid',
      type: 'Tablet',
      imageUrl: 'assets/images/drug5.jpeg',
      manufacturer: "Emzor Paracetamols",
      quantity: 1),
  Drug(
      id: 6,
      price: '₦1820',
      name: 'Emzoclox',
      amount: '125mg',
      category: 'Cefuroxlime Aventil',
      type: 'Oral Suspension',
      imageUrl: 'assets/images/drug1.jpeg',
      manufacturer: "Emzor Paracetamols",
      quantity: 1),
  Drug(
      id: 7,
      price: '₦850',
      name: 'Zoretic',
      amount: '250mg',
      category: 'Cefuroxlime Aventil',
      type: 'Tablet',
      imageUrl: 'assets/images/drug2.jpeg',
      manufacturer: "Emzor Paracetamols",
      quantity: 1),
  Drug(
      id: 8,
      price: '₦385',
      name: 'Emprofen',
      amount: '650mg',
      category: 'Cefuroxlime Aventil',
      type: 'Tablet',
      imageUrl: 'assets/images/drug3.jpeg',
      manufacturer: "Emzor Paracetamols",
      quantity: 1),
  Drug(
      id: 9,
      price: '₦170',
      name: 'Metformin',
      amount: '455mg',
      category: 'Cefuroxlime Aventil',
      type: 'Oral Suspension',
      imageUrl: 'assets/images/drug4.jpeg',
      manufacturer: "Emzor Paracetamols",
      quantity: 1),
  Drug(
      id: 10,
      price: '₦170',
      name: 'Emzo Vitamin',
      amount: '385mg',
      category: 'Folic Acid',
      type: 'Tablet',
      imageUrl: 'assets/images/drug5.jpeg',
      manufacturer: "Emzor Paracetamols",
      quantity: 1)
];
