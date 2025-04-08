API 명세서

해당 API 명세서는 '정보 및 커뮤니티 서비스 - 우리 동네 맛집(가칭)'의 REST API를 명세하고 있습니다.

- Domain : http://127.0.0.1:(portNum)

***

MyPage 모듈

우리 동네 맛집 서비스의 회원정보와 관련된 REST API 모듈입니다.
비밀번호 재확인, 게시물 리스트 보기, 내 정보 보기, 내 정보 수정하기 등의 API가 포함되어 있습니다.
MyPage 모듈은 모두 인증 후 요청할 수 있는 모듈입니다.

- url : /......./my-page

***

#### - 비밀번호 재확인

##### 설명

클라이언트는 요청 헤더에 Bearer 인증 토큰을 포함하고 사용자의 비밀번호를 입력하여 요청하고 성공적으로 이루어지면 성공에 대한 응답을 받습니다. 만약 비밀번호가 일치하지 않는다면 비밀번호 불일치에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러, 유효성 검사 실패 에러가 발생할 수 있습니다.

- method : **POST**
- URL : **/password-check**

##### Request

###### Header

| name | description | required |
|---|:---:|:---:|
| Authorization | Bearer 토큰 인증 헤더 | O |

###### Request Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| userPassword | String | 사용자가 회원가입 및 로그인 시 지정한 비밀번호 | O |

###### Example

```bash
curl -v -X POST "http://127.0.0.1:(portNum)/(domain)/my-page/password-check" \
 -h "Authorization=Bearer XXXX" \
 -d "userPassword=qwer1234"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답 결과 코드 | O |
| message | String | 응답 결과 코드에 대한 설명 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK

{
  "code": "SU",
  "message": "Success."
}
```

**응답 : 실패 (데이터 유효성 검사 실패)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "VF",
  "message": "Validation Fail."
}
```

**응답 : 실패 (비밀번호 불일치 에러)**
```bash
HTTP/1.1 400 Bad Reuquest

{
  "code": "PN",
  "message": "Password Not Macthed."
}
```

**응답 : 실패 (데이터베이스 에러)**
```bash
HTTP/1.1 500 Internal Server Error

{
  "code": "DBE",
  "message": "Database Error."
}
```

***

#### - 내 간략 정보와 내가 작성한 게시물 리스트 보기

##### 설명 

클라이언트는 요청 헤더에 Bearer 인증 토큰을 포함하여 요청하고 조회가 성공적으로 이루어지면 성공에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러, 인증 실패가 발생할 수 있습니다.

- method : **GET**
- URL : **/main**

##### Request

###### Header

| name | description | required |
|---|:---:|:---:|
| Authorization | Bearer 토큰 인증 헤더 | O |

###### Example

```bash
curl -v -X GET "http://127.0.0.1:(portNum)/(domain)/my-page/main" \
 -h "Authorization=Bearer XXXX"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답 결과 코드 | O |
| message | String | 응답 결과 코드에 대한 설명 | O |
| userNickname | String | 사용자 닉네임 | O |
| userLevel | String | 사용자 회원 등급 | O |
| boards | Board[] | 게시물 리스트 | O |

###### Board

| name | type | description | required |
|---|:---:|:---:|:---:|
| boardNumber | Integer | 사용자가 작성한 게시글 번호 | O |
| boardImage | String | 게시글 이미지 | O |
| userNickname | String | 게시글 작성자 닉네임 | O |
| userLevel | Integer | 게시글 작성자 회원 등급 | O |
| boardTitle | String | 게시글 제목 | O |
| boardWriteDate | String | 게시글 작성 날짜 | O |
| boardViewCount | Integer | 조회수 | O |
| likesCount | Integer | 좋아요 수 | O |
| commentsCount | Integer | 댓글 수 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK

{
  "code": "SU",
  "message": "Success.",
  "userNickname": "쾌도",
  "userLevel": 1,
  "boards": [
    {
      "boardNumber": 1,
      "boardImage": "https://~",
      "userNickname": "쾌도",
      "userLevel": 1,
      "boardTitle": "부산시 부산진구의 맛집 소개",
      "boardWriteDate": "2025-04-04",
      "boardViewCount": 10,
      "likesCount": 7,
      "commentsCount": 7
    }, ...
  ]
}
```

**응답 : 실패 (인증 실패)**
```bash
HTTP/1.1 401 Unauthorized

{
  "code": "AF",
  "message": "Auth Fail."
}
```

**응답 : 실패 (데이터베이스 에러)**
```bash
HTTP/1.1 500 Internal Server Error

{
  "code": "DBE",
  "message": "Database Error."
}
```

***

#### - 내 정보 확인
  
##### 설명

클라이언트는 요청 헤더에 Bearer 인증 토큰을 포함하여 요청하고 성공적으로 이루어지면 성공에 대한 응답을 받습니다. 네트워크 에러, 서버 에러, 데이터베이스 에러가 발생할 수 있습니다.     

- method : **GET**  
- URL : **/**

##### Request

###### Header

| name | description | required |
|---|:---:|:---:|
| Authorization | Bearer 토큰 인증 헤더 | O |

###### Example

```bash
curl -X GET "http://127.0.0.1:(portNum)/(domain)/my-page" \
 -h "Authorization=Bearer XXXX"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답 결과 코드 | O |
| message | String | 응답 결과 코드에 대한 설명 | O |
| userId | String | 사용자 아이디 | O |
| userNickname | String | 사용자 닉네임 | O |
| name | String | 사용자 이름 | O |
| userPassword | String | 사용자 비밀번호 | O |
| address | String | 사용자 주소 | O |
| detailAddress | String | 사용자 주소 | O |
| gender | String | 사용자 성별 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK

{
  "code": "SU",
  "message": "Success.",
  "userId": "qwer1234",
  "userNickname": "쾌도",
  "name": "홍길동",
  "userPassword": "qwer1234",
  "address": "부산광역시 부산진구 중앙대로 668",
  "detailAddress": "4층 코리아 IT 아카데미",
  "gender": "남"
}
```

**응답 : 실패 (인증 실패)**
```bash
HTTP/1.1 401 Unauthorized

{
  "code": "AF",
  "message": "Auth fail."
}
```

**응답 : 실패 (데이터베이스 에러)**
```bash
HTTP/1.1 500 Internal Server Error

{
  "code": "DBE",
  "message": "Database error."
}
```

***

#### - 사용자 정보 수정  
  
##### 설명

클라이언트는 요청 헤더에 Bearer 인증 토큰을 포함하여 사용자 이름을 입력하여 요청하고 회원가입이 성공적으로 이루어지면 성공에 대한 응답을 받습니다. 네트워크 에러, 서버 에러, 데이터베이스 에러가 발생할 수 있습니다.  

- method : **PATCH**  
- URL : **/**  

##### Request

###### Header

| name | description | required |
|---|:---:|:---:|
| Authorization | Bearer 토큰 인증 헤더 | O |

###### Request Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| userNickname | String | 사용자 닉네임 | O |
| userPassword | String | 사용자 비밀번호 | O |
| address | String | 사용자 주소 | O |
| detailAddress | String | 사용자 주소 | O |

###### Example

```bash
curl -v -X PATCH "http://127.0.0.1:(portNum)/(domain)/my-page" \
 -h "Authorization=Bearer XXXX" \
 -d "userNickname=의적" \
 -d "userPassword=Qwer123$" \
 -d "address=부산광역시 중구" \
 -d "detailAddress=303호"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답 결과 코드 | O |
| message | String | 응답 결과 코드에 대한 설명 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK

{
  "code": "SU",
  "message": "Success."
}
```

**응답 : 실패 (데이터 유효성 검사 실패)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "VF",
  "message": "Validation Fail."
}
```

**응답 : 실패 (인증 실패)**
```bash
HTTP/1.1 401 Unauthorized

{
  "code": "AF",
  "message": "Auth fail."
}
```

**응답 : 실패 (데이터베이스 에러)**
```bash
HTTP/1.1 500 Internal Server Error

{
  "code": "DBE",
  "message": "Database Error."
}
```