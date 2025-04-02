# 팀1 중간 점검

## 📄 요구사항 명세서: Dart CLI Todo List App

### 🧾 프로젝트 개요

간단한 할 일 관리 CLI 애플리케이션을 Dart로 개발합니다. 사용자는 명령어를 통해 할 일을 추가, 수정, 삭제, 완료 체크할 수 있어야 하며, 앱 종료 후에도 데이터가 유지되도록 **파일 저장 및 불러오기 기능**을 포함해야 합니다.

---

### 🎯 목표

- 파일 기반 데이터 저장
- JSON 직렬화 및 역직렬화
- Model - Repository - DataSource 구조 적용
- 동등성 비교, copyWith 기능 활용
- 사용자 CLI 입력 기반 기능 제공

---

### 📂 기능 요구사항

### ✅ 기본 기능

| 기능 | 설명 |
| --- | --- |
| 목록 보기 | 모든 할 일을 화면에 출력 |
| 할 일 추가 | 사용자로부터 제목을 입력받아 추가 |
| 할 일 수정 | ID를 지정해 제목 수정 |
| 완료 상태 토글 | ID를 지정해 완료 여부를 토글 |
| 할 일 삭제 | ID를 지정해 삭제 |
| 프로그램 종료 | 앱 종료 전 자동 저장 수행 |
| 날짜 오름차순/내림차순 보기 | `createdAt` 날짜순으로 정렬하기 |
| 완료/미완료 보기 | 완료된 할 일만/미완료만 필터해서 보기 |
| id 자동 증가 | 각 할 일의 `id`는 자동 증가하도록 구현 |
| 로그 파일 저장 | 사용자가 어떤 작업을 했는지 기록 |

---

### 🧱 시스템 구성요소

### 1. **Model: `Todo`**

- 속성:
    - `int userId`
    - `int id`
    - `String title`
    - `bool completed`
    - `DateTime createdAt`
- 메서드:
    - `fromJson(Map<String, dynamic>)`
    - `toJson()`
    - `copyWith()`
    - 동등성 비교 (`==`, `hashCode`)

### 2. **Data Source: `TodoDataSource`**

- 역할: 파일 입출력 담당 (로우 레벨)
- 메서드:
    - `Future<List<Map<String, dynamic>>> readTodos()`
    - `Future<void> writeTodos(List<Map<String, dynamic>> todos)`
- 파일이 없을 경우 자동 생성
- 파일 경로: `/data/todos.json` (또는 상대 경로 지정)

### 3. **Repository: `TodoRepository`**

- 역할: 비즈니스 로직 처리 및 모델 관리
- 내부에서 `TodoDataSource` 사용
- 메서드 예시:
    - `Future<List<Todo>> getTodos()`
    - `Future<void> addTodo(String title)`
    - `Future<void> updateTodo(int id, String newTitle)`
    - `Future<void> toggleTodo(int id)`
    - `Future<void> deleteTodo(int id)`

### 4. **CLI UI: `main.dart`**

- 메뉴 출력 및 사용자 입력 처리
- 반복문으로 메뉴 반복
- 예시 메뉴:

    ```
    1. 목록 보기
    2. 할 일 추가
    3. 할 일 수정
    4. 완료 상태 토글
    5. 할 일 삭제
    0. 종료
    
    ```


---

### 💾 저장 방식

- 모든 Todo 데이터는 JSON 형식으로 파일에 저장
- 앱 시작 시 해당 파일을 불러와 초기화
    - 읽어온 파일에 데이터가 없으면 backup.dat 을 읽어서 copy 후 사용
    - backup.dat 내용은 다음과 같다

```bash
[
  {
    "userId": 1,
    "id": 1,
    "title": "생존코딩 유튜브 구독하기",
    "completed": false
  },
  {
    "userId": 1,
    "id": 2,
    "title": "PR 제출하기",
    "completed": false
  },
  {
    "userId": 1,
    "id": 3,
    "title": "다른 사람 코드 리뷰하기",
    "completed": false
  },
  {
    "userId": 1,
    "id": 4,
    "title": "TIL 정리하기",
    "completed": true
  },
  {
    "userId": 1,
    "id": 5,
    "title": "인프런 강의 시청",
    "completed": false
  }
]
```

- 앱 종료 시 혹은 변경 후 자동 저장

---

### 🔁 데이터 예시 (todos.json)

```json
[
  {
    "userId": 10,
    "id": 181,
    "title": "청소",
    "completed": false
  },
  {
    "userId": 10,
    "id": 182,
    "title": "빨래",
    "completed": true
  }
]

```

---

### ✅ 기술 요구사항 체크리스트

| 항목 | 설명 | 필수 여부 |
| --- | --- | --- |
| 모델 클래스 생성 | `Todo` 클래스 정의 | ✔️ |
| JSON 직렬화/역직렬화 | `toJson()`, `fromJson()` 구현 | ✔️ |
| 동등성 비교 | `==`, `hashCode` 재정의 | ✔️ |
| `copyWith()` | 상태 변경 시 사용 | ✔️ |
| Repository, DataSource 구조 분리 | 책임 분리 | ✔️ |
| CLI 입력 처리 | 메뉴 출력 및 선택 처리 | ✔️ |
| 파일 저장/불러오기 | JSON 파일 입출력 | ✔️ |

---

### 🧠 팀 활동 가이드

- 팀장을 뽑습니다.
- 팀장은  ‣https://github.com/SurvivalCodingCampus/modu-3-dart-todo-app 를 fork 합니다.
- 팀원은 팀장이 fork 한 Repository 를 clone 합니다.
- 팀장은 팀원을 Repository 에 collaborator로 추가한다.
- 모든 클래스와 기능은 **각 팀이 설계 방향을 토의하여 결정**합니다.
- 역할 분담을 통해 각자 구현한 후 통합하는 방식도 가능
- **요구사항을 만족하면서도 깔끔한 구조를 고민**해보세요.
- 코드 리뷰를 통해 서로의 코드를 점검하고 개선해보세요.

### 🧠 그라운드 룰

- 팀은 5분씩 돌아가며 파일럿을 교체하며 코딩을 합니다.
- 팀장은 매 사이클마다 5분 타이머를 켭니다.
- 5분이 울리면 바로 commit, push 하고, 다음 사람이 pull 하고 이어 받아 코딩합니다.
- 매 시 50분부터 15분간 휴식합니다.

---

### 📄 로그 파일 예시 (`log.txt`)

```
[2025-03-31 09:10:23] 앱 시작됨.
[2025-03-31 09:10:25] 할 일 추가됨 - ID: 1, 제목: 'Buy milk'
[2025-03-31 09:10:32] 할 일 추가됨 - ID: 2, 제목: 'Finish homework'
[2025-03-31 09:11:05] 할 일 완료 토글 - ID: 1, 상태: 완료됨
[2025-03-31 09:12:14] 할 일 제목 수정 - ID: 2, 새로운 제목: 'Finish Dart homework'
[2025-03-31 09:13:02] 할 일 삭제됨 - ID: 1
[2025-03-31 09:13:45] 앱 종료됨.
```

---

## 🛠 로그 작성 팁

- 로그 저장은 logs/`log.txt`에 **덧붙이기 모드(append)** 로 기록
- 추천하는 액션 종류:
    - `앱 시작됨`
    - `앱 종료됨`
    - `할 일 추가됨`
    - `할 일 제목 수정`
    - `할 일 완료 토글`
    - `할 일 삭제됨`
    - `에러 발생: ...`

---

## 💻 CLI 동작 예시

```bash
=== TODO LIST 프로그램 ===
1. 목록 보기
2. 할 일 추가
3. 할 일 수정
4. 완료 상태 토글
5. 할 일 삭제
0. 종료
--------------------------
선택하세요: 2
할 일 제목을 입력하세요: Buy milk
[할 일 추가됨]

=== TODO LIST 프로그램 ===
1. 목록 보기
2. 할 일 추가
3. 할 일 수정
4. 완료 상태 토글
5. 할 일 삭제
0. 종료
--------------------------
선택하세요: 2
할 일 제목을 입력하세요: Finish Dart assignment
[할 일 추가됨]

=== TODO LIST 프로그램 ===
1. 목록 보기
2. 할 일 추가
3. 할 일 수정
4. 완료 상태 토글
5. 할 일 삭제
0. 종료
--------------------------
선택하세요: 1
[할 일 목록]
1. [ ] Buy milk (2025-03-31 09:10)
2. [ ] Finish Dart assignment (2025-03-31 09:12)

=== TODO LIST 프로그램 ===
선택하세요: 4
완료 상태를 토글할 할 일 ID를 입력하세요: 1
[할 일 완료 상태가 변경되었습니다]

=== TODO LIST 프로그램 ===
선택하세요: 1
[할 일 목록]
1. [✔] Buy milk (2025-03-31 09:10)
2. [ ] Finish Dart assignment (2025-03-31 09:12)

=== TODO LIST 프로그램 ===
선택하세요: 3
수정할 할 일 ID를 입력하세요: 2
새 제목을 입력하세요: Finish Dart CLI assignment
[할 일 제목이 수정되었습니다]

=== TODO LIST 프로그램 ===
선택하세요: 5
삭제할 할 일 ID를 입력하세요: 1
[할 일이 삭제되었습니다]

=== TODO LIST 프로그램 ===
선택하세요: 1
[할 일 목록]
2. [ ] Finish Dart CLI assignment (2025-03-31 09:12)

=== TODO LIST 프로그램 ===
선택하세요: 0
[프로그램을 종료합니다. 데이터가 저장되었습니다.]

```

---

## ✅ 단일 입력 받기 예시

```dart
import 'dart:io';

void main() {
  print('이름을 입력하세요:');
  String? name = stdin.readLineSync(); // 사용자 입력 받기 (null 가능성 있음)

  if (name != null && name.isNotEmpty) {
    print('안녕하세요, $name님!');
  } else {
    print('입력이 없습니다.');
  }
}

```

---

## 🧾 프로젝트 결과물

- PlantUML
- 소스코드
- test 코드

