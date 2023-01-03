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

## [회고](./log/README.md)