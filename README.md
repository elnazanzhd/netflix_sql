# 📺 Netflix Content Analysis
![Netflix Logo](https://upload.wikimedia.org/wikipedia/commons/7/77/Netflix_avatar_logo.png)

## 📊 Dataset
**Source:** [Netflix Movies and TV Shows on Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows/versions/5?resource=download)  
**Records:** 8,807 (5,371 Movies | 2,676 TV Shows)  
**Last Updated:** November 2021  

## 🗃️ Database Schema
```sql
CREATE TABLE netflix(
    show_id VARCHAR(10),
    kind VARCHAR(10),
    title VARCHAR(150),
    director VARCHAR(220),
    performers VARCHAR(1000),
    country VARCHAR(150),
    date_added VARCHAR(50),    
    release_year INT,
    rating VARCHAR(12),
    duration VARCHAR(20),
    listed_in VARCHAR(100),
    description VARCHAR(255)
);
