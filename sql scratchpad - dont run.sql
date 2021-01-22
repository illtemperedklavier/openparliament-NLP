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

(SELECT hansards_statement.document_id,hansards_statement.time, hansards_statement.h1_en, hansards_statement.h2_en, hansards_statement.member_id, 
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
;