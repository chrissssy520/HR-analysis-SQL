# 👥 HR Employee Data Analysis — SQL Project

A SQL project analyzing a 500-row HR employee dataset covering salary benchmarking, attendance, promotions, tenure, gender distribution, and data cleaning — across 8 departments and 4 regions.

---

## 📁 Dataset

| Column | Description |
|---|---|
| `Employee_ID` | Unique employee identifier |
| `Full_Name` | Employee full name |
| `Gender` | Male / Female |
| `Age` | Employee age |
| `Department` | One of 8 departments |
| `Position` | Role within the department |
| `Salary` | Annual salary |
| `Hire_Date` | Date of employment |
| `Exit_Date` | Date of resignation or termination (if applicable) |
| `Years_At_Company` | Total tenure in years |
| `Employment_Status` | Active, Resigned, Terminated, On Leave |
| `Performance_Rating` | Poor → Outstanding (5-tier) |
| `Education_Level` | High School → PhD |
| `Region` | Luzon, Visayas, Mindanao, NCR |
| `Job_Satisfaction` | Score from 1.0 (low) to 5.0 (high) |
| `Absences` | Number of days absent |
| `Overtime_Hours` | Total overtime hours |
| `Training_Hours` | Total training hours completed |
| `Promotions` | Number of promotions received |
| `Last_Promotion_Year` | Year of most recent promotion |

> ⚠️ **Note:** Raw dataset was backed up as `hr_employee_dataset_backup.csv` before any data modification was applied.

---

## 🎯 Objective

Perform a full HR analytics exploration covering:
- Salary benchmarking by department and position
- Attendance and absence tracking
- Promotion and tenure analysis
- Gender and regional workforce distribution
- Data quality issue identification and correction

---

## 🧠 SQL Concepts Used

- `WITH` — Common Table Expressions (CTEs)
- `CASE WHEN` — Conditional logic and data correction
- `WINDOW FUNCTIONS` — `AVG()`, `COUNT()`, `DENSE_RANK()` with `OVER(PARTITION BY)`
- `SUBQUERIES` — Correlated subqueries for salary comparison
- `UPDATE` — Data cleaning with safe update guards
- `GROUP BY` — Aggregations across departments and regions
- `WHERE / IN` — Filtering active vs inactive employees

---

## 💻 Queries

See the full query file → [`hr_analysis.sql`](./hr_analysis.sql)

### Query Summary

| # | Query | Concepts |
|---|---|---|
| 1 | Average Salary by Department & Position | Window Function, `AVG OVER PARTITION BY` |
| 2 | Employees Above Company Average Salary | Correlated Subquery, `salary_gap` |
| 3 | Total Employees per Department | Window Function, `COUNT OVER PARTITION BY` |
| 4 | Total Employees per Position | Window Function, `COUNT OVER PARTITION BY` |
| 5 | Top 5 Employees with Most Absences | CTE, `DENSE_RANK()` |
| 6 | Gender Comparison & Average Age | `COUNT`, `AVG`, Percentage Calculation |
| 7 | Longest Tenured Employees | CTE, `DENSE_RANK()`, `MAX` |
| 8 | Employees with Low Job Satisfaction | `WHERE`, filter & sort |
| 9 | Data Cleaning — Fix Performance Rating | `CASE WHEN`, `UPDATE`, `SET SQL_SAFE_UPDATES` |
| 10 | Inactive Employees (Resigned / Terminated) | `WHERE IN` |
| 11 | Employee Distribution per Region | `GROUP BY`, `COUNT` |
| 12 | Employees with Most Promotions | CTE, `DENSE_RANK()`, `SUM` |
| 13 | Promotion Rate per Department | `GROUP BY`, percentage calculation |

---

## 📌 Key Insights

- 💰 **Engineering and Legal** have the highest average salaries across all departments
- 🚨 **Data quality issue identified** — Job Satisfaction scores were misaligned with Performance Ratings and corrected via `UPDATE`
- 📉 Employees with low satisfaction scores (`< 3.0`) were flagged for HR review
- 🏆 Promotion rates vary significantly across departments, revealing potential equity gaps
- 🌍 **NCR dominates** employee headcount across all regions

---

## 🛠 Tools Used

- **MySQL** — Query execution and data cleaning
- **CSV Dataset** — `hr_employee_dataset.csv` (imported as `hrdata` table)

---

## 👤 Author

**Christian Kho Aler**
Aspiring Data Analyst | SQL • Excel • Power BI
[LinkedIn](https://linkedin.com) • [GitHub](https://github.com/chrissssy520)
