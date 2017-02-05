CREATE DATABASE db_library;

USE db_library;

CREATE TABLE books (id INT (11) PRIMARY KEY AUTO_INCREMENT, 
	librarian_id INT (11), author_id INT (11), publisher_id INT (11),
	place_id INT (11), title VARCHAR (255), sort_desc TEXT, stock INT (11), 
	date_added TIMESTAMP, date_update DATETIME, deleted INT (11));

CREATE TABLE category (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR (255));

CREATE TABLE book_category (category_id INT (11), book_id INT (11));

CREATE TABLE place (id INT (11) PRIMARY KEY AUTO_INCREMENT, 
	category_id INT (11), place VARCHAR (255));

CREATE TABLE librarian (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR (255), gender VARCHAR (255), username VARCHAR (255), 
	password VARCHAR (255), phone_number VARCHAR (255), address TEXT, 
	deleted INT (11));

CREATE TABLE librarian_log (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	librarian_id INT (11), last_login DATETIME);

CREATE TABLE members (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	librarian_id INT (11), name VARCHAR (255), gender VARCHAR (255), photo TEXT,
	date_added DATETIME, date_update TIMESTAMP, date_expired DATETIME, 
	deleted INT (11));

CREATE TABLE borrowing (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	member_id INT (11), librarian_id INT (11), date_added DATETIME, 
	date_update TIMESTAMP, deleted INT (11));

CREATE TABLE borrowing_items (id INT (11) PRIMARY KEY AUTO_INCREMENT, 
	borrow_id INT (11), book_id INT (11), librarian_id INT(11), quantity INT (11), 
	date_expired DATETIME, date_added DATETIME, date_update TIMESTAMP, 
	deleted INT (11));

CREATE TABLE returned (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	borrowing_id INT (11), librarian_id INT (11), date_added DATETIME, 
	date_update TIMESTAMP, deleted INT (11));

CREATE TABLE returned_items (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	returned_id INT (11), book_id INT (11), librarian_id INT (11), quantity INT (11), 
	returned_added DATETIME, date_added DATETIME, date_update TIMESTAMP, 
	deleted INT (11));

CREATE TABLE penalties (id INT (11) PRIMARY KEY AUTO_INCREMENT, 
	returned_id INT (11), libraian_id INT (11), nominal_of_pinalties INT (11),
	date_added DATETIME, date_update TIMESTAMP, deleted INT (11));

CREATE TABLE penalties_rules (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	number_of_days VARCHAR (255), noninal INT (11));

CREATE TABLE penalties_items (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	penalties_id INT (11), penalties_rules_id INT (11), book_id INT (11),
	librarian_id INT (11), number_of_penalties INT (11), date_added DATETIME,
	date_update TIMESTAMP, deleted INT (11));

CREATE TABLE author (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR (255), address TEXT, email VARCHAR (255), phone_number VARCHAR (255));

CREATE TABLE publisher (id INT (11) PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR (255), address TEXT, email VARCHAR(255), phone_number VARCHAR (255),
	website VARCHAR (255));

ALTER TABLE place RENAME TO rack;

ALTER TABLE books ADD FOREIGN KEY (librarian_id) REFERENCES librarian (id);

ALTER TABLE books ADD FOREIGN KEY (author_id) REFERENCES author (id);

ALTER TABLE books ADD FOREIGN KEY (publisher_id) REFERENCES publisher (id);

ALTER TABLE books CHANGE place_id rack_id INT (11);

ALTER TABLE books ADD FOREIGN KEY (rack_id) REFERENCES rack (id);

ALTER TABLE book_category ADD FOREIGN KEY (category_id) REFERENCES category (id);

ALTER TABLE book_category ADD FOREIGN KEY (book_id) REFERENCES books (id);

ALTER TABLE rack ADD FOREIGN KEY (category_id) REFERENCES category (id);

ALTER TABLE librarian_log ADD date_logout DATETIME;

ALTER TABLE librarian_log CHANGE last_login date_login DATETIME;

ALTER TABLE librarian_log ADD FOREIGN KEY (librarian_id) REFERENCES librarian (id);

ALTER TABLE members ADD FOREIGN KEY (librarian_id) REFERENCES librarian (id);

ALTER TABLE borrowing ADD FOREIGN KEY (member_id) REFERENCES members (id);

ALTER TABLE borrowing ADD FOREIGN KEY (librarian_id) REFERENCES librarian (id);

ALTER TABLE borrowing_items ADD FOREIGN KEY (borrow_id) REFERENCES borrowing (id);

ALTER TABLE borrowing_items ADD FOREIGN KEY (book_id) REFERENCES books (id);

ALTER TABLE borrowing_items ADD FOREIGN KEY (librarian_id) REFERENCES librarian (id);

ALTER TABLE returned ADD FOREIGN KEY (borrowing_id) REFERENCES borrowing (id);

ALTER TABLE returned ADD FOREIGN KEY (librarian_id) REFERENCES librarian (id);

ALTER TABLE returned_items ADD FOREIGN KEY (returned_id) REFERENCES returned (id);

ALTER TABLE returned_items ADD FOREIGN KEY (book_id) REFERENCES books (id);

ALTER TABLE returned_items ADD FOREIGN KEY (librarian_id) REFERENCES librarian (id);

ALTER TABLE penalties ADD FOREIGN KEY (returned_id) REFERENCES returned (id);

ALTER TABLE penalties CHANGE libraian_id librarian_id INT (11);

ALTER TABLE penalties ADD FOREIGN KEY (librarian_id) REFERENCES librarian (id);

ALTER TABLE penalties_items ADD FOREIGN KEY (penalties_id) REFERENCES penalties (id);

ALTER TABLE penalties_items ADD FOREIGN KEY (penalties_rules_id) REFERENCES penalties_rules (id);

ALTER TABLE penalties_items ADD FOREIGN KEY (book_id) REFERENCES books (id);

ALTER TABLE penalties_items ADD FOREIGN KEY (librarian_id) REFERENCES librarian (id);

INSERT INTO category (name) VALUES 
	('Agama'),
	('Biografi'),
	('Sains'),
	('Psikologi'),
	('Sastra'),
	('Sejarah'),
	('Novel');

ALTER TABLE rack CHANGE place name VARCHAR (255);

INSERT INTO rack (category_id, name) VALUES 
	(1, 'AGM01'),
	(2, 'BGRF01'), 
	(3, 'SNS01'), 
	(5, 'STSR01'), 
	(5, 'STSR02'), 
	(6, 'HSTR01'), 
	(6, 'HSTR02'), 
	(6, 'HSTR03'),
	(7, 'NVL01'), 
	(7, 'NVL02'), 
	(7, 'NVL03');

INSERT INTO publisher (name, address, email, phone_number, website) VALUES 
	('Pustaka Zahra', 'Jakarta Timur', 'pzahra@mail.com', '021-8092269', 'pustaka-zahra.com'),
	('PPM', 'Jakarta', 'ppm@mail.com', '021-2303247', 'ppm.com'), 
	('UI Press','Jakarta','uipress@mail.com','021-31935373', 'uipress.com'),
 	('Balai PUstaka', 'Jakarta', 'balaipustaka@mail.com', '021-2601234', 'balaipustaka.com'),
	('Samudra Buku','Jakarta Selatan','samudrabuku@mail.com','021-7509673','samudrabuku.com');

INSERT INTO author (name, address, email, phone_number) VALUES 
	('Raditya Dika','','rdtya@mail.com','081389774655'), 
	('Dewi Lestari','','dwlestari@mail.com','082289726752'),
	('Andrea Hirata','','andreahirata@mail.com','081389990255'), 
	('W.S. Rendra','','wsrendra@mail.com','082190872145'),
	('Pramoedya Ananta Toer','','ananta@mail.com','081374650255');

UPDATE author SET address = 'Jakarta';
UPDATE author SET address = 'Bandung' WHERE id = 2;
UPDATE author SET address = 'Jakarta Selatan' WHERE id = 3;

INSERT INTO librarian (name, gender, username, password, phone_number, address, deleted) VALUES 
	('Afran','Laki - Laki','afran','afran123','081212348765','Jakarta','0'),
	('Budi','Laki - Laki','budi','budi123','083287649038','Jakarta Selatan','0'), 
	('Sari','Perempuan','sari','sari123','087612345632','Jakarta Utara','0'), 
	('Dela','Perempuan','dela','dela1233','0876123587621','Jakarta','0'), 
	('Farhan','Laki - Laki','farhanuciha','farhan123','0825453278612','Bekasi','1');

 INSERT INTO author (name, address, email, phone_number) VALUES 
 	('Chairil Anwar','Sumatera Utara','canwar@mail.com','082289764736');

INSERT INTO books (librarian_id, author_id, publisher_id, rack_id, title, sort_desc, stock, date_update, deleted) VALUES
	(1, 6, 4, 11, 'Pulanglah Dia Si Anak Hilang', 'Si Anak Hilang Yang lama tak pulang akhirnya pulang ke rumah nya', 10, now(), 0 ),
	(1, 3, 4, 11, 'Laskar Pelangi', 'Laskar Pelangi menceritakan tentang kisah nyata dari sepuluh anak yang tinggal di sebuah desa di Belitung Timur.', 10, now(), 0),
	(2, 2, 4, 2, 'Biografi Farhan Mustaqiem', 'Biografi yang menceritakan kehidupan Farhan Mustaqiem', 3, now(), 0),
	(1, 2, 4, 2, 'Biografi Luki Sanjaya', 'Biografi yang menceritakan kehidupan Luki Sanjaya', 2, now(), 0),
	(2, 3, 5, 2, 'Biografi Afri Dermawan Ginting', 'Biografi yang menceritakan kehidupan Afri Dermawan Ginting', 4, now(), 0);
-- -----------------------------------------------------------------------------
INSERT INTO book_category (category_id, book_id) VALUES
	(2, 3),
	(2, 4),
	(2, 5),
	(7, 1),
	(7, 2);

INSERT INTO librarian_log (librarian_id, date_login, date_logout) VALUES
	(1, now(), now()),
	(1, now(), now()),
	(2, now(), now()),
	(2, now(), now()),
	(3, now(), now());


INSERT INTO members (librarian_id, name, gender, photo, date_added, date_expired, deleted) VALUES
	(1, 'Farhan Mustaqiem', 'Laki - Laki', '', now(), '2017-02-01', 0);

UPDATE members SET date_expired = '2018-02-03' WHERE id = 1;

INSERT INTO members (librarian_id, name, gender, photo, date_added, date_expired, deleted) VALUES
	(1, 'Afri Dermawan GInting', 'Laki - Laki',  '', now(), '2018-02-03', 0),
	(2, 'Luki Sanjaya', 'Laki - Laki', '', now(), '2018-02-03', 0),
	(2, 'Dewi Lestari', 'Perempuan', '', now(), '2018-02-03', 0),
	(1, 'Rina Saputri', 'Perempuan', '', now(), '2020-02-03', 0);

-- BELMU DITAMBAHKAN -----------------------------------------------------------
INSERT INTO borrowing (member_id, librarian_id, date_added, deleted) VALUES
	(1, 1, '2017-02-04', 0),
	(2, 1, '2017-02-04', 0),
	(3, 1, '2017-02-04', 0),
	(4, 1, '2017-02-04', 0),
	(5, 2, '2017-02-04', 0);


ALTER TABLE borrowing_items CHANGE borrow_id borrowing_id INT (11);

INSERT INTO borrowing_items (borrowing_id, book_id, librarian_id, quantity, date_expired, date_added, deleted) VALUES
	(1, 1, 1, 4, '2017-02-10', now(), 0),
	(1, 2, 1, 3, '2017-02-10', now(), 0),
	(2, 1, 1, 2, '2017-02-09', now(), 0),
	(2, 3, 1, 1, '2017-02-09', now(), 0),
	(3, 3, 2, 2, '2017-02-18', now(), 0),
	(4, 2, 2, 1, '2017-02-07', now(), 0),
	(5, 4, 2, 1, '2017-02-08', now(), 0);

INSERT INTO returned (`borrowing_id`, `librarian_id`, `date_added`, `deleted`) VALUES
	(1, 2, '2017-02-10', 0),
	(1, 2, '2017-02-11', 0),
	(2, 2, '2017-02-11', 0),
	(4, 3, '2017-02-07', 0),
	(5, 3, '2017-02-08', 0),
	(3, 3, '2017-03-18', 0);

INSERT INTO returned_items (`returned_id`, `book_id`, `librarian_id`, `quantity`, `returned_added`, `date_added`, `deleted`) VALUES
	(1, 1, 2, 4, '2017-02-10', '2017-02-10', 0),
	(1, 2, 2, 2, '2017-02-10', '2017-02-10', 0),
	(2, 2, 2, 1, '2017-02-11', '2017-02-11', 0), -- KENA DENDA 1
	(3, 1, 2, 2, '2017-02-11', '2017-02-11', 0), -- KENA DENDA 1
	(3, 3, 2, 1, '2017-02-11', '2017-02-11', 0), -- KENA DENDA 1
	(4, 2, 3, 1, '2017-02-12', '2017-02-12', 0), -- KENA DENDA 2
	(5, 4, 3, 1, '2017-02-08', '2017-02-08', 0),
	(6, 3, 3, 2, '2017-03-18', '2017-03-18', 0); -- KENA DENDA 5


ALTER TABLE penalties_rules CHANGE noninal nominal INT(11);

INSERT INTO penalties_rules (`number_of_days`,`nominal`) VALUES
	(3, 1500),
	(5, 3000),
	(7, 5000),
	(14, 50000),
	(30, 2000000); 

ALTER TABLE penalties CHANGE nominal_of_pinalties nominal_of_penalties INT (11);

INSERT INTO penalties (`returned_id`, `librarian_id`, `nominal_of_penalties`, `date_added`, `deleted`) VALUES
	(2, 2, 1500, '2017-02-11', 0),
	(3, 2, 4500, '2017-02-11', 0),
	(4, 3, 3000, '2017-02-12', 0),
	(6, 3, 200000, '2017-03-18', 0);

INSERT INTO penalties_items (`penalties_id`,`penalties_rules_id`,`book_id`,`librarian_id`,`number_of_penalties`,`date_added`,`deleted`) VALUES
	(1, 1, 2, 2, 1, '2017-02-11', 0),
	(2, 1, 1, 2, 2, '2017-02-11', 0),
	(2, 1, 3, 2, 2, '2017-02-11', 0),
	(3, 2, 2, 3, 5, '2017-02-12', 0),
	(4, 5, 3, 3, 30, '2017-03-18', 0);