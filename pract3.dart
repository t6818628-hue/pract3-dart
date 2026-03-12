void main() {
  List<String> students = ["Байматова", "Куприянов", "Рахимова", "Чередниченко", "Боктаева"];
  List<String> subjects = ["Математика", "Физика", "Химия", "Информатика"];
  List<List<int>> grades = [
    [5, 4, 5, 3],
    [4, 4, 3, 4],
    [5, 5, 4, 5],
    [3, 2, 3, 4],
    [4, 5, 4, 4],
  ];

  print("СВОДНАЯ ТАБЛИЦА ОЦЕНОК");

  List<double> studentAvg = [];
  for (var studentGrades in grades) {
    double avg = studentGrades.reduce((a, b) => a + b) / studentGrades.length;
    studentAvg.add(avg);
  }

  print("Студент        Математика Физика Химия Информатика Средний балл");

  for (int i = 0; i < students.length; i++) {
    String row = students[i] + "    ";
    for (int j = 0; j < subjects.length; j++) {
      row += "   " + grades[i][j].toString();
    }
    row += "        " + studentAvg[i].toString();
    print(row);
  }

  List<double> subjectAvg = List.filled(subjects.length, 0.0);
  for (int j = 0; j < subjects.length; j++) {
    int sum = 0;
    for (int i = 0; i < students.length; i++) {
      sum += grades[i][j];
    }
    subjectAvg[j] = sum / students.length;
  }

  String footer = "Ср. по предм. ";
  for (var avg in subjectAvg) {
    footer += "   " + avg.toString();
  }
  print(footer);
  print("");

  String searchName = "Чередниченко";
  print("ПОИСК СТУДЕНТА: $searchName");
  int? index = students.indexWhere((name) => name == searchName);
  if (index != -1) {
    print("Оценки:");
    for (int j = 0; j < subjects.length; j++) {
      print("  ${subjects[j]}: ${grades[index][j]}");
    }
    double avg = studentAvg[index];
    String category;
    if (avg >= 4.5) {
      category = "отличник";
    } else if (avg >= 3.5) {
      category = "хорошист";
    } else {
      category = "остальные";
    }
    print("Средний балл: " + avg.toString());
    print("Категория: $category");
  } else {
    print("Студент с именем '$searchName' не найден.");
  }
  print("");

  Set<int> uniqueGrades = {};
  for (var row in grades) {
    uniqueGrades.addAll(row);
  }
  print("УНИКАЛЬНЫЕ ОЦЕНКИ: ${uniqueGrades.toList()}");
  print("");

  print("МАКСИМАЛЬНЫЕ И МИНИМАЛЬНЫЕ ОЦЕНКИ ПО ПРЕДМЕТАМ");
  for (int j = 0; j < subjects.length; j++) {
    int maxGrade = grades.map((row) => row[j]).reduce((a, b) => a > b ? a : b);
    int minGrade = grades.map((row) => row[j]).reduce((a, b) => a < b ? a : b);
    List<String> maxStudents = [];
    List<String> minStudents = [];
    for (int i = 0; i < students.length; i++) {
      if (grades[i][j] == maxGrade) maxStudents.add(students[i]);
      if (grades[i][j] == minGrade) minStudents.add(students[i]);
    }
    print("${subjects[j]}:");
    print("  Максимум $maxGrade (${maxStudents.join(', ')})");
    print("  Минимум $minGrade (${minStudents.join(', ')})");
  }
  print("");

  print("СТУДЕНТЫ С РОВНО ОДНОЙ ДВОЙКОЙ:");
  for (int i = 0; i < students.length; i++) {
    List<int> badSubjects = [];
    for (int j = 0; j < subjects.length; j++) {
      if (grades[i][j] == 2) badSubjects.add(j);
    }
    if (badSubjects.length == 1) {
      int subjIndex = badSubjects[0];
      print("${students[i]} — предмет: ${subjects[subjIndex]}");
    }
  }
  print("");

  double totalSum = 0;
  int totalCount = 0;
  for (var row in grades) {
    totalSum += row.reduce((a, b) => a + b);
    totalCount += row.length;
  }
  double overallAvg = totalSum / totalCount;
  print("ОБЩИЙ СРЕДНИЙ БАЛЛ ПО ГРУППЕ: " + overallAvg.toString());
  print("ПРЕДМЕТЫ СО СРЕДНИМ БАЛЛОМ ВЫШЕ ОБЩЕГО:");
  for (int j = 0; j < subjects.length; j++) {
    if (subjectAvg[j] > overallAvg) {
      print("  ${subjects[j]} (" + subjectAvg[j].toString() + ")");
    }
  }
  print("");

  int excellent = 0, good = 0, other = 0;
  for (var avg in studentAvg) {
    if (avg >= 4.5) {
      excellent++;
    } else if (avg >= 3.5) {
      good++;
    } else {
      other++;
    }
  }
  print("КАТЕГОРИИ УСПЕВАЕМОСТИ:");
  print("  Отличники: $excellent");
  print("  Хорошисты: $good");
  print("  Остальные: $other");
}
