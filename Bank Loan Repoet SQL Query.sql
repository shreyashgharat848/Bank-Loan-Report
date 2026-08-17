
-- SELECTING DATABASE

USE Bank_Loan_DB;
GO


-- Dynamic Executive KPI Summary
--Instead of 15 queries, compute current month, previous month, and month-over-month (MoM) growth dynamically for all KPIs in a single query.

WITH MonthlyAggregates AS (
    SELECT 
        DATEFROMPARTS(YEAR(issue_date), MONTH(issue_date), 1) AS issue_month,
        COUNT(id) AS total_applications,
        SUM(loan_amount) AS total_funded,
        SUM(total_payment) AS total_received,
        AVG(int_rate) * 100 AS avg_intrest_rate,
        AVG(dti) * 100 AS avg_dti,
        COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) * 100.0 / NULLIF(COUNT(id), 0) AS good_loan_pct,
        COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0 / NULLIF(COUNT(id), 0) AS bad_loan_pct
    FROM bank_loan_data
    GROUP BY DATEFROMPARTS(YEAR(issue_date), MONTH(issue_date), 1)
),
MetricsWithMoM AS (
    SELECT 
        issue_month,
        total_applications,
        LAG(total_applications) OVER (ORDER BY issue_month) AS prev_month_appplications,
        total_funded,
        LAG(total_funded) OVER (ORDER BY issue_month) AS prev_month_funded,
        total_received,
        good_loan_pct,
        bad_loan_pct,
        ROUND(((total_funded - LAG(total_funded) OVER (ORDER BY issue_month)) * 100.0) 
              / NULLIF(LAG(total_funded) OVER (ORDER BY issue_month), 0), 2) AS funded_mom_growth_pct
    FROM MonthlyAggregates
)
SELECT * 
FROM MetricsWithMoM
ORDER BY issue_month DESC;



-- Multi-Dimensional Aggregation
--Instead of running separate queries for State, Term, Purpose, and Employee Length, use GROUPING SETS to produce hierarchical reporting in a single pass.

SELECT 
    COALESCE(address_state, 'ALL STATES') AS state,
    COALESCE(term, 'ALL TERMS') AS term,
    COALESCE(purpose, 'ALL PURPOSES') AS purpose,
    COUNT(id) AS total_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_collected_amount,
    ROUND(SUM(total_payment) - SUM(loan_amount), 2) AS net_cash_flow
FROM bank_loan_data
GROUP BY GROUPING SETS (
    (address_state),
    (term),
    (purpose),
    () -- Grand Total
)
ORDER BY total_funded_amount DESC;



-- Risk & Credit Segmentation
--Lending businesses evaluate risk profiles by banding borrowers into DTI and Credit Grade buckets.
SELECT 
    grade,
    sub_grade,
    CASE 
        WHEN dti < 0.10 THEN '1. Low (< 10%)'
        WHEN dti BETWEEN 0.10 AND 0.20 THEN '2. Medium (10-20%)'
        WHEN dti BETWEEN 0.20 AND 0.30 THEN '3. High (20-30%)'
        ELSE '4. Critical (> 30%)'
    END AS dti_risk_band,
    COUNT(id) AS total_loans,
    SUM(loan_amount) AS total_funded,
    COUNT(CASE WHEN loan_status = 'Charged Off' THEN 1 END) * 100.0 / NULLIF(COUNT(id), 0) AS default_rate_pct,
    ROUND(AVG(int_rate) * 100, 2) AS avg_yield_percentage
FROM bank_loan_data
GROUP BY 
    grade,
    sub_grade,
    CASE 
        WHEN dti < 0.10 THEN '1. Low (< 10%)'
        WHEN dti BETWEEN 0.10 AND 0.20 THEN '2. Medium (10-20%)'
        WHEN dti BETWEEN 0.20 AND 0.30 THEN '3. High (20-30%)'
        ELSE '4. Critical (> 30%)'
    END
ORDER BY grade, sub_grade;



-- Running Totals and 3-Month Moving Averages
-- Senior roles frequently require cumulative running totals and trend smoothing via moving averages.
WITH MonthlySummary AS (
    SELECT 
        DATEFROMPARTS(YEAR(issue_date), MONTH(issue_date), 1) AS issue_month,
        SUM(loan_amount) AS monthly_funded,
        COUNT(id) AS monthly_loans
    FROM bank_loan_data
    GROUP BY DATEFROMPARTS(YEAR(issue_date), MONTH(issue_date), 1)
)
SELECT 
    issue_month,
    monthly_funded,
    -- Running Cumulative Total
    SUM(monthly_funded) OVER (
        ORDER BY issue_month 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_funded,
    -- 3-Month Rolling Moving Average
    AVG(monthly_funded) OVER (
        ORDER BY issue_month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3m_avg_funded
FROM MonthlySummary
ORDER BY issue_month;



-- Production Database View

-- Previous query ends above

GO

CREATE OR ALTER VIEW vw_bank_loan_summary AS
SELECT 
    id,
    issue_date,
    DATEFROMPARTS(YEAR(issue_date), MONTH(issue_date), 1) AS issue_month,
    address_state,
    term,
    emp_length,
    purpose,
    grade,
    loan_amount,
    total_payment,
    int_rate,
    dti,
    loan_status,
    CASE 
        WHEN loan_status IN ('Fully Paid', 'Current') THEN 'Good Loan'
        WHEN loan_status = 'Charged Off' THEN 'Bad Loan'
        ELSE 'Other'
    END AS loan_classification,
    (total_payment - loan_amount) AS net_profit_loss
FROM bank_loan_data;
GO


CREATE OR ALTER PROCEDURE sp_GetLoanExecutiveReport
    @StartDate DATE = NULL,
    @EndDate DATE = NULL,
    @Grade VARCHAR(5) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Default to the last 12 months if dates are omitted
        IF @StartDate IS NULL
            SET @StartDate = DATEADD(MONTH, -12, GETDATE());
        IF @EndDate IS NULL
            SET @EndDate = GETDATE();

        SELECT 
            DATEFROMPARTS(YEAR(issue_date), MONTH(issue_date), 1) AS metric_month,
            COUNT(id) AS total_applications,
            SUM(loan_amount) AS total_funded_amount,
            SUM(total_payment) AS total_collected_amount,
            ROUND(SUM(total_payment) - SUM(loan_amount), 2) AS net_cash_flow,
            ROUND(AVG(int_rate) * 100, 2) AS avg_interest_rate,
            ROUND(AVG(dti) * 100, 2) AS avg_dti,
            ROUND(COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) * 100.0 / NULLIF(COUNT(id), 0), 2) AS good_loan_pct,
            ROUND(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0 / NULLIF(COUNT(id), 0), 2) AS default_rate_pct
        FROM bank_loan_data
        WHERE issue_date >= @StartDate 
          AND issue_date < DATEADD(DAY, 1, @EndDate)
          AND (@Grade IS NULL OR grade = @Grade)
        GROUP BY DATEFROMPARTS(YEAR(issue_date), MONTH(issue_date), 1)
        ORDER BY metric_month DESC;

    END TRY
    BEGIN CATCH
        -- Enterprise error handling
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO