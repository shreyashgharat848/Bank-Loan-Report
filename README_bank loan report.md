# 🏦 Bank Loan Analytics

An end-to-end **Bank Loan Analytics** project using **Python, SQL Server, and Power BI** to analyze loan performance, portfolio trends, borrower risk, and key financial KPIs.

## 📌 Project Overview

This project analyzes a financial loan dataset to understand the overall health and performance of a loan portfolio. The analysis combines Python-based exploratory data analysis, SQL-based business reporting, and Power BI visualization.

The project focuses on:

- Loan application and funding KPIs
- Month-to-date (MTD) and previous-month comparisons
- Good vs. bad loan performance
- Loan status analysis
- Monthly portfolio trends
- Regional/state-wise performance
- Loan-term analysis
- Employment-length analysis
- Loan-purpose analysis
- Home-ownership analysis
- Interest rate and Debt-to-Income Ratio (DTI)
- Portfolio and loan risk analysis

## 🎯 Business Objectives

The main objectives are to:

1. Measure the volume and value of loan applications.
2. Track total funded and received loan amounts.
3. Compare current-month performance with the previous month.
4. Identify the proportion and financial impact of good and bad loans.
5. Analyze portfolio performance across different borrower and loan segments.
6. Identify regional and purpose-based funding patterns.
7. Evaluate key risk indicators such as loan status, interest rate, and DTI.
8. Build an interactive Power BI report for business-level decision making.

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **Python** | Data analysis and exploratory analysis |
| **Pandas** | Data manipulation and aggregation |
| **NumPy** | Numerical operations |
| **Matplotlib** | Data visualization |
| **Seaborn** | Statistical visualization |
| **Plotly** | Interactive visualization |
| **SQL Server** | KPI calculations, reporting and portfolio analysis |
| **Power BI** | Interactive dashboard and business reporting |
| **Excel** | Source loan dataset |

## 📂 Project Structure

```text
Bank-Loan-Report/
│
├── Bank Loan Analysis.ipynb
├── Bank Loan Report SQL Query.sql
├── Query_Doc.docx
├── financial_loan_data_excel.xlsx
├── Bank Loan Report power Bi.pbix
└── README.md
```

## 🔄 Project Workflow

```text
Raw Loan Dataset
       ↓
Data Loading & Exploration
       ↓
Python EDA
       ↓
KPI & Risk Analysis
       ↓
SQL Server Business Queries
       ↓
Power BI Dashboard
       ↓
Portfolio & Risk Insights
```

## 📊 Key KPIs

The project calculates and analyzes the following core KPIs:

### Loan Portfolio KPIs

- Total Loan Applications
- MTD Loan Applications
- Previous-Month Loan Applications
- Total Funded Amount
- MTD Funded Amount
- Previous-Month Funded Amount
- Total Amount Received
- MTD Amount Received
- Average Interest Rate
- Average DTI

### Good Loan Metrics

Good loans are defined as loans with status:

- `Fully Paid`
- `Current`

Metrics include:

- Good Loan Applications
- Good Loan Percentage
- Good Loan Funded Amount
- Good Loan Amount Received

### Bad Loan Metrics

Bad loans are identified using:

- `Charged Off`

Metrics include:

- Bad Loan Applications
- Bad Loan Percentage
- Bad Loan Funded Amount
- Bad Loan Amount Received

The SQL analysis explicitly calculates good-loan and bad-loan funding and repayment measures.

## 🧮 SQL Analysis

SQL Server is used to create business-oriented reports from the `bank_loan_data` table.

Major SQL analyses include:

### 1. Summary / KPI Analysis

Calculates:

- Applications
- Funded amount
- Amount received
- Interest rate
- DTI
- MTD and previous-month metrics

### 2. Loan Status Analysis

Loan status is analyzed using:

- Loan count
- Total amount received
- Total funded amount
- Average interest rate
- Average DTI

### 3. Monthly Analysis

The project tracks monthly:

- Loan applications
- Total funded amount
- Total amount received

### 4. State-wise Analysis

Loan activity is analyzed by `address_state` using:

- Loan applications
- Funded amount
- Amount received

### 5. Loan Term Analysis

Loan performance is compared across different terms such as:

- 36 months
- 60 months

### 6. Employment Length Analysis

Portfolio funding is analyzed by borrower employment length.

### 7. Loan Purpose Analysis

Funding is analyzed across purposes such as:

- Debt consolidation
- Credit card
- Home improvement
- Major purchase
- Small business
- Medical
- Car
- Vacation
- Wedding
- Other

### 8. Home Ownership Analysis

Loan performance is segmented by:

- Mortgage
- Rent
- Own
- Other
- None

## 🐍 Python Analysis

Python is used for data loading, profiling, KPI calculations and visualization.

### Data Exploration

The notebook includes:

- Dataset preview
- Number of rows and columns
- Data types
- Descriptive statistics
- Dataset metadata inspection

### Monthly Trend Analysis

The project visualizes monthly trends for:

- Total funded amount
- Total amount received
- Total loan applications

### Regional Analysis

State-level funding is visualized to understand the geographic distribution of the loan portfolio.

### Loan Term Analysis

The funded amount is compared across loan terms using a donut-style visualization.

### Employment Analysis

Total funded amount is analyzed by borrower employment length.

### Loan Purpose Analysis

Funding is compared across different loan purposes.

### Home Ownership Analysis

A treemap is used to visualize funded amount by home-ownership category.

## 📈 Risk Analytics

Risk analytics is an important part of the project.

The analysis uses:

- Loan status
- Good vs. bad loan classification
- Charged-off loans
- Interest rate
- Debt-to-Income Ratio (DTI)
- Loan term
- Borrower employment length
- Loan purpose
- Geographic distribution

This supports **portfolio-level risk analysis and performance monitoring**.

> Note: This project is primarily a descriptive and diagnostic loan/portfolio risk analysis project. It is not a predictive credit-risk model.

## 💡 Example Business Questions Answered

The project helps answer questions such as:

- How many loans have been issued?
- How much money has been funded?
- How much has been received back?
- How is the portfolio performing month by month?
- What percentage of loans are good versus bad?
- How much capital is associated with charged-off loans?
- Which states have the highest funded amounts?
- Which loan purposes receive the most funding?
- How does funding differ between 36-month and 60-month loans?
- How does employment length relate to funded amount?
- How is the portfolio distributed across home-ownership categories?
- What are the average interest rate and DTI levels?

## 📁 Dataset

The project uses a financial loan dataset containing loan-level information such as:

- Loan ID
- Issue date
- Loan amount
- Total payment
- Interest rate
- DTI
- Loan status
- State
- Loan term
- Employment length
- Loan purpose
- Home ownership

## 📊 Power BI

The Power BI report is used to present the analysis in an interactive business-reporting format.

The dashboard can be used to monitor:

- Portfolio KPIs
- Loan performance
- Good vs. bad loans
- Monthly trends
- Regional performance
- Loan characteristics
- Risk-related metrics

## 🔑 Key Takeaway

This project demonstrates an end-to-end analytics workflow:

**Data → Python EDA → SQL Business Analysis → Risk Analytics → Power BI Dashboard**

It combines technical data analysis with financial and portfolio-level business insights.

## 👤 Author

**Shreyash Gharat**

MSc Mathematics & Scientific Computing

Areas of Interest: **Data Science | Risk Analytics | Financial Analytics | Quantitative Analytics**

---

⭐ If you find this project useful, feel free to explore the analysis, SQL queries, and Power BI report.
