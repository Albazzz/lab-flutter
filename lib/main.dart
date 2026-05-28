import 'dart:io';

abstract class Employee {
  String id;
  String fullName;
  double baseSalary;

  Employee({required this.id, required this.fullName, required this.baseSalary});

  double calculateIncome();

  double calculateTax() {
    double income = calculateIncome();
    if (income < 9000000) {
      return 0;
    } else if (income <= 15000000) {
      return (income - 9000000) * 0.1;
    } else {
      return (15000000 - 9000000) * 0.1 + (income - 15000000) * 0.12;
    }
  }

  double calculateNetIncome() {
    return calculateIncome() - calculateTax();
  }

  @override
  String toString() {
    return 'ID: $id | Name: $fullName | Base Salary: ${baseSalary.toStringAsFixed(0)} | Income: ${calculateIncome().toStringAsFixed(0)} | Tax: ${calculateTax().toStringAsFixed(0)} | Net: ${calculateNetIncome().toStringAsFixed(0)}';
  }
}

class AdministrativeEmployee extends Employee {
  AdministrativeEmployee({
    required String id,
    required String fullName,
    required double baseSalary,
  }) : super(id: id, fullName: fullName, baseSalary: baseSalary);

  @override
  double calculateIncome() => baseSalary;

  @override
  String toString() => '[Admin] ' + super.toString();
}

class SalesEmployee extends Employee {
  double salesRevenue;
  double commissionRate;

  SalesEmployee({
    required String id,
    required String fullName,
    required double baseSalary,
    required this.salesRevenue,
    required this.commissionRate,
  }) : super(id: id, fullName: fullName, baseSalary: baseSalary);

  @override
  double calculateIncome() => baseSalary + (salesRevenue * commissionRate);

  @override
  String toString() => '[Sales] ' + super.toString() + ' | Revenue: ${salesRevenue.toStringAsFixed(0)} | Rate: $commissionRate';
}

class Manager extends Employee {
  double responsibilityAllowance;

  Manager({
    required String id,
    required String fullName,
    required double baseSalary,
    required this.responsibilityAllowance,
  }) : super(id: id, fullName: fullName, baseSalary: baseSalary);

  @override
  double calculateIncome() => baseSalary + responsibilityAllowance;

  @override
  String toString() => '[Manager] ' + super.toString() + ' | Allowance: ${responsibilityAllowance.toStringAsFixed(0)}';
}

class EmployeeManagement {
  List<Employee> employees = [];

  void addEmployee(Employee emp) {
    employees.add(emp);
  }

  void displayAll() {
    if (employees.isEmpty) {
      print('Employee list is empty.');
      return;
    }
    employees.forEach(print);
  }

  Employee? findById(String id) {
    try {
      return employees.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  bool deleteById(String id) {
    int lengthBefore = employees.length;
    employees.removeWhere((e) => e.id == id);
    return employees.length < lengthBefore;
  }

  void updateEmployee(String id) {
    Employee? emp = findById(id);
    if (emp == null) {
      print('Employee with ID $id not found.');
      return;
    }

    print('Updating employee: ${emp.fullName}');
    stdout.write('Enter new name (leave blank to keep current): ');
    String? name = stdin.readLineSync();
    if (name != null && name.isNotEmpty) emp.fullName = name;

    stdout.write('Enter new base salary (leave blank to keep current): ');
    String? salaryStr = stdin.readLineSync();
    if (salaryStr != null && salaryStr.isNotEmpty) {
      emp.baseSalary = double.tryParse(salaryStr) ?? emp.baseSalary;
    }

    if (emp is SalesEmployee) {
      stdout.write('Enter new sales revenue (leave blank to keep current): ');
      String? revStr = stdin.readLineSync();
      if (revStr != null && revStr.isNotEmpty) {
        emp.salesRevenue = double.tryParse(revStr) ?? emp.salesRevenue;
      }
      stdout.write('Enter new commission rate (leave blank to keep current): ');
      String? rateStr = stdin.readLineSync();
      if (rateStr != null && rateStr.isNotEmpty) {
        emp.commissionRate = double.tryParse(rateStr) ?? emp.commissionRate;
      }
    } else if (emp is Manager) {
      stdout.write('Enter new allowance (leave blank to keep current): ');
      String? allowStr = stdin.readLineSync();
      if (allowStr != null && allowStr.isNotEmpty) {
        emp.responsibilityAllowance = double.tryParse(allowStr) ?? emp.responsibilityAllowance;
      }
    }
    print('Update successful.');
  }

  void searchByIncomeRange(double min, double max) {
    var results = employees.where((e) {
      double inc = e.calculateIncome();
      return inc >= min && inc <= max;
    }).toList();

    if (results.isEmpty) {
      print('No employees found in this income range.');
    } else {
      results.forEach(print);
    }
  }

  void sortByName() {
    employees.sort((a, b) => a.fullName.compareTo(b.fullName));
    print('Sorted by name.');
  }

  void sortByIncome() {
    employees.sort((a, b) => a.calculateIncome().compareTo(b.calculateIncome()));
    print('Sorted by income.');
  }

  void displayTop5() {
    var sorted = List<Employee>.from(employees);
    sorted.sort((a, b) => b.calculateIncome().compareTo(a.calculateIncome()));
    print('Top 5 highest income:');
    sorted.take(5).forEach(print);
  }
}

void main() {
  EmployeeManagement system = EmployeeManagement();

  while (true) {
    print('\n--- EMPLOYEE MANAGEMENT SYSTEM ---');
    print('1. Input employees');
    print('2. Display all employees');
    print('3. Search by ID');
    print('4. Delete by ID');
    print('5. Update employee');
    print('6. Search by income range');
    print('7. Sort by full name');
    print('8. Sort by total income');
    print('9. Top 5 highest income');
    print('0. Exit');
    stdout.write('Choose an option: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        inputEmployees(system);
        break;
      case '2':
        system.displayAll();
        break;
      case '3':
        stdout.write('Enter ID to search: ');
        String? id = stdin.readLineSync();
        if (id != null) {
          Employee? emp = system.findById(id);
          print(emp ?? 'Employee not found.');
        }
        break;
      case '4':
        stdout.write('Enter ID to delete: ');
        String? id = stdin.readLineSync();
        if (id != null) {
          if (system.deleteById(id)) {
            print('Deleted successfully.');
          } else {
            print('Employee not found.');
          }
        }
        break;
      case '5':
        stdout.write('Enter ID to update: ');
        String? id = stdin.readLineSync();
        if (id != null) system.updateEmployee(id);
        break;
      case '6':
        stdout.write('Min income: ');
        double min = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;
        stdout.write('Max income: ');
        double max = double.tryParse(stdin.readLineSync() ?? '0') ?? double.infinity;
        system.searchByIncomeRange(min, max);
        break;
      case '7':
        system.sortByName();
        system.displayAll();
        break;
      case '8':
        system.sortByIncome();
        system.displayAll();
        break;
      case '9':
        system.displayTop5();
        break;
      case '0':
        print('Exiting...');
        return;
      default:
        print('Invalid choice.');
    }
  }
}

void inputEmployees(EmployeeManagement system) {
  while (true) {
    print('\nAdding new employee (leave ID blank to stop):');
    stdout.write('ID: ');
    String? id = stdin.readLineSync();
    if (id == null || id.isEmpty) break;

    stdout.write('Full Name: ');
    String? name = stdin.readLineSync() ?? '';
    stdout.write('Base Salary: ');
    double salary = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;

    print('Type: 1. Admin, 2. Sales, 3. Manager');
    stdout.write('Choice: ');
    String? type = stdin.readLineSync();

    if (type == '1') {
      system.addEmployee(AdministrativeEmployee(id: id, fullName: name, baseSalary: salary));
    } else if (type == '2') {
      stdout.write('Sales Revenue: ');
      double rev = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;
      stdout.write('Commission Rate (e.g., 0.1 for 10%): ');
      double rate = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;
      system.addEmployee(SalesEmployee(id: id, fullName: name, baseSalary: salary, salesRevenue: rev, commissionRate: rate));
    } else if (type == '3') {
      stdout.write('Responsibility Allowance: ');
      double allow = double.tryParse(stdin.readLineSync() ?? '0') ?? 0;
      system.addEmployee(Manager(id: id, fullName: name, baseSalary: salary, responsibilityAllowance: allow));
    } else {
      print('Invalid type. Employee not added.');
    }
  }
}
