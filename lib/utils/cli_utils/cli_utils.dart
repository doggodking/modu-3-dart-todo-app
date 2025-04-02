import 'dart:io';
import 'package:todo_app/repository/todo_repository_impl.dart';
import 'package:todo_app/utils/cli_utils/cli_text_constants.dart';
import 'package:todo_app/utils/logs/app_log.dart';
import '../../data_source/todo_data_source_impl.dart';
import '../../model/todo.dart';
import '../../repository/todo_repository.dart';

class CliUtils {
  final TodoRepository repository = TodoRepositoryImpl(
    datasource: TodoDataSourceImpl(path: 'data/todos.json'),
  );
  final AppLog logger = AppLog();

  // 공통 체크 함수
  bool? isNumber(String? str) {
    if (!_isEmptyCommand(str)) {
      final number = num.tryParse(str!);
      return (number != null);
    }
    return null;
  }

  bool _isEmptyCommand(String? str) {
    if (str == null && str!.isEmpty) {
      print(CliTextConstants.invalidInput);
      return true;
    }
    return false;
  }

  // 할 일 목록 보기
  Future<void> showTodos() async {
    final todos = await repository.getTodos();

    // 할 일이 없으면
    if (todos.isEmpty) {
      print('할 일이 없습니다.');
    } else {

      // 할 일이 있으면
      for (Todo todo in todos) {
        final formattedDate = todo.createdAt.toString();  // 날짜 형식 조정 필요시 수정
        print(
          '${todo.id}. [ ${todo.completed ? '✔' : ' '}] ${todo.title} ($formattedDate)',
        );
      }
      print('번호 / 체크된 완료 상태 / 할 일 제목 / (날짜 형식)');
    }
  }

  // 전체 보기

  Future<void> addTodo() async {
    print(CliTextConstants.enterTitle);
    final String? strCommandTitle = stdin.readLineSync();

    if (isNumber(strCommandTitle) == false) {
      await repository.addTodo(strCommandTitle!);
      await logger.log('할 일 추가됨 - 제목 : \'$strCommandTitle\'');
      print('[할 일 추가됨]');
    } else {
      print(CliTextConstants.invalidInput);
    }
  }

  // 업데이트
  Future<void> updateTodo() async {
    print(CliTextConstants.enterTodoId);
    final String? strCommandId = stdin.readLineSync();

    if (isNumber(strCommandId) ?? false) {
      final int id = int.parse(strCommandId!);
      print(CliTextConstants.enterNewTitle);

      final String? strCommandNewTitle = stdin.readLineSync();
      if (isNumber(strCommandId) == false) {
        await repository.updateTodo(id, strCommandNewTitle!);
        print('[할 일 제목이 수정되었습니다]');
        await logger.log('할 일 제목 수정 - ID: $id, 새로운 제목: $strCommandNewTitle');
      }
    }
  }

  // 완료 상태 토글
  Future<void> toggleTodo() async {
    print('완료 상태를 토글할 할 일 ID를 입력하세요');
    final String? strCommandId = stdin.readLineSync();

    if (isNumber(strCommandId) ?? false) {
      await repository.toggleTodo(int.parse(strCommandId!));
      print('[할 일 완료 상태가 변경되었습니다]');
      await logger.log('할 일 완료 토글 - ID: $strCommandId, 상태: 완료됨');
    }
  }

  Future<void> deleteTodo() async {
    print(CliTextConstants.enterDeleteId);
    final String? strCommandId = stdin.readLineSync();
    if (isNumber(strCommandId) ?? false) {
      await repository.deleteTodo(int.parse(strCommandId!));
      print('[할 일이 삭제되었습니다]');
      await logger.log('할 일 삭제됨 - ID: $strCommandId');
    }
  }

  Future<void> processCommand() async {

    while (true) {
      // 메뉴 출력
      print(CliTextConstants.menuHeader);
      print('1. ${CliTextConstants.showTodos}');
      print('2. ${CliTextConstants.addTodo}');
      print('3. ${CliTextConstants.updateTodo}');
      print('4. ${CliTextConstants.toggleTodo}');
      print('5. ${CliTextConstants.deleteTodo}');
      print('0. ${CliTextConstants.commandExit}');
      print(CliTextConstants.menuFooter);

      // 사용자 입력 받기
      stdout.write(CliTextConstants.promptChoice);

      final choice = stdin.readLineSync();

      if (choice == null || choice.isEmpty) {
        print(CliTextConstants.invalidInput);
        continue;
      }

      switch (choice) {
        case '1':
        // 할 일 목록 보기
          await showTodos();  // 한 번만 호출되도록 처리
          break;
        case '2':
        // 할 일 추가
          await addTodo();
          break;
        case '3':
        // 할 일 수정
          await updateTodo();
          break;
        case '4':
        // 완료 상태 토글
          await toggleTodo();
          break;
        case '5':
        // 할 일 삭제
          await deleteTodo();
          break;
        case '0':
        // 종료
          print(CliTextConstants.programExit);
          break;
        default:
          print(CliTextConstants.invalidInput);
      }
    }
  }

}
