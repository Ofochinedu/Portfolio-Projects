
----CHALLENGE QUESTIONS
Select *
From Netflix..netflix_titles


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
	Count(release_year) as "Most Popular Year"
From Netflix..netflix_titles
Group by release_year
Order by 2 desc


----QUESTION NO. 6 - YEAR MOST CONTENT GOT ADDED
Select
	Top 1 year_added,
	Count(year_added) as "Most Content Added"
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


------QUESTION NO. 8 - THE TOP 5 MOST POPULAR MOVIE GENRE
--Select
--	Listed_in,
--	Charindex(' ', Listed_in),
--	Len(Listed_in),
--	--substring(Listed_in,1, Charindex(',', Listed_in) +1),
--	left(Listed_in, Charindex(',', Listed_in)-1)
--From Netflix..netflix_titles