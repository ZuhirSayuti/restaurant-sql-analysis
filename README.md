# Restaurant Sales & Operations SQL Analysis

## Project Overview

This project analyzes restaurant sales and operational data using SQL in MySQL.

The goal of the project is to answer real business questions related to:
- sales performance
- customer behavior
- branch performance
- menu item popularity
- revenue trends
- operational efficiency
- customer segmentation

The project demonstrates advanced SQL analytics techniques using a relational restaurant database.

---

## Database Tables

The database contains the following tables:

- customers
- orders
- payments
- order_details
- menu_items
- employees
- branches

---

## SQL Skills Demonstrated

This project demonstrates:

- JOIN operations
- Aggregate functions (`SUM`, `AVG`, `COUNT`)
- GROUP BY
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- RANK() and DENSE_RANK()
- PARTITION BY
- CASE statements
- Business analytics queries
- Time-series analysis
- Cumulative calculations

---

## Business Questions Answered

### Sales & Revenue Analysis
- Total revenue generated
- Revenue by payment method
- Monthly sales trends
- Cumulative monthly revenue
- Top branches by revenue

### Customer Analysis
- Top customers by orders placed
- Top customers by revenue in each branch
- Customer spending classification

### Menu & Product Analysis
- Top-selling menu items
- Menu item revenue ranking within categories
- Revenue by menu category

### Operational Analysis
- Number of employees per branch
- Busiest days of the week
- Busiest hours of the day
- Average items per order

---

## Key Insights

### Total Revenue

```text
77,712
```

---

### Top Branches by Revenue

| Rank | Branch | Revenue |
|------|--------|---------:|
| 1 | Jeddah Corniche | 19,434 |
| 2 | Dammam Plaza | 15,920 |
| 3 | Taif Hills | 15,328 |
| 4 | Riyadh North | 14,996 |
| 5 | Makkah Central | 12,034 |

---

### Top Menu Categories by Revenue

| Rank | Category | Revenue |
|------|----------|---------:|
| 1 | Drink | 18,738 |
| 2 | Chicken | 17,817 |
| 3 | Side | 11,586 |
| 4 | Dessert | 5,080 |
| 5 | Burger | 5,034 |

---

### Busiest Days of the Week

| Rank | Day | Number of Orders |
|------|-----|-----------------:|
| 1 | Monday | 81 |
| 2 | Saturday | 78 |
| 3 | Thursday | 75 |
| 4 | Wednesday | 71 |
| 4 | Tuesday | 71 |
| 5 | Sunday | 64 |
| 6 | Friday | 60 |

---

## Example Business Observations

- Jeddah Corniche generated the highest branch revenue.
- Drinks and Chicken were the strongest-performing menu categories.
- Mondays and Saturdays showed the highest customer activity.
- Revenue distribution across branches was relatively balanced.
- Time-based analysis identified peak business hours and busiest weekdays.
- Customer segmentation revealed high-value and repeat customers.

AND MORE OBSERVATIONS... ALL CAN BE SEEN BY RUNNING THE ANALYSIS QUERIES

---

## Technologies Used

- MySQL
- MySQL Workbench
- SQL

---

## Advanced SQL Concepts Used

### Window Functions
Examples:
- `RANK()`
- `DENSE_RANK()`
- `SUM() OVER()`

### CTEs
Used to simplify complex analytical queries.

### Partitioning
Used for ranking data within categories and branches.

---

## Notes

- The dataset used in this project is synthetic and generated for analytical practice purposes.
- Some payment totals may not perfectly align with item-level totals due to generated-data variations.

---

## How to Run the Project

1. Download the dataset ZIP file from this repository.

2. Extract the CSV files.

3. Open MySQL Workbench.

4. Create a new database:

```sql
CREATE DATABASE restaurant_dataset;
USE restaurant_dataset;
```

5. Import all CSV files using:

```text
Server → Table Data Import Wizard
```

6. Run the SQL script:

```text
restaurant_analysis.sql
```

7. Explore the analysis queries and results.

---
