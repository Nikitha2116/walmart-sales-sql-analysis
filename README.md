## 🧵 Project Story: Why This Analysis Matters

Walmart operates hundreds of stores across the U.S., and each location faces unique challenges — 
holiday rushes, seasonal trends, economic changes, and unpredictable customer behavior. 
Understanding *why* some stores outperform others is critical for planning inventory, staffing, 
and promotions.

This project began with one question:
**“What truly drives sales performance at Walmart stores?”**

Using SQL, I explored how holidays, economic factors, and time-based patterns influence sales 
across different regions.

🧠 Hypothesis  
I hypothesize that:
- Holiday weeks have significantly higher sales than non-holiday weeks.
- External factors such as fuel price, CPI, and unemployment influence weekly sales patterns.
- Certain stores remain top performers regardless of economic conditions.

🎯 OBJECTIVES

- Clean and standardize inconsistent date formats
- Rank stores by total sales using SQL window functions
- Compare holiday vs non-holiday week sales
- Identify monthly and yearly sales trends
- Analyze economic factors affecting performance

🧠 TECH STACK

- MySQL
- Data Cleaning, Aggregation, and Transformation
- Window Functions (`RANK() OVER`)
- Grouping and Conditional Logic (`CASE WHEN`)
- Business Insight Generation

📊 DATASET DETAILS

- **Store:** Unique ID for each Walmart store  
- **Date:** Weekly sales date  
- **Weekly_Sales:** Total sales per store per week  
- **Holiday_Flag:** 1 = Holiday week, 0 = Regular week  
- **Temperature, Fuel_Price, CPI, Unemployment:** External variables

## 📊 How I Tested My Hypothesis  
To validate the hypothesis, I performed the following:

- 🧹 Cleaned inconsistent date formats  
- 🎯 Compared holiday vs non-holiday weekly sales  
- 📅 Analyzed monthly and yearly sales patterns  
- 🏆 Used SQL window functions (`RANK() OVER`) to identify top-performing stores  
- 📉 Examined how CPI, fuel price, and unemployment correlate with weekly sales  
- 📊 Wrote multiple SQL queries to test each part of the hypothesis  

## 📈 Key Findings (Resolution)

- 🎉 Holiday weeks had significantly higher weekly sales  
- 🏪 Store 20 and Store 4 were consistent top performers  
- ⛽ Fuel price had minimal impact on sales  
- 📉 CPI & unemployment showed moderate correlation with performance  
- ☀️ Summer months had more stable sales than winter months  

These results confirm or reject parts of the hypothesis and complete the “story arc” of the project.

🔍 ANALYSIS HIGHLIGHTS

💡 **1. Store Performance Ranking**
```sql
SELECT Store_id, 
       SUM(Weekly_Sales) AS Total_Sales,
       RANK() OVER (ORDER BY SUM(Weekly_Sales) DESC) AS Rank_Position
FROM walmart.walmart
GROUP BY Store_id;
```
🏆 Store 20 achieved the highest overall sales performance.

💡 **2. Holiday Impact**
Holiday weeks showed an average sales boost of 15–25% across most stores.

💡 **3. Monthly Trends**
Peak sales observed during holiday months (Nov–Dec), 
while lowest sales occurred mid-year (June–July).

💡 **4. External Factors**
Temperature and fuel price fluctuations had a measurable effect 
on weekly sales performance.

📈 INSIGHTS & LEARNINGS

- Translating raw data into actionable business insights
- Applying analytical SQL concepts to real-world retail data
- Strengthened storytelling and data presentation skills

🖼️ SAMPLE OUTPUT

![Ranked Stores Output](ranked_stores_output.png)
*Figure: Ranking Walmart stores by total sales using SQL window functions.*

👩‍💻 AUTHOR

**Nikitha Katta**  
🎓 Graduate Student, University of Delaware  
🔗 [LinkedIn Profile](https://linkedin.com/in/nikitha-k-01564722a)  
📧 nikitha@udel.edu  

🌟 FUTURE IMPROVEMENTS

- Create Tableau/Power BI dashboards for visualization
- Automate SQL analysis pipeline using Python
- Add predictive analytics (forecasting sales trends)


💬 QUOTE
> *“Data isn’t just numbers - it’s the story of business decisions waiting to be discovered.”*

