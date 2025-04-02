## 📌 Dart CLI Todo List App 1팀
**Dart CLI Todo App - 기능 구현 및 테스트 완료**

---

## ✅ 개요  
간단한 CLI 기반 할 일 관리 프로그램을 Dart로 구현했습니다.  
사용자 입력을 통해 할 일을 추가/수정/삭제/토글할 수 있으며, 앱 종료 후에도 데이터가 유지되도록 파일 기반 저장 기능을 구현했습니다.

---

## 👨‍👩‍👧‍👦 참여자  
- 최준성  : Model 및 단위 테스트 구현
- 이윤서  : Data Source 및 단위 테스트 구현
- 유제환  : Repository 및 단위 테스트 구현
- 강지원  : CLI, Log, main 구현
---

## 🔨 구현한 기능

| 기능 | 상태 |
|------|------|
| 할 일 추가/수정/삭제 | ✅ |
| 완료 상태 토글 | ✅ |
| 할 일 목록 보기 | ✅ |
| 완료/미완료 필터링 | ✅ |
| 생성일 기준 정렬 (오름차순/내림차순) | ✅ |
| 앱 시작 시 파일 불러오기 | ✅ |
| 앱 종료 시 자동 저장 | ✅ |
| 로그 기록 (log.txt) | ✅ |
| ID 자동 증가 | ✅ |

---

## 🧱 구조

- `Todo` 모델 클래스 (JSON 직렬화, 동등성 비교, `copyWith` 포함)
- `TodoDataSource`: 파일 입출력 담당
- `TodoRepository`: 비즈니스 로직 관리
- `main.dart`: CLI UI 처리
![img](https://raw.githubusercontent.com/doggodking/modu-3-dart-todo-app/refs/heads/master/docs/todo_app_plat_uml.png)
---

## 🧪 테스트

**단위 테스트 및 통합 테스트 모두 작성 완료했습니다.**

- `Todo` 모델의 직렬화/역직렬화 테스트
- `TodoRepository`의 모든 주요 기능 테스트  
  - 할 일 추가 시 ID 자동 증가 확인  
  - 수정/삭제/토글 동작 확인  
  - 예외 상황 처리 확인
- `TodoDataSource`의 파일 입출력 정상 동작 테스트  
- 테스트 파일은 `test/` 디렉토리에 위치

> 특히 `todos.json`과 `log.txt` 파일이 잘 저장되고 불러와지는지를 집중적으로 검증했습니다.

---

## 💾 실행 예시

![img](https://raw.githubusercontent.com/doggodking/modu-3-dart-todo-app/refs/heads/master/docs/capture_menu.png)
![img](https://raw.githubusercontent.com/doggodking/modu-3-dart-todo-app/refs/heads/master/docs/capture_list.png)

- `todos.json`은 앱 시작 시 자동 생성되며, 없을 경우 `backup.dat`를 참고합니다.
- 로그는 `logs/log.txt`에 자동 기록됩니다.
![img](https://raw.githubusercontent.com/doggodking/modu-3-dart-todo-app/refs/heads/master/docs/capture_logt.png)

---

## 📝 기타
- FigJam으로 함께 설계 하였습니다.
- 팀원들이 각 역할 실시간으로 코드 구현을 이어가는 방식으로 개발했습니다.
- 이후 각자 단위 테스트를 통해 자신의 영역에서 버그를 수정하는데 집중하였습니다.
- 각 기능 구현 시 철저한 역할 분담 및 코드 리뷰를 통해 구조의 일관성을 유지했습니다.
- 모델과 비즈니스 로직을 분리하여 유지보수성과 확장성을 고려했습니다.

---

## 🛠 개선할 점

### 1. **콘솔 입력에 대한 한글 인코딩 처리**
- 일부 환경(특히 Windows cmd 등)에서 한글이 깨져 출력되거나 입력이 정상 처리되지 않는 현상이 있음  

---
