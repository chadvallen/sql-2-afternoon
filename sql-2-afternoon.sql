-- SQL AFTERNOON 2 ANSWERS

-- Practice joins
-- #1
select *
from Invoice i
join InvoiceLine il 
on il.invoiceId = i.invoiceId
where il.UnitPrice > 0.99;

-- #2
select i.InvoiceDate, c.FirstName, c.LastName, i.Total
from Invoice i
join Customer c
on i.CustomerId = c.CustomerId;

-- #3
select c.FirstName, c.LastName, e.FirstName, e.LastName
from Customer c
join Employee e
on c.SupportRepId = e.EmployeeId;

-- #4
select a.Title, ar.Name
from Album a
join Artist ar
on a.ArtistId = ar.ArtistId;

-- #5
 select pt.TrackId
 from PlaylistTrack pt
 join Playlist p
 on p.PlaylistId = pt.PlaylistId
 where p.Name = 'Music';
 
--  #6
select t.Name
from Track t
join PlaylistTrack p
on t.TrackId = p.TrackId
where p.PlaylistId = 5;

-- #7
select t.Name, p.Name
from Track t
join PlaylistTrack pt
on t.TrackId = pt.TrackId
join Playlist p
on pt.PlaylistId = p.PlaylistId;

-- #8
select t.Name, a.Title
from Track t
join Album a on t.AlbumId = a.AlbumId
join Genre g on g.GenreId = t.GenreId
where g.Name = 'Alternative';

-- Practice nested queries
-- #1
select *
from Invoice 
where InvoiceId 
in ( select InvoiceId from InvoiceLine where UnitPrice > 0.99);

-- #2
select *
from PlaylistTrack
where PlaylistId in ( select PlaylistId from Playlist where Name = 'Music');

-- #3
select Name
from Track
where TrackId in (select TrackId from PlaylistTrack where PlaylistId = 5);

-- #4
select *
from Track
where GenreId in (select GenreId from Genre where Name = 'Comedy');

-- #5
select *
from Track
where AlbumId in (select AlbumId from Album where Title = 'Fireball');

-- #6
select *
from Track
where AlbumId in (select AlbumId from Album where ArtistId in 
                  (select ArtistId from Artist where Name = 'Queen'));


-- Practice updating Rows
-- #1
update Customer
set Fax = null
where Fax is not null;

-- #2
update Customer
set Company = 'Self'
where Company is null;

-- #3
update Customer 
set LastName = 'Thompson'
where FirstName = 'Julia' and LastName = 'Barnett';

-- #4
update Customer
set SupportRepId = 4
where Email = 'luisrojas@yahoo.cl';

-- #5
update Track
set Composer = 'The darkness around us'
where GenreId = (select GenreId from Genre where Name = 'Metal')
and Composer is null;


-- Group by
-- #1
select count(*), g.Name
from Track t
join Genre g on t.GenreId = g.GenreId
group by g.Name;

-- #2
select count(*), g.Name
from Track t
join Genre g on t.GenreId = g.GenreId
where g.Name = 'Pop' or g.Name = 'Rock'
group by g.Name;

-- #3
select ar.Name, count(*)
from Artist ar
join Album ab on ar.ArtistId = ab.ArtistId
group by ab.ArtistId;


-- Use Distinct
-- #1
select distinct Composer
from Track;

-- #2
select distinct BillingPostalCode
from Invoice;

-- #3
select distinct Company
from Customer;

-- Delete Rows
-- #1
delete from practice_delete
where type = 'bronze';

-- #2
delete from practice_delete
where type = 'silver';

-- #3
delete from practice_delete
where value = 150;


create table users (
  id serial primary key,
  name varchar(25),
  email text
 );
 
insert into users (name, email)
 values('chad', 'chad@chad.com'),
 ('hunter', 'hunter@hunter.com'),
 ('dan', 'dan@dan.com');

create table products (
    id serial primary key,
    name varchar(25),
    price int
);

insert into products (name, price)
values('longboard', 45),
('in n out', 5),
('movie ticket', 7);

create table orders (
    id serial primary key,
    product_id int references products(id),
    user_id int references users(id),
    qty int
);

insert into orders (product_id, user_id, qty)
values(1, 1, 1),
(2, 2, 4),
(3, 3, 3);

-- First order
select *
from orders o
join products p on o.product_id = p.id
where o.id = 1;

-- All orders
select *
from orders o
join products p on o.product_id = p.id;

-- Total cost
select sum(o.qty * p.price)
from orders o
join products p on o.product_id = p.id
where o.id = 2;
-- Answer: 20


