به من

# 📊 Netflix Data Analysis with SQL

<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/0/08/Netflix_2015_logo.svg" alt="Netflix Logo" width="320"  />
</p>
## 📊 Dataset
**Source:** [Netflix Movies and TV Shows on Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows/versions/5?resource=download)  

## 📁 Project Overview

This project demonstrates SQL-based analysis of a Netflix dataset using PostgreSQL. The SQL queries are crafted to answer real-world business questions and uncover hidden patterns in content type, release trends, viewer preferences, and creative collaborations.

All queries are stored in a single SQL file:

```bash
solutions.sql
```

---

## 🧱 Table Schema

The dataset is stored in one table: `netflix`. Below is the schema used:

| Column | Data Type | Description |
|---------------|---------------|----------------------------------------|
| `show_id` | `VARCHAR(10)` | Unique ID for each show |
| `kind` | `VARCHAR(10)` | Type of content: 'Movie' or 'TV Show' |
| `title` | `VARCHAR(150)`| Title of the content |
| `director` | `VARCHAR(220)`| Director(s) of the content |
| `performers` | `VARCHAR(1000)`| List of cast members |
| `country` | `VARCHAR(150)`| Country where the content was produced |
| `date_added` | `VARCHAR(50)` | Date added to Netflix |
| `release_year`| `INT` | Year the content was released |
| `rating` | `VARCHAR(12)` | Maturity rating |
| `duration` | `VARCHAR(20)` | Length of the content (minutes/seasons)|
| `listed_in` | `VARCHAR(100)`| Genres/categories |
| `description` | `VARCHAR(255)`| Short summary |

---

## Business Questions Addressed

### 1.Content Overview
- How many titles are in the dataset?
- How many unique release years are there?
- What are the types of content available?

### 2.Top Countries
- Top 10 countries producing the most Netflix content

### 3. Duration Analysis
- What are the longest movies and TV shows on the platform?
- Which TV shows have more than 6 seasons?

### 4. Genre and Actor Trends
- Which genres are most common?
- Who are the top 10 actors in U.S.-produced movies?

### 5. Rating Insights
- What is the most common rating per content type?

### 6. Director-Actor Collaborations
- Which director-actor pairs have worked together the most?

---

## 🛠️ Key SQL Techniques Used

- **Aggregate Functions**: `COUNT()`, `GROUP BY`
- **Window Functions**: `RANK() OVER (PARTITION BY ...)`
- **CTEs (Common Table Expressions)**: For modular, readable subqueries
- **String Functions**: `SUBSTRING`, `STRING_TO_ARRAY`, `TRIM`, `UNNEST`
- **Filtering**: `WHERE`, `LIKE`, `IS NOT NULL`, Regex-based conditions
- **Sorting & Limiting**: `ORDER BY`, `LIMIT`



## How to Run

1. Load your dataset into a PostgreSQL-compatible database.
2. Create the `netflix` table using the schema provided.
3. Run the queries from `solutions.sql`.
4. Analyze or visualize the results using your preferred BI tool or SQL client.


---

