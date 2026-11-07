# Restaurant & Food Delivery Business Performance Analysis

## Project Overview

This is an independent data analytics portfolio project focused on analyzing restaurant and food delivery business performance.

The project uses SQL to clean, transform, and analyze food delivery order data. Microsoft Excel is used to build a dashboard that presents key performance indicators, business trends, and operational insights.

The goal is to convert raw data into meaningful insights that can support business decision-making.

## Business Objectives

- Evaluate overall order performance and order value.
- Identify top-performing restaurants.
- Analyze customer ordering patterns.
- Compare weekday and weekend order demand.
- Understand demand across different cuisine categories.
- Evaluate food preparation and delivery efficiency.
- Generate actionable business insights.

## Tools & Technologies

- **MySQL:** Data cleaning, transformation, and SQL analysis.
- **Microsoft Excel:** Dashboard creation, charts, and visualization.
- **GitHub:** Project documentation and version control.

## Dataset Overview

The dataset contains restaurant and food delivery order information.

| Metric | Value |
|---|---:|
| Total Records | 1,898 |
| Total Columns | 9 |
| Unique Orders | 1,898 |
| Unique Customers | 1,200 |
| Unique Restaurants | 178 |
| Cuisine Categories | 14 |

### Dataset Columns

| Column | Description |
|---|---|
| `order_id` | Unique order identifier |
| `customer_id` | Customer identifier |
| `restaurant_name` | Restaurant name |
| `cuisine_type` | Cuisine category |
| `cost_of_the_order` | Recorded order cost |
| `day_of_the_week` | Weekday or weekend |
| `rating` | Customer rating |
| `food_preparation_time` | Preparation time in minutes |
| `delivery_time` | Delivery time in minutes |

## Data Cleaning & Preparation

The following steps were performed using MySQL:

- Created a database and imported the raw dataset.
- Checked for duplicate order IDs.
- Identified missing and invalid values.
- Converted `Not given` ratings into NULL values.
- Converted ratings into a numeric data type.
- Created a cleaned table for further analysis.
- Validated the cleaned data before performing business analysis.

## Key Performance Indicators

| KPI | Result |
|---|---:|
| Total Orders | 1,898 |
| Total Order Value | $31,314.82 |
| Average Order Value | $16.50 |
| Average Customer Rating | 4.34 / 5 |
| Average Food Preparation Time | 27.37 minutes |
| Average Delivery Time | 24.16 minutes |

*Note: Total order value represents the sum of recorded order costs, not company profit or confirmed revenue. Average rating excludes missing ratings.*

## Key Business Insights

### 1. Restaurant Performance
- Shake Shack recorded the highest order count, with 219 orders.
- It also recorded the highest total order value of $3,579.53.
- The Meatball Shop and Blue Ribbon Sushi were among the other top-performing restaurants.

### 2. Customer & Ordering Behavior
- The dataset contains 1,200 unique customers.
- Weekday and weekend order patterns were analyzed to understand differences in demand.

### 3. Cuisine Analysis
- Analyzed order demand across 14 cuisine categories.
- Compared cuisine categories based on order volume and recorded order value.

### 4. Operational Analysis
- Average food preparation time was 27.37 minutes.
- Average delivery time was 24.16 minutes.
- These metrics provide an overview of operational performance.

## Excel Dashboard

An Excel dashboard was developed to present the analysis visually.

The dashboard includes:

- Key business performance indicators.
- Top restaurants by order value.
- Cuisine-wise order demand.
- Weekday vs. weekend order comparison.
- Average delivery time comparison.

## Project Structure

```text
restaurant-food-delivery-analysis/
│
├── README.md
├── food_delivery_business_analysis.sql
└── food_delivery_professional_dashboard.xlsx
```

## Skills Demonstrated

- SQL querying and data analysis
- Data cleaning and validation
- Aggregate functions and GROUP BY
- Joins and subqueries
- Common Table Expressions (CTEs)
- Window functions
- Business analysis and KPI reporting
- Excel dashboard development
- Data visualization
- Business insight generation

## Project Limitations

- The dataset does not contain calendar dates, so monthly, quarterly, and yearly trends could not be analyzed.
- Some customer ratings were not provided and were excluded from average rating calculations.
- The dataset does not include profit, restaurant expenses, or delivery partner costs.

## Conclusion

This project demonstrates how MySQL and Microsoft Excel can be used together to transform raw food delivery data into meaningful business insights.

The analysis highlights restaurant performance, customer ordering behavior, cuisine demand, and operational metrics that can help businesses better understand their performance and identify opportunities for improvement.
