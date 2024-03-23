Create database musicsalesdata
#Who is senior most employee based on job title
select * from employee
order by levels desc
limit 1

#Which country has most invoices?
select count(*) as count, billing_country
from invoice
group by billing_country
order by count desc
limit 1

#what are the top3 values of total invoices
select total from invoice
order by total desc
limit 3

#Which city has best customers? Write a query that returns one city that has highest sum of invoice totals. 
Return both the city name & sum of all invoice totals
select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc
limit 1


#Write a query to return the customer who has spent the most money.
select sum(total) as amount_spent, c.customer_id, c.first_name, c.last_name  from customer c inner join invoice i on c.customer_id=i.customer_id
group by c.customer_id, c.first_name, c.last_name
order by amount_spent desc
limit 1


#write a query to return the email, first name, last name and genre of all rock music listeners. Return your list ordered alphabetically 
#by email starting with A.
select distinct email, first_name, last_name
from customer c inner join invoice i on i.customer_id=c.customer_id
join invoice_line il on il.invoice_id=i.invoice_id
where track_id IN(
select track_id from track t join genre g on t.genre_id=g.genre_id
where g.name='Rock')
order by email asc


#Query that returns the artist name and total track count of the top 10 rock bands.
select a.artist_id, a.name, count(a.artist_id) as no_of_songs
from track t join album2 al on t.album_id=al.album_id
join artist a  on a.artist_id=al.artist_id
join genre g on g.genre_id=t.genre_id
where g.name='Rock'
group by a.artist_id, a.name
order by no_of_songs desc
limit 10;


#Return all the song names that have length greater than average length. Return the name and millisecond for each track.
-- Ordered by length of the song, with longest song listed first.
select name, milliseconds
from track
where milliseconds >(
select avg(milliseconds) as avg_track_length
from track 
)
order by milliseconds desc

