SELECT hansards2votequestion_id.statement_id, time AS statement_time, 
hansards2votequestion_id.h1_en, hansards2votequestion_id.h2_en, hansards2votequestion_id.member_id, hansards2votequestion_id.speaking_pid, 
hansards2votequestion_id.bill_id, hansards2votequestion_id.nay_total, hansards2votequestion_id.yea_total, 
hansards2votequestion_id.result, hansards2votequestion_id.votequestion_id, date
FROM hansards2votequestion_id

INNER JOIN(
max(date), statement_id
	FROM hansards2votequestion_id
	GROUP BY date
	
) b 
ON hansards2votequestion_id.statement_id = b.statement_id
AND hansards2votequestion_id.date = b.date

LIMIT 100; 

SELECT A.time, A.content_en, A.speaking_pid,A.bill_id,  A.h1_en, A.h2_en, A.date as speech_date, 
B.result, B.date, B.votequestion_id, B.yea_total, B.nay_total
FROM hansards2votequestion_id AS A
INNER JOIN hansards2votequestion_id AS B ON
A.statement_id = B.statement_id 
LIMIT 4; 

SELECT A.time, A.content_en, A.speaking_pid,A.bill_id,  A.h1_en, A.h2_en, A.date as speech_date, 
B.result, B.date, B.votequestion_id, B.yea_total, B.nay_total
FROM hansards2votequestion_id AS A
INNER JOIN hansards2votequestion_id AS B ON
A.statement_id = B.statement_id 
WHERE B.date>A.time; 

COPY (
	SELECT A.statement_id, 
	B.result
	FROM hansards2votequestion_id AS A
	INNER JOIN hansards2votequestion_id AS B ON
	A.statement_id = B.statement_id 
	WHERE B.date>A.time

)

TO 'D:\data\openparliament\statement_id2result.csv' DELIMITER ',' CSV HEADER

; 

SELECT * FROM bills_partyvote
RIGHT JOIN hansards2votequestion_id
ON bills_partyvote.votequestion_id = hansards2votequestion_id.votequestion_id
LIMIT 10
;              