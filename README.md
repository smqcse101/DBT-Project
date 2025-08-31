#  DBT SQL Solutions

This repository contains my solutions for different SQL tasks built with **DBT** on top of **Snowflake**.  
All the core solutions can be found in the **`models/solutions/`** folder, this is the main place to explore when reviewing my work.

---

##  Naming Convention

I have followed a consistent naming pattern to keep solutions organized and easy to navigate:

- **t1** → Task 1  
- **t2** → Task 2  
- **q1, q2, q3...** → Question numbers  

Example:  
`t1_q4_interesting_info.sql` → Task 1, Question 4.

---

##  Tools & Technologies
<img width="317" height="273" alt="image" src="https://github.com/user-attachments/assets/f5ca7a92-22f8-41dc-be6e-9f75cd70977f" />
<img width="317" height="277" alt="image" src="https://github.com/user-attachments/assets/26c9c99b-bd0b-4313-a3e2-f6395a8afd58" />
<img width="226" height="221" alt="image" src="https://github.com/user-attachments/assets/4c0af9c6-f563-4b96-b4dc-bbb6ce877601" />
<img width="593" height="330" alt="image" src="https://github.com/user-attachments/assets/264519b7-b896-4da6-a625-d940633ee1d5" />

- **Snowflake** → Data warehouse. Here the actually is actually stored and compute happens.
- **DBT (Data Build Tool)** → Modeling and transformations  
- **SQL** → Querying and analysis  
- *(Optional)* **Power BI** → Used to visualize insights  

---

## Lineage Graphs

DBT also provides lineage graphs to show how staging tables flow into final solution models.  
In the below screen shot we can see that from source to the final model how ref() functions helps use to build Lineage.
<img width="1398" height="382" alt="image" src="https://github.com/user-attachments/assets/004fe786-22e3-4fdd-9de2-7d7ac3061a72" />

---

## ✨ Author

Prepared by ** Syed Mustafa Quadri**  
Master’s in Data Science | TU Hamburg  
Focused on Data Engineering, SQL, and Business Insights :))
