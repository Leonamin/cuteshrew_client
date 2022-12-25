# 프레젠테이션 계층 데이터
프레젠테이션 계층에서 사용할 데이터
## 왜 만들었나?
최대한 뷰모델 역할을 하는 provider에서 클래스가 아닌 int나 String 같이 최대한 기본적인 데이터만 주도록 하려고 했다.  

근데 위젯을 쪼개면서 스크린을 구성하다보니 인자를 여러개 줘야 하는 경우가 생기는데 이럴 때 이름, 내용, 유저 이름 ... 이렇게 인자가 과도하거나 List 형태인데 앞서 말한 것들을 포함해야하는 경우 그냥 class로 묶어서 주는게 편하다.  

그런데 Domain 계층에서 사용하는 Entity를 그대로 위젯까지 가도록 해서 사용하면 Entity의 변경사항 발생시 프레젠테이션 계층 전체를 싹다 고쳐야하는 문제가 있다.  

그래서 영향은 usecase를 사용해서 entity를 받는 상태관리 계층까지만 받게하고(혹은 상태관리 계층과 유즈케이스 사이에도 분리를 하면 좋을것 같긴하다.) 위젯에서 상태관리한테 데이터를 받아올 때 도메인 계층 데이터가 아닌 프레젠테이션 계층 자체의 데이터 모델을 받게 하는게 낫다고 판단했다.  

그러면 Domain 계층에서 변경사항이 생겨도 최소 빌드 에러 같은 부분을 방지하고 부분 디버깅 할 때 문제 되는 부분을 줄이고 아무리 심각해도 데이터 없음이라도 출력되게 만들 수 있을것이다.  (즉 한마디로 테스트 기능 같은거 추가하기가 매우 편해질 것이다!)