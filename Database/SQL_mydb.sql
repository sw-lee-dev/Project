use mydb;

SELECT * FROM user;
SELECT * FROM board;
SELECT * FROM email_auth;
SELECT * FROM my_page;
SELECT * FROM comment;
SELECT * FROM good;
SELECT * FROM hate;
SELECT * FROM local_festival;

INSERT INTO email_auth VALUES ('hwalbin@dang.com','1234');

INSERT INTO user VALUES (
	'qwer1234','쾌도','qwer1234','hwalbin@dang.com','NORMAL','홍길동',
    '부산광역시 부산진구 중앙대로 666','402호',0,'남','',''
);

INSERT INTO board VALUES (
	1,'qwer1234','쾌도',0,'부산진구의 맛집을 소개해드립니다.','부산진구의 맛집!','부산 부산진구',
    '맛집','2025-04-10',0,1,null,null
);

ALTER TABLE user MODIFY COLUMN detail_address TEXT NULL;