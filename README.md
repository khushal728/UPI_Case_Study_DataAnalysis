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

## 📈 Power BI Dashboards

![ Video ](https://github.com/khushal728/UPI_Case_Study_DataAnalysis/blob/main/UPI%20Dashboard%20Recording.mp4) 

### 1️⃣ Executive Overview

- 250K+ transactions, ₹300M+ value

- ~95% success rate, ~5% failure rate

- Android dominates UPI usage

- Grocery & Food are top merchant categories

![ Screenshot ](https://github.com/khushal728/UPI_Case_Study_DataAnalysis/blob/main/UPI%20Dashboards/Executive%20Overview%20Page.png) 

### 2️⃣ Transaction Trends (Time Series)

- Stable MoM growth in volume & value

- Peak usage during 6–9 PM

- Android leads across all peak hours

- Predictable and healthy usage patterns

![ Screenshot ](https://github.com/khushal728/UPI_Case_Study_DataAnalysis/blob/main/UPI%20Dashboards/Transaction%20Trends%20Page.png)

### 3️⃣ Success & Failure Analysis

- ~237K successful transactions

- Failures are concentrated in specific banks & categories

- Utilities & Entertainment show slightly higher failures

- Actionable operational insights

![ Screenshot ](https://github.com/khushal728/UPI_Case_Study_DataAnalysis/blob/main/UPI%20Dashboards/Success%20%26%20Failure%20Analysis%20Page.png)


### 4️⃣ User Behavior & Demographics

- Average sender & receiver age: ~34 years

- Maharashtra is the top sender state

- SBI leads in transaction volume

- High-value transactions are largely successful

![ Screenshot ](https://github.com/khushal728/UPI_Case_Study_DataAnalysis/blob/main/UPI%20Dashboards/User%20Behavior%20%26%20Demographics%20%20PAge.png)


### 5️⃣ Financial Summary

- Low-value transactions dominate volume

- High-value transactions are stable and mostly successful

- SBI, HDFC, ICICI lead in transaction value

- Strong MTD performance (20K+ txns, ₹27M+)

![ Screenshot ](https://github.com/khushal728/UPI_Case_Study_DataAnalysis/blob/main/UPI%20Dashboards/Financial%20Summary%20%20Page.png)


### 6️⃣ Risk Analysis (ML-Driven)

- ~3% transactions flagged as High Risk (~7K+)

- Average anomaly score: ~0.14

- Risk is behavior-driven, not just amount-driven

- No sustained fraud trend detected over time

![ Screenshot ](https://github.com/khushal728/UPI_Case_Study_DataAnalysis/blob/main/UPI%20Dashboards/Risk%20Analysis%20Page.png)


## 🛠️ Skills & Tools Used

- SQL (PostgreSQL)

- Python (Pandas, NumPy, Scikit-learn, Seaborn)

- Machine Learning (Isolation Forest)

- Power BI (DAX, Data Modeling, Interactive Dashboards)

- Data Analytics & Risk Analysis

- Business Storytelling & Visualization


## 🎯 Outcomes & Business Impact

- Delivered a production-style UPI analytics system

- Identified high-risk transactions using ML

- Enabled executive-level risk monitoring

- Demonstrated end-to-end analytics ownership (DB → ML → BI)

## 🧩 Conclusion

This project showcases how data engineering, analytics, and machine learning can work together to solve real-world fintech problems.
By combining SQL-driven data modeling, ML-based risk detection, and Power BI storytelling, the system delivers insights that are actionable, scalable, and business-ready.


## 🙋‍♂️ Author

**Khushal Joshi**  
[LinkedIn](https://www.linkedin.com/in/khushal-joshi728/)  
[GitHub](https://github.com/khushal728)

---






