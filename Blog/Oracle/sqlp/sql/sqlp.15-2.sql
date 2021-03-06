CREATE TABLE 상품판매내역
(
    판매일자 VARCHAR2(8),
    상품코드 CHAR(1),
    판매수량 NUMBER
);

INSERT INTO 상품판매내역 VALUES ('20141202', 'R', 10);
INSERT INTO 상품판매내역 VALUES ('20141205', 'T', 3);
INSERT INTO 상품판매내역 VALUES ('20141221', 'B', 20);


SELECT DECODE(R, 1,'전체', 2,'냉장고', 3,'가전', 4,'가전외') 상품코드,
       MIN(DECODE(R, 1,냉장고+가전+가전외, 2, 냉장고, 3, 냉장고+가전, 4,가전외)) 판매수량
FROM
(SELECT SUM(CASE WHEN 상품코드 ='R' THEN 판매수량 END) 냉장고,
       SUM(CASE WHEN 상품코드 IN ('T','A') THEN 판매수량 END) 가전,
       SUM(CASE WHEN 상품코드 NOT IN ('R','T','A') THEN 판매수량 END) 가전외
  FROM 상품판매내역
 WHERE 판매일자 BETWEEN '20141201' AND '20141231') A,
(SELECT ROWNUM R FROM DUAL CONNECT BY LEVEL <= 4)
GROUP BY DECODE(R, 1,'전체', 2,'냉장고', 3,'가전', 4,'가전외')
ORDER BY DECODE(R, 1,'전체', 2,'냉장고', 3,'가전', 4,'가전외');