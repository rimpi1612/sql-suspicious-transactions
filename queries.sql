---loading data for card holder 2 and 18 from the database ---
SELECT 
ch.holder_id as cardholder,
t.transaction_datetime as hour,
t.amount as amount 
from transaction t 
join credit_card cc on cc.card_number = t.card_number
join card_holder ch on ch.holder_id = cc.cardholder_id 
where ch.holder_id in (2,18);

-- loading data of daily transactions from jan to jun 2018 for card holder 25 --
SELECT 
date_part('month', t.transaction_datetime) as month, 
date_part('day', t.transaction_datetime) as day, 
t.amount as amount 
FROM transaction t 
JOIN credit_card AS c ON c.card_number = t.card_number 
WHERE c.cardholder_id = 25 
AND date_part('month', t.transaction_datetime) >= 1 
AND date_part('month', t.transaction_datetime) <= 6;

---the general query for the outlier tracking ---

SELECT 
ch.holder_id as cardholder,
cc.card_number number,
m.merchant_name as merchant,
t.transaction_datetime as hour,
t.amount as amount 
FROM card_holder ch
JOIN credit_card cc ON ch.holder_id = cc.cardholder_id
JOIN transaction t ON t.card_number = cc.card_number 
JOIN merchant m ON t.merchant_id = m.merchant_id
JOIN merchant_category mc ON m.merchant_category_id = m.merchant_category_id
group by cc.card_number, ch.holder_id, m.merchant_name,t.transaction_datetime,t.amount
order by t.amount;