API 명세서

해당 API 명세서는 '정보 및 커뮤니티 서비스 - 찜뽕'의 REST API를 명세하고 있습니다.

- Domain : http://127.0.0.1:(portNum)

// 댓글 작성
// 댓글 리스트 보기
// 좋아요 누르기
// 좋아요 누른 사용자 리스트 보기
// 싫어요 누르기
// 싫어요 누른 사용자 리스트 보기

Board 모듈

***

#### - 댓글 작성

##### 설명

클라이언트는 요청 헤더에 Bearer 인증 토큰을 포함하고 URL에 게시물 번호를, 본문에 댓글 내용을 입력하여 요청하고 댓글 작성이 성공적으로 이루어지면 성공에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러, 인증 실패, 존재하지 않는 게시물, 데이터 유효성 검사 실패가 발생할 수 있습니다.

- method : **POST**
- URL : **/{boardNumber}/comment**

##### Request

###### Header

| name | description | required |
|---|:---:|:---:|
| Authorization | Bearer 토큰 인증 헤더 | O |

###### Path parameter

| name | type | description | required |
|---|:---:|:---:|:---:|
| boardNumber | Integer | 게시글 번호 | O |

###### Request Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| commentContent | String | 댓글 내용 | O |

###### Example

```bash
curl -v -X POST "http://127.0.0.1:(portNum)/(domain)/board/{boardNumber}/comment" \
  -h "Authorization=Bearer XXXX" \
  -d "commentContent=반가워요. 좋은 정보네요!"
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
HTTP/1.1 201 CREATE

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

**응답 : 실패 (존재하지 않는 게시글)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "NB",
  "message": "No Exist Board."
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

***

#### - 댓글 리스트 보기

##### 설명

클라이언트는 URL에 게시물 번호를 요청하여 조회가 성공적으로 이루어지면 성공에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러, 존재하지 않는 게시물, 데이터 유효성 검사 실패가 발생할 수 있습니다.

- method : **GET**
- URL : **/{boardNumber}/comment**

##### Request

###### Path parameter

| name | type | description | required |
|---|:---:|:---:|:---:|
| boardNumber | Integer | 게시글 번호 | O |

###### Example

```bash
curl -v -X GET "http://127.0.0.1:(portNum)/(domain)/board/{boardNumber}/comment"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답 결과 코드 | O |
| message | String | 응답 결과 코드에 대한 설명 | O |
| comments | Comment[] | 해당 게시물에 작성된 댓글 리스트 | O |

###### Comment

| name | type | description | required |
|---|:---:|:---:|:---:|
| commentNumber | Integer | 댓글 번호 | O |
| commentContent | String | 댓글 내용 | O |
| userId | String | 댓글 작성자 아이디 | O |
| userLevel | Integer | 댓글 작성자 회원 등급 | O |
| userNickname | String | 댓글 작성자 닉네임 | O |
| writeDate | String | 댓글 작성 날짜 | O |
| boardNumber | Integer | 해당 댓글을 작성한 게시글 번호 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK

{
  "code": "SU",
  "message": "Success.",
  "comments": [
    {
      "commentNumber": 1,
      "commentContent": "반가워요. 좋은 정보네요!",
      "userId": "asdf123",
      "userLevel": 2,
      "userNickname": "이순신",
      "writeDate": "2025-04-07",
      "boardNumber": 1
    }
  ]
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

**응답 : 실패 (존재하지 않는 게시글)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "NB",
  "message": "No Exist Board."
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

#### - 좋아요 누르기

##### 설명

클라이언트는 요청 헤더에 Bearer 인증 토큰을 포함하고 URL에 게시물 번호를 입력하여 요청하고 작업이 성공적으로 이루어지면 성공에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러, 인증 실패, 존재하지 않는 게시물이 발생할 수 있습니다.

- method : **PUT**
- URL : **/{boardNumber}/like**

##### Request

###### Header

| name | description | required |
|---|:---:|:---:|
| Authorization | Bearer 토큰 인증 헤더 | O |

###### Path parameter

| name | type | description | required |
|---|:---:|:---:|:---:|
| boardNumber | Integer | 게시글 번호 | O |

###### Example

```bash
curl -v -X PUT "http://127.0.0.1:(portNum)/(domain)/board/{boardNumber}/like" \
  -h "Authorization=Bearer XXXX"
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

**응답 : 실패 (존재하지 않는 게시글)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "NB",
  "message": "No Exist Board."
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

***

#### - 좋아요 누른 사용자 리스트 보기

##### 설명

클라이언트는 URL에 게시물 번호를 입력하여 요청하고 조회가 성공적으로 이루어지면 성공에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러, 존재하지 않는 게시물이 발생할 수 있습니다.

- method : **GET**
- URL : **/{boardNumber}/like**

##### Request

###### Path parameter

| name | type | description | required |
|---|:---:|:---:|:---:|
| boardNumber | Integer | 게시글 번호 | O |

###### Example

```bash
curl -v -X GET "http://127.0.0.1:(portNum)/(domain)/board/{boardNumber}/like"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답 결과 코드 | O |
| message | String | 응답 결과 코드에 대한 설명 | O |
| likes | Like[] | 해당 게시글의 좋아요 사용자 리스트 | O |

###### Like

| name | type | description | required |
|---|:---:|:---:|:---:|
| userId | String | 좋아요한 사용자 아이디 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK

{
  "code": "SU",
  "message": "Success.",
  "likes": [
      "asdf123"
      , ...
  ]
}
```

**응답 : 실패 (존재하지 않는 게시글)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "NB",
  "message": "No Exist Board."
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

#### - 싫어요 누르기

##### 설명

클라이언트는 요청 헤더에 Bearer 인증 토큰을 포함하고 URL에 게시물 번호를 입력하여 요청하고 작업이 성공적으로 이루어지면 성공에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러, 인증 실패, 존재하지 않는 게시물이 발생할 수 있습니다.

- method : **PUT**
- URL : **/{boardNumber}/hate**

##### Request

###### Header

| name | description | required |
|---|:---:|:---:|
| Authorization | Bearer 토큰 인증 헤더 | O |

###### Path parameter

| name | type | description | required |
|---|:---:|:---:|:---:|
| boardNumber | Integer | 게시글 번호 | O |

###### Example

```bash
curl -v -X PUT "http://127.0.0.1:(portNum)/(domain)/board/{boardNumber}/hate" \
  -h "Authorization=Bearer XXXX" \
  -d "userId=zxcv123"
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

**응답 : 실패 (존재하지 않는 게시글)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "NB",
  "message": "No Exist Board."
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

***

#### - 싫어요 누른 사용자 리스트 보기

##### 설명

클라이언트는 URL에 게시물 번호를 입력하여 요청하고 조회가 성공적으로 이루어지면 성공에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러, 존재하지 않는 게시물이 발생할 수 있습니다.

- method : **GET**
- URL : **/{boardNumber}/hate**

##### Request

###### Path parameter

| name | type | description | required |
|---|:---:|:---:|:---:|
| boardNumber | Integer | 게시글 번호 | O |

###### Example

```bash
curl -v -X GET "http://127.0.0.1:(portNum)/(domain)/board/{boardNumber}/hate"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답 결과 코드 | O |
| message | String | 응답 결과 코드에 대한 설명 | O |
| hates | Hate[] | 해당 게시글의 싫어요 사용자 리스트 | O |

###### Hate

| name | type | description | required |
|---|:---:|:---:|:---:|
| userId | String | 싫어요한 사용자 아이디 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK

{
  "code": "SU",
  "message": "Success.",
  "hates": [
    "zxcv123"
    , ...
  ]
}
```

**응답 : 실패 (존재하지 않는 게시글)**
```bash
HTTP/1.1 400 Bad Request

{
  "code": "NB",
  "message": "No Exist Board."
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
