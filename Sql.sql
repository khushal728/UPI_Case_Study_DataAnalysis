CREATE TABLE transactions (
  transaction_id TEXT PRIMARY KEY,
  timestamp TIMESTAMPTZ,
  transaction_type TEXT,
  merchant_category TEXT,
  amount_inr NUMERIC,
  transaction_status TEXT,
  sender_age_group TEXT,
  receiver_age_group TEXT,
  sender_state TEXT,
  sender_bank TEXT,
  receiver_bank TEXT,
  device_type TEXT,
  network_type TEXT,
  fraud_flag BOOLEAN,
  hour_of_day SMALLINT,
  day_of_week TEXT,
  is_weekend BOOLEAN
);

SELECT COUNT(*) FROM transactions;
SELECT * FROM transactions LIMIT 10;

CREATE INDEX idx_timestamp ON transactions (timestamp);
CREATE INDEX idx_state ON transactions (sender_state);
CREATE INDEX idx_fraud ON transactions (fraud_flag);
CREATE INDEX idx_merchant ON transactions (merchant_category);

CREATE VIEW v_daily_kpis AS
SELECT 
    date_trunc('day', timestamp) AS day,
    COUNT(*) AS tx_count,
    SUM(amount_inr) AS total_value,
    AVG(amount_inr) AS avg_amount
FROM transactions
GROUP BY 1
ORDER BY 1;


