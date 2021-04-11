CREATE TABLE bills_mostrecent
AS

(SELECT id,name_en, sponsor_member_id,privatemember,sponsor_politician_id,law, MAX(status_date),introduced,status_code 
FROM bills_bill GROUP BY id);



SELECT hansards_statement.document_id,hansards_statement.time, hansards_statement.h1_en, hansards_statement.h2_en, hansards_statement.member_id, 
hansards_statement.content_en, hansards_statement.sequence_en, 
hansards_statement_bills.bill_id
FROM hansards_statement
INNER JOIN hansards_statement_bills
ON hansards_statement.id = hansards_statement_bills.statement_id
LIMIT 100;

CREATE TABLE statements_with_billid 
AS



CREATE TABLE hansards_with_bill
AS

(SELECT hansards_statement.document_id, hansards_statement.id AS statement_id,hansards_statement.time, hansards_statement.h1_en, hansards_statement.h2_en, hansards_statement.member_id, 
hansards_statement.content_en, hansards_statement.sequence_en, hansards_statement.politician_id,
hansards_statement_bills.bill_id
FROM hansards_statement
INNER JOIN hansards_statement_bills
ON hansards_statement.id = hansards_statement_bills.statement_id
WHERE hansards_statement.time > '2000-01-01 15:00:00-05')
;


SELECT * FROM bills_mostrecent
LEFT OUTER JOIN bills_votequestion
ON bills_mostrecent.id = bills_votequestion.bill_id
WHERE bills_votequestion.result IS NOT null
;

CREATE TABLE billid2politician_id
AS
(SELECT * FROM bills_votequestion
LEFT OUTER JOIN bills_membervote
ON bills_votequestion.id = bills_membervote.votequestion_id)



/* 
hansards_with_bill bills_votequestion
[join on bills_votequestion.context_statement_id = hansards_with_bill.statement_id ] that was a thought, but context_statement_id seems to not refer to that



arranging the data so it's 
bill_id statement_id votequestion_id politician_id politician_vote yea_total nay_total  


*/

/* joining hansards to bill_id to vote summaries 
*/

SELECT hansards_with_bill.document_id, hansards_with_bill.statement_id, hansards_with_bill.time, hansards_with_bill.h1_en, 
hansards_with_bill.h2_en, hansards_with_bill.member_id, hansards_with_bill.content_en, hansards_with_bill.sequence_en,
hansards_with_bill.politician_id, hansards_with_bill.bill_id, 
bills_votequestion.description_en, bills_votequestion.nay_total, bills_votequestion.number, bills_votequestion.session_id, 
bills_votequestion.result, bills_votequestion.date, bills_votequestion.id, bills_votequestion.yea_total, 
bills_votequestion.bill_id AS vote_bill_id

FROM hansards_with_bill
INNER JOIN bills_votequestion
ON hansards_with_bill.bill_id = bills_votequestion.bill_id
WHERE hansards_with_bill.time < bills_votequestion.date
;

/* statements to votequestion_id */


COPY (SELECT hansards_with_bill.document_id, hansards_with_bill.statement_id, hansards_with_bill.time, hansards_with_bill.h1_en, 
hansards_with_bill.h2_en, hansards_with_bill.member_id, hansards_with_bill.content_en, hansards_with_bill.sequence_en,
hansards_with_bill.politician_id, hansards_with_bill.bill_id, 
bills_votequestion.nay_total,
bills_votequestion.result, bills_votequestion.date, bills_votequestion.id AS votequestion_id, bills_votequestion.yea_total, 
bills_votequestion.bill_id

FROM hansards_with_bill
INNER JOIN bills_votequestion
ON hansards_with_bill.bill_id = bills_votequestion.bill_id
WHERE hansards_with_bill.time < bills_votequestion.date 
AND hansards_with_bill.time > '2000-01-01 15:00:00-05') 
TO 'D:\data\openparliament\hansards2votequestion.csv' DELIMITER ',' CSV HEADER
;


SELECT hansards_with_bill.document_id, hansards_with_bill.statement_id, hansards_with_bill.time, hansards_with_bill.h1_en, 
hansards_with_bill.h2_en, hansards_with_bill.member_id, hansards_with_bill.content_en, hansards_with_bill.sequence_en,
hansards_with_bill.politician_id, hansards_with_bill.bill_id,
bills_partyvote.disagreement
FROM hansards_with_bill
INNER JOIN bills_partyvote

ON hansards_with_bill.bill_id = bills_votequestion.bill_id
WHERE hansards_with_bill.time < bills_votequestion.date 
AND hansards_with_bill.time > '2000-01-01 15:00:00-05') 
TO 'D:\data\openparliament\hansards2votequestion.csv' DELIMITER ',' CSV HEADER
;



;