# 📊 UPI Transaction Analytics & Risk Detection Dashboard

An **end-to-end data analytics and machine learning project** focused on analyzing large-scale UPI transactions, identifying usage patterns, and detecting risky transactions using ML — with final insights delivered through interactive **Power BI dashboards**.

---

## 🚀 Project Overview

This project analyzes **250,000+ UPI transactions worth ₹300M+** to understand:
- Transaction behavior across users, banks, devices, and merchant categories
- System performance (success vs failure)
- Financial value distribution
- Risky and anomalous transaction patterns using Machine Learning

The solution combines **SQL + Python (ML) + Power BI** to deliver **business-ready insights** and **risk monitoring dashboards**.

---

## 🧠 Why This Project?

UPI is one of the most critical payment systems in India, processing millions of transactions daily.  
This project was built to simulate a **real-world fintech analytics & risk monitoring system**, answering questions like:

- Where do most UPI transactions originate?
- Which banks and categories drive the highest value?
- When do failures occur most often?
- Can we proactively detect risky transactions using ML?

---

## 🏗️ Architecture & Workflow

```
PostgreSQL (Raw Data)
↓
SQL (Data Cleaning & Aggregation)
↓
Python (EDA + Feature Engineering + ML)
↓
Power BI (Dashboards + Risk Monitoring)

```


---

## 🗄️ Database & SQL (PostgreSQL)

### Table Creation

```sql
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
```

## 🐍 Python & Machine Learning

- Key Tasks Performed

- Data validation & cleaning

- Feature engineering (hour of day, day of week)

- Anomaly detection using Isolation Forest

- ML output generation for Power BI integration

- ML Code Snippet (Isolation Forest)

### ML Code Snippet (Isolation Forest)
```py
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import IsolationForest
from sklearn.pipeline import Pipeline

features = ["amount_inr", "hour_of_day", "day_of_week"]
X = df[features]

pipeline = Pipeline([
    ("scaler", StandardScaler()),
    ("model", IsolationForest(
        n_estimators=200,
        contamination=0.03,
        random_state=42
    ))
])

pipeline.fit(X)

df["risk_flag"] = pipeline.predict(X)
df["risk_flag"] = df["risk_flag"].map({1: "Normal", -1: "High Risk"})
df["anomaly_score"] = pipeline.named_steps["model"].decision_function(
    pipeline.named_steps["scaler"].transform(X)
)
```

