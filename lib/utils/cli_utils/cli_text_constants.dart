class CliTextConstants {
  // 명령어 목록
  static const String showTodos = '목록 보기';
  static const String addTodo = '할 일 추가';
  static const String updateTodo = '할 일 수정';
  static const String toggleTodo = '완료 상태 토글';
  static const String deleteTodo = '할 일 삭제';
  static const String commandExit = '종료';

  // 메뉴 안내
  static const String menuHeader = '=== Todo CLI ===';
  static const String menuFooter = '-------------------';
  static const String promptChoice = '선택하세요: ';
  static const String invalidInput = '잘못된 입력입니다. 다시 시도하세요.';
  static const String programExit = '프로그램 종료';

  // 사용자 입력
  static const String enterTitle = '할 일 제목을 입력하세요: ';
  static const String enterUserId = '사용자 ID를 입력하세요: ';
  static const String enterTodoId = '수정할 할 일 ID를 입력하세요: ';
  static const String enterNewTitle = '새 제목을 입력하세요: ';
  static const String enterToggleId = '토글할 할 일 ID를 입력하세요: ';
  static const String enterDeleteId = '삭제할 할 일 ID를 입력하세요: ';
}

enum CliCommand {
  showTodos,
  addTodo,
  updateTodo,
  toggleTodo,
  deleteTodo,
  appExit,
}

CliCommand? parseCliCommand(String? input) {
  switch (input) {
    case '1':
      return CliCommand.showTodos;
    case '2':
      return CliCommand.addTodo;
    case '3':
      return CliCommand.updateTodo;
    case '4':
      return CliCommand.toggleTodo;
    case '5':
      return CliCommand.deleteTodo;
    case '0':
      return CliCommand.appExit;
    default:
      return null;
  }
}
