
----CHALLENGE QUESTIONS
----QUESTION NO. 1 - FIND MISSING DATA AND DEAL WITH IT ACCORDINGLY
Select *
From Netflix..netflix_titles
Where date_added is null

delete
From Netflix..netflix_titles
Where date_added is null


----QUESTION NO. 2 - ADD COLUMN YEAR_ADDED FROM DATE_ADDED COLUMN
Alter Table Netflix..netflix_titles
Add year_added int

Update Netflix..netflix_titles
Set year_added = Year (date_added)

Select year_added
From Netflix..netflix_titles


----QUESTION NO. 3 - ADD COLUMN MONTH_ADDED FROM DATE_ADDED COLUMN
Alter Table Netflix..netflix_titles
Add month_added int

Update Netflix..netflix_titles
Set month_added = Month (date_added)

Select month_added
From Netflix..netflix_titles


----QUESTION NO. 5 - MOST POPULAR RELEASE YEAR
Select
	Top 1
	Release_year,
	Count(release_year) as "Count Most Popular"
From Netflix..netflix_titles
Group by release_year
Order by 2 desc


----QUESTION NO. 6 - YEAR MOST CONTENT GOT ADDED
Select
	Top 1 year_added,
	Count(year_added) as "Count Most Content"
From Netflix..netflix_titles
Group by year_added
Order by 2 desc


----QUESTION NO. 7 - MOVIE WITH THE LONGEST TITLE
Select
	Top 1 title,
	Max(len(title)) title_length
From Netflix..netflix_titles
Group by title
Order by 2 desc
