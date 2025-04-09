API 명세서

해당 API 명세서는 '정보 및 커뮤니티 서비스 - 찜뽕'의 REST API를 명세하고 있습니다.

- Domain : http://127.0.0.1:(portNum)

***

Main 모듈

우리 동네 맛집 서비스의 회원정보와 관련된 REST API 모듈입니다.
추천 게시글 리스트 보기, 필터링된 게시글 리스트 최신순 보기, 필터링된 게시글 리스트 조회순 보기, 필터링된 게시글 리스트 좋아요순 보기 등의 API가 포함되어 있습니다.
Main 모듈은 인증 없이 요청할 수 있는 모듈입니다.

- url : /......./main

***

#### - 추천 게시글 리스트 보기

##### 설명

선택한 지역 및 분야 카테고리의 좋아요 수가 높은 순서대로 상위 N개의 게시글에 대한 응답을 받습니다. 서버 에러, 데이터베이스 에러가 발생할 수 있습니다.

- method : **POST**
- URL : **/**

##### Request

###### Request Body

| name | description | required |
|---|:---:|:---:|
| boardDetailCategory | 분야 카테고리 | O |

###### Example

```bash
curl -v -X POST "http://127.0.0.1:(portNum)/(domain)/main" \
  -d "boardDetailCategory=전체"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답 결과 코드 | O |
| message | String | 응답 결과 코드에 대한 설명 | O |
| boardLists | BoardList[] | 추천 게시글 리스트 | O |

##### BoardList

| name | type | description | required |
|---|:---:|:---:|:---:|
| boardImage | String | 게시글 이미지 | O |
| userNickname | String | 게시글 작성자 닉네임 | O |
| userLevel | Integer | 게시글 작성자 회원 등급 | O |
| boardTitle | String | 게시글 제목 | O |
| likesCount | Integer | 좋아요 수 | X |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK

{
  "code": "SU",
  "message": "Success.",
  "boardLists": [
    {
      "boardImage": "https://~~",
      "userNickname": "오리",
      "userLevel": 3,
      "boardTitle": "부산 맥주축제 정보",
      "likesCount": 1000
    },
    {
      "boardImage": "https://~~",
      "userNickname": "이순신",
      "userLevel": 5,
      "boardTitle": "여수 이순신 공원 정보",
      "likesCount": 990
    },
  ]
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

#### - 필터링된 게시글 리스트 보기

##### 설명 

 선택한 지역 및 분야 카테고리의 게시글에 대한 응답을 받습니다. 각 게시글 리스트는 작성 날짜 또는 조회수, 좋아요수에 따라 오름차순 정렬될 수 있습니다. 서버 에러, 데이터베이스 에러가 발생할 수 있습니다.

- method : **POST**
- URL : **/main/filtered**

##### Request

###### Request Body

| name | description | required |
|---|:---:|:---:|
| boardAddressCategory | 지역 카테고리 | O |
| boardDetailCategory | 분야 카테고리 | O |

###### Example

```bash
curl -v -X POST "http://127.0.0.1:(portNum)/(domain)/main/filtered" \
  -d "boardAddressCategory=부산시 부산진구" \
  -d "boardDetailCategory=맛집"
```

##### Response

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 응답 결과 코드 | O |
| message | String | 응답 결과 코드에 대한 설명 | O |
| fileterdBoards | FilteredBoard[] | 선택된 지역 및 분야 카테고리에 따라 필터링된 게시물 리스트 | O |

###### FilteredBoard

###### Example

| name | type | description | required |
|---|:---:|:---:|:---:|
| boardNumber | Integer | 사용자가 작성한 게시글 번호 | O |
| boardImage | String | 게시글 이미지 | O |
| userNickname | String | 게시글 작성자 닉네임 | O |
| userLevel | Integer | 게시글 작성자 회원 등급 | O |
| boardTitle | String | 게시글 제목 | O |
| boardWriteDate | String | 게시글 작성 날짜 | O |
| boardDetailCategory | String | 작성자가 선택한 분야 카테고리 | O |
| boardViewCount | Integer | 조회수 | O |
| likesCount | Integer | 좋아요 수 | O |
| commentsCount | Integer | 댓글 수 | O |

**응답 성공**
```bash
HTTP/1.1 200 OK

{
  "code": "SU",
  "message": "Success.",
  "boards": [
    {
      "boardNumber": 1,
      "boardImage": "https://~",
      "userNickname": "쾌도",
      "userLevel": 1,
      "boardTitle": "부산시 부산진구의 맛집 소개",
      "boardWriteDate": "2025-04-04",
      "boardDetailCategory": "맛집",
      "boardViewCount": 10,
      "likesCount": 7,
      "commentsCount": 7
    }, ...
  ]
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
