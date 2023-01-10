# 소개
귀여운땃쥐 커뮤니티 웹앱&AOS/IOS앱 프로젝트

## 빌드
### AOS
### IOS
### WEB
`enhanced_html_editor` 패키지 떄문에 `flutter build web --web-renderer html`로 빌드해야한다.

## 구조
```
├─config
│  ├─routing
│  └─url
├─constants
├─core
│  ├─data
│  │  ├─datasource
│  │  │  ├─local
│  │  │  └─remote
│  │  ├─dto
│  │  ├─mapper
│  │  └─repository
│  ├─domain
│  │  ├─entity
│  │  ├─repository
│  │  └─usecase
│  └─resources
├─di
└─presentation
    ├─data
    ├─helpers
    ├─mappers
    ├─providers
    │  └─authentication
    ├─screens
    │  ├─auth
    │  ├─comment
    │  │  ├─providers
    │  │  └─widgets
    │  ├─comment_editor
    │  │  └─provider
    │  ├─community
    │  │  └─providers
    │  ├─home
    │  │  ├─page
    │  │  ├─provider
    │  │  └─widgets
    │  ├─notfound
    │  ├─posting
    │  │  ├─posting_screen
    │  │  ├─providers
    │  │  └─widgets
    │  ├─posting_editor
    │  │  └─providers
    │  ├─register
    │  │  └─providers
    │  └─user
    │      ├─provders
    │      └─widget
    ├─strings
    ├─utils
    └─widgets
        ├─common_widgets
        └─main_app_bar
```
### config
플러터에서 도메인, 데이터, 프레젠테이션으로 나누기 어려운 기본 설정들
### core(domain)
앱의 실제 데이터(entity), 업무 규칙(usecase), 리포지토리 추상화(repository)
### core(data)
로컬/리모트 데이터 입출력(datasource), 데이터 저장소 데이터 구조(dto), 저장소 데이터와 실제 데이터 변환(mapper), 리포지토리 구체(repository)
### presentation
프레젠테이션에서 사용할 데이터 구조(data), 프레젠테이션 데이터와 실제 데이터 변환(mapper), 전역 프로바이더(providers), 전역 메소드 (utils), 공통 위젯(widgets)
#### screens
각 화면당 해당 화면에 사용할 프로바이더(provider), 해당 화면에 사용할 위젯(widget)

## 업데이트 내역
### 1.0.1
추가 기능
- 유저페이지에서 유저 정보 가져오기 기능 추가
디버그
- 커뮤니티에서 정보를 불러올 때 모든 게시글 개수를 가져오도록 수정
### 1.0.1+2 핫픽스
디버그
- 작은 화면에서 아무동작도 안되는 문제 수정
- 게시글 작성 페이지 개선
### 1.0.2
디버그
- 게시글 작성 후 되돌아오면 변경 사항 가져오게 수정
- 게시글 작성 페이지 안보이는 문제 수정
- 유저 페이지에서 유저 정보와 게시글 정보, 댓글 정보를 별도 관리해서 문제 발생 시 발생한 정보 제외하고 출력하도록 수정
- 비밀번호가 걸린 게시글 페이지 가져오지 못한 문제 수정
### 1.0.3
디버그
- 유저 페이지에서 게시글 페이지로 이동 못하는 문제 수정
기타
- 유저 페이지 위젯 분리 개선

### 1.0.4
추가 기능
- 게시글 화면 삭제 확인 다이얼로그
- 링크 기능
- 게시글 드래그 가능(하지만 1줄씩밖에 안됨)

### 1.0.5
기타
- 서버 신규 API에 맞게 조정

디버그
- 게시글에서 원래 커뮤니티로 돌아가기 버그 수정
- 커뮤니티에서 게시글 작성 페이지로 갔을 때 해당 커뮤니티로 초기 설정이 안되는 문제 수정
- 커뮤니티 선택을 해도 마지막에 선택이 해제되는 문제 수정

## [회고](./log/README.md)