/*
[2025-03-31 09:10:23] 앱 시작됨.
[2025-03-31 09:10:25] 할 일 추가됨 - ID: 1, 제목: 'Buy milk'
[2025-03-31 09:10:32] 할 일 추가됨 - ID: 2, 제목: 'Finish homework'
[2025-03-31 09:11:05] 할 일 완료 토글 - ID: 1, 상태: 완료됨
[2025-03-31 09:12:14] 할 일 제목 수정 - ID: 2, 새로운 제목: 'Finish Dart homework'
[2025-03-31 09:13:02] 할 일 삭제됨 - ID: 1
[2025-03-31 09:13:45] 앱 종료됨.
 */


import 'dart:io';

class AppLog {
  final String filePath;

  AppLog({this.filePath = 'logs/log.txt'});

  Future<void> log(String message) async {
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '[$timestamp] $message\n';

    final file = File(filePath);

    // 파일 경로가 없으면 자동으로 생성
    if (!await file.exists()) {
      await file.create(recursive: true);  // 경로가 없다면 폴더 포함하여 생성
    }


    await file.writeAsString(logMessage, mode: FileMode.append);
  }
}