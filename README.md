# Banking Client Analytics Project

> A comprehensive end-to-end data analytics project on banking client data — covering SQL-based exploratory analysis, Python EDA, interactive Power BI dashboards, and professional reporting deliverables.

![Status](https://img.shields.io/badge/Status-Completed-brightgreen?style=flat)
![Python](https://img.shields.io/badge/Python-3.14-blue?style=flat&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-8.0-4479A1?style=flat&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat&logo=powerbi&logoColor=black)

---

## 📚 Table of Contents

- [📁 Repository Structure](#-repository-structure)
- [🎯 Project Objectives](#-project-objectives)
- [📊 Dataset Overview](#-dataset-overview)
- [🗄️ SQL Analysis](#️-sql-analysis----eda_mysqlsql)
- [🐍 Python EDA](#-python-eda----eda_pythonipynb)
- [📊 Power BI Dashboard](#-power-bi-dashboard----banking_dashboardpbix)
- [📑 Reports & Presentations](#-reports--presentations)
- [🛠️ Tech Stack](#️-tech-stack)
- [🚀 Getting Started](#-getting-started)
- [🗃️ Database Schema](#️-database-schema)
- [📌 Key Insights](#-key-insights)
- [👤 Author](#-author)

---

## 🎯 Project Objectives

This project aims to perform a **full-cycle exploratory data analysis** on a banking client dataset using industry-standard tools. The key objectives are:

- 🔍 **Explore** client demographics, financial behaviour, and advisor relationships through SQL
- 🐍 **Analyse** distributions, correlations, outliers, and skewness using Python
- 📊 **Visualise** key business metrics through an interactive Power BI dashboard
- 🏗️ **Engineer** meaningful features such as Income Band, Debt-to-Income ratio, and Savings Ratio
- 📋 **Deliver** professional reports in Word, PDF, and PowerPoint formats
- 💡 **Answer** 120+ real-world business questions across client segmentation, advisor performance, and risk analysis

---

## 📁 Repository Structure

```
banking-client-analytics/
│
├── 📄 clients.csv                              # Main enriched client dataset (2,881 rows, 28 cols)
├── 📄 gender.csv                               # Gender lookup table
├── 📄 investment_advisiors.csv                 # Investment advisors lookup table
├── 📄 banking_realtionships.csv                # Banking relationship type lookup table
│
├── 🗄️  eda_mysql.sql                           # 120 SQL queries across 15 analytical sections
├── 📓 eda_python.ipynb                         # Python EDA notebook (pandas, seaborn, matplotlib)
│
├── 📊 banking_dashboard.pbix                   # Interactive Power BI dashboard
├── 📑 Banking_Client_Analytics_Report.ppt      # PowerPoint presentation
├── 📋 Banking_Client_Analytics_Report.pdf      # PDF version of the analytics report
└── 📝 Banking_Analytics_Report.docx            # Word document report
```

---

## 📊 Dataset Overview

### 🗂️ `clients.csv` — Main Dataset
| Property | Value |
|---|---|
| Rows | 2,881 |
| Columns | 28 |
| Missing Values | None ✅ |
| Duplicates | None ✅ |

#### 📋 Columns
| # | Column | Type | Description |
|---|---|---|---|
| 1 | `Client_ID` | str | Unique client identifier (e.g. IND81288) |
| 2 | `Name` | str | Full name of the client |
| 3 | `Age` | int | Client age |
| 4 | `Location_ID` | int | Location reference ID |
| 5 | `Joined_Bank` | str | Date client joined the bank |
| 6 | `Banking_Contact` | str | Assigned banking contact person |
| 7 | `Nationality` | str | Client nationality (e.g. American, African, European) |
| 8 | `Occupation` | str | Client's job title |
| 9 | `Fee_Structure` | str | Fee tier: High / Mid |
| 10 | `Loyalty_Classification` | str | Loyalty tier: Jade / Gold / Silver / Platinum |
| 11 | `Estimated_Income` | float | Estimated annual income |
| 12 | `Superannuation_Savings` | float | Retirement/superannuation savings |
| 13 | `Amount_of_Credit_Cards` | int | Number of credit cards held |
| 14 | `Credit_Card_Balance` | float | Outstanding credit card balance |
| 15 | `Bank_Loans` | float | Total bank loans |
| 16 | `Bank_Deposits` | float | Total bank deposits |
| 17 | `Checking_Accounts` | float | Checking account balance |
| 18 | `Saving_Accounts` | float | Savings account balance |
| 19 | `Foreign_Currency_Account` | float | Foreign currency account balance |
| 20 | `Business_Lending` | float | Business lending amount |
| 21 | `Properties_Owned` | int | Number of properties owned (0–3) |
| 22 | `Risk_Weighting` | int | Risk score (1–5) |
| 23 | `BRId` | int | Banking relationship ID (FK) |
| 24 | `GenderId` | int | Gender ID (FK) |
| 25 | `IAId` | int | Investment advisor ID (FK) |
| 26 | `Income Band` | str | Engineered: Low / Medium / High |
| 27 | `debt_to_income` | float | Engineered: Bank_Loans / Estimated_Income |
| 28 | `savings_ratio` | float | Engineered: Saving_Accounts / Estimated_Income |

---

### 🔗 Lookup Tables

#### 👤 `gender.csv`
| GenderId | Gender |
|---|---|
| 1 | Male |
| 2 | Female |

#### 🏦 `banking_realtionships.csv`
| BRId | Banking Relationship |
|---|---|
| 1 | Retail |
| 2 | Institutional |
| 3 | Private Bank |
| 4 | Commercial |

#### 👔 `investment_advisiors.csv` — 22 Advisors
| IAId | Investment Advisor | IAId | Investment Advisor |
|---|---|---|---|
| 1 | Victor Dean | 12 | Victor Gutierrez |
| 2 | Jeremy Porter | 13 | Daniel Carroll |
| 3 | Ernest Knight | 14 | Carl Anderson |
| 4 | Eric Shaw | 15 | Nicholas Ward |
| 5 | Kevin Kim | 16 | Fred Bryant |
| 6 | Victor Rogers | 17 | Ryan Taylor |
| 7 | Eugene Cunningham | 18 | Sean Vasquez |
| 8 | Joe Carroll | 19 | Nicholas Morrison |
| 9 | Steve Sanchez | 20 | Jack Phillips |
| 10 | Lawrence Sanchez | 21 | Juan Ramirez |
| 11 | Peter Castillo | 22 | Gregory Boyd |

---

## 🗄️ SQL Analysis — `eda_mysql.sql`

120 business-driven SQL queries written in **MySQL**, organized across **15 sections**:

| # | Section | Queries | Key Concepts |
|---|---|---|---|
| 1 | Basic SELECT | 1–10 | SELECT, COUNT, DISTINCT, LIMIT, GROUP BY |
| 2 | Filtering | 11–20 | WHERE, AND, OR, BETWEEN, IN, NOT IN |
| 3 | INNER JOIN | 21–30 | Multi-table joins, HAVING, self-join |
| 4 | LEFT JOIN | 31–40 | Outer joins, NULL checks, CROSS JOIN, CASE |
| 5 | RIGHT / FULL JOIN | 41–45 | RIGHT JOIN, UNION ALL simulation of FULL JOIN |
| 6 | Subqueries | 46–55 | Correlated & nested subqueries |
| 7 | IN / EXISTS | 56–65 | IN, NOT IN, EXISTS, NOT EXISTS |
| 8 | CTEs | 66–75 | WITH clause, multi-CTE, cumulative distribution |
| 9 | Window Ranking | 76–85 | ROW_NUMBER, RANK, DENSE_RANK, NTILE, PERCENT_RANK |
| 10 | Analytical Windows | 86–95 | LAG, LEAD, FIRST_VALUE, LAST_VALUE, running totals, moving avg |
| 11 | CASE Statements | 96–100 | Conditional logic, performance scoring, data quality flags |
| 12 | UNION | 101–105 | UNION, UNION ALL, cross-category summaries |
| 13 | Aggregations | 106–110 | ROLLUP, STDDEV, VARIANCE, pivot-style aggregation |
| 14 | Recursive CTEs | 111–112 | WITH RECURSIVE, ID gap detection, hierarchy simulation |
| 15 | Business Scenarios | 113–120 | Client segmentation, concentration risk, peer benchmarking, exec KPI dashboard |

### 🔍 Sample Business Questions Answered
- Which advisors manage more clients than average?
- What percentage of banking relationships are actually being used?
- Which advisor-gender combinations have no clients?
- How to segment clients into strategic categories based on multiple factors?
- What is the concentration risk in client distribution?

---

## 🐍 Python EDA — `eda_python.ipynb`

Built with **Python 3.14** using `pandas`, `numpy`, `matplotlib`, and `seaborn`.

### 🔧 Workflow

#### 1️⃣ Data Loading & Inspection
```python
df = pd.read_csv('banking_clients.csv')
df.info()        # 3000 rows, 25 columns
df.head()
df.describe(include='all')
```

#### 2️⃣ Data Quality
```python
df.isnull().sum()     # ✅ 0 missing values
df.duplicated().sum() # ✅ No duplicates
```

#### 3️⃣ Data Cleaning
```python
df.columns = [col.replace(' ', '_') for col in df.columns]
```

#### 4️⃣ Feature Engineering
```python
# Income Banding
df['Income Band'] = pd.cut(df['Estimated_Income'],
                           bins=[0, 100000, 300000, float('inf')],
                           labels=['Low', 'Medium', 'High'])

# Derived Financial Ratios
df['debt_to_income'] = df['Bank_Loans'] / df['Estimated_Income']
df['savings_ratio']  = df['Saving_Accounts'] / df['Estimated_Income']
```

#### 5️⃣ Categorical Analysis
Value counts and countplots for: `Nationality`, `Occupation`, `Fee_Structure`, `Loyalty_Classification`, `Properties_Owned`, `Risk_Weighting`, `BRId`, `GenderId`, `IAId`, `Income Band` — visualized by gender and nationality breakdowns.

#### 6️⃣ Numerical Analysis
Histograms, boxplots, and KDE plots for 9 financial columns:
`Estimated_Income`, `Superannuation_Savings`, `Credit_Card_Balance`, `Bank_Loans`, `Bank_Deposits`, `Checking_Accounts`, `Saving_Accounts`, `Foreign_Currency_Account`, `Business_Lending`

#### 7️⃣ Skewness Analysis
| Column | Skewness | Assessment |
|---|---|---|
| Saving_Accounts | 2.19 | Highly Right-Skewed |
| Checking_Accounts | 1.73 | Right-Skewed |
| Bank_Deposits | 1.71 | Right-Skewed |
| Bank_Loans | 1.18 | Moderately Skewed |
| Credit_Card_Balance | 1.13 | Moderately Skewed |
| Foreign_Currency_Account | 1.12 | Moderately Skewed |
| Business_Lending | 1.15 | Moderately Skewed |
| Estimated_Income | 0.88 | Slightly Skewed |
| Superannuation_Savings | 0.71 | Near Symmetric |

#### 8️⃣ Outlier Detection (IQR Method)
| Column | Outliers |
|---|---|
| Saving_Accounts | 155 |
| Bank_Deposits | 149 |
| Checking_Accounts | 138 |
| Business_Lending | 93 |
| Bank_Loans | 85 |
| Credit_Card_Balance | 85 |
| Foreign_Currency_Account | 79 |
| Estimated_Income | 26 |
| Superannuation_Savings | 19 |

#### 9️⃣ Correlation with Bank Deposits
| Feature | Correlation |
|---|---|
| Bank_Deposits | 1.00 |
| Checking_Accounts | 0.84 |
| Saving_Accounts | 0.75 |
| Business_Lending | 0.44 |
| Foreign_Currency_Account | 0.41 |
| Credit_Card_Balance | 0.38 |
| Bank_Loans | 0.37 |
| Estimated_Income | 0.26 |
| Superannuation_Savings | 0.17 |

#### 🔟 Group Analysis
```python
df.groupby('Income Band')['Bank_Deposits'].mean()
df.groupby('GenderId')['Estimated_Income'].mean()
df.groupby('Nationality')['Bank_Loans'].mean().sort_values(ascending=False)
```

---

## 📊 Power BI Dashboard — `banking_dashboard.pbix`

Interactive dashboard built in **Microsoft Power BI** providing visual insights into client demographics, advisor performance, banking relationship distribution, income segmentation, and financial product usage.

---

## 📑 Reports & Presentations

| File | Format | Description |
|---|---|---|
| `Banking_Client_Analytics_Report.ppt` | PowerPoint | Slide deck summarizing key findings and visualizations |
| `Banking_Client_Analytics_Report.pdf` | PDF | Portable version of the analytics report |
| `Banking_Analytics_Report.docx` | Word | Detailed written analytics report |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| ![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white) | SQL-based EDA (120 queries) |
| ![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white) | Data analysis & visualization |
| ![Pandas](https://img.shields.io/badge/Pandas-150458?style=flat&logo=pandas&logoColor=white) | Data manipulation |
| ![NumPy](https://img.shields.io/badge/NumPy-013243?style=flat&logo=numpy&logoColor=white) | Numerical operations |
| ![Matplotlib](https://img.shields.io/badge/Matplotlib-11557C?style=flat&logo=python&logoColor=white) | Plotting |
| ![Seaborn](https://img.shields.io/badge/Seaborn-4C72B0?style=flat&logo=python&logoColor=white) | Statistical visualization |
| ![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black) | Interactive dashboards |
| ![Microsoft Word](https://img.shields.io/badge/Word-2B579A?style=flat&logo=microsoftword&logoColor=white) | Written report |
| ![PowerPoint](https://img.shields.io/badge/PowerPoint-B7472A?style=flat&logo=microsoftpowerpoint&logoColor=white) | Presentation |

---

## 🚀 Getting Started

### Prerequisites
```bash
pip install pandas numpy matplotlib seaborn jupyter
```

### Run the Python Notebook
```bash
jupyter notebook eda_python.ipynb
```

### Run the SQL Analysis
```sql
-- Connect to your MySQL instance and run:
USE finance;
-- Then execute queries from eda_mysql.sql
```

### Open the Power BI Dashboard
Open `banking_dashboard.pbix` in **Microsoft Power BI Desktop**.

---

## 🗃️ Database Schema

```
clients
   ├── GenderId ──────► gender (GenderId)
   ├── BRId ───────────► banking_realtionships (BRId)
   └── IAId ───────────► investment_advisiors (IAId)
```

---

## 📌 Key Insights

- 📋 **2,881 clients** with **zero missing values** — clean, analysis-ready dataset
- 👔 **22 investment advisors** managing clients across 4 banking relationship types
- 💰 **Checking Accounts** show the strongest correlation with Bank Deposits (r = 0.84)
- 📈 **Saving Accounts** is the most right-skewed financial feature (skewness = 2.19)
- 🏦 Banking relationships span: **Retail, Institutional, Private Bank, Commercial**
- 🎯 **120 SQL queries** covering everything from basic SELECTs to recursive CTEs and executive KPI dashboards

---

---

## 👤 Author

| | |
|---|---|
| **Name** | Dharmesh Makwana |
| **GitHub** | [@dharmesh9](https://github.com/dharmesh9) |

---

*⭐ If you found this project helpful, please consider giving it a star on GitHub!*

*Built as a comprehensive banking client analytics portfolio project — 2025.*
