select Top 10* from cleaned_insurance_data

select count(*) as total_data from cleaned_insurance_data

Create view collected_premium_by_Region as
    SELECT Region, SUM(Premium_Amount) AS Total_Premium
    FROM cleaned_insurance_data
    GROUP BY Region

select * from collected_premium_by_Region

-- Average Premium by Policy Type
Create view avg_pre_by_policy as
    SELECT Policy_Type, Avg(Premium_Amount) AS avg_Premium
    FROM cleaned_insurance_data
    GROUP BY Policy_Type

select * from avg_pre_by_policy
--- Adding columns

select * from avg_claim_severity
order by avg_claims_severity desc

ALTER TABLE cleaned_insurance_data
ADD Claim_severity INT;

UPDATE cleaned_insurance_data
SET Claim_severity = 
    CASE 
        WHEN Claims_Severity = 'Low' THEN 0
        WHEN Claims_Severity = 'Medium' THEN 1
        WHEN Claims_Severity = 'High' THEN 2
    END;



-- Claim Analysis

-- Severity Distribution

SELECT Claim_severity, COUNT(*) AS Count
FROM cleaned_insurance_data
GROUP BY Claim_severity;

-- Total Claims Paid by Region
SELECT Region, SUM(Claims_Adjustment) AS Total_Claims_Paid
FROM cleaned_insurance_data
GROUP BY Region
ORDER BY Total_Claims_Paid DESC;

--  Discount & Conversion Analysis

-- Impact of Discounts on Premiums:
select 
	case
		When Total_discount_impact<0.02 Then 'Low Discount'
		When Total_discount_impact Between 0.02 and 0.07 Then 'Medium Discount'
		Else 'High Discount'
	End as dicount_category,
	count(*) as total_Customers,
	avg(Premium_Amount) as Avg_premium
from cleaned_insurance_data

group by 
	case
		When Total_discount_impact<0.02 Then 'Low Discount'
		When Total_discount_impact Between 0.02 and 0.07 Then 'Medium Discount'
		Else 'High Discount'
	End
order by Avg_premium desc


-- Conversion Rate by Lead Source

select Source_of_Lead,
	count(*) as Total_Leads 
	From cleaned_insurance_data
	Group by Source_of_Lead
	order by Total_Leads desc


