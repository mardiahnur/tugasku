create database nilai_mahasiswa;

--create table

CREATE TABLE mahasiswa (
    mahasiswa_id INT PRIMARY KEY,
    nama_mahasiswa VARCHAR(255) NOT NULL,
    nim VARCHAR(255) not NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE semester (
    mahasiswa_id INT PRIMARY KEY,
    semester VARCHAR(255) NOT NULL   
);

CREATE TABLE matkul (
    matkul_id INT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL
);

ALTER TABLE public.semester RENAME COLUMN mahasiswa_id TO semester_id;

drop table semester;

CREATE TABLE semester (
    semester_id INT PRIMARY KEY,
    semester VARCHAR(255) NOT NULL   
);

CREATE TABLE nilai (
    nilai_id INT PRIMARY KEY,
    mahasiswa_id INT not NULL,
    matkul_id INT not null,
    semester_id INT not null,
    nilai INT,
    
    foreign key (mahasiswa_id) references mahasiswa(mahasiswa_id),
    foreign key (matkul_id) references matkul(matkul_id),
    foreign key (semester_id) references semester(semester_id),
    Unique(mahasiswa_id, matkul_id, semester_id)
    
);

insert into mahasiswa(mahasiswa_id, nama_mahasiswa, nim, email, password) values
(1, 'mardiahnur', '2020122001', 'rahmimardiah92@gmail.com', '1234'),
(2, 'heriansyah', '1025130291', 'mutasibkpsdm@gmail.com', '1111'),
(3, 'alifah', '1212121212', 'rahmibasokaraeng@gmail.com', '4321');

insert into matkul(matkul_id, nama) values
(10, 'pemograman visual'),
(11, 'sistem operasi'),
(12, 'elektronika digital');

insert into semester(semester_id, semester) values
(1, 'semester satu'),
(2, 'semester dua'),
(3, 'semester tiga');

insert into nilai(nilai_id, mahasiswa_id, matkul_id, semester_id, nilai) values
(20, 1, 10, 1, 80),
(30, 1, 11, 2, 90),
(40, 1, 12, 3, 85),
------------------
(1, 2, 10, 1, 80),
(2, 2, 11, 2, 90),
(3, 2, 12, 3, 85),
------------------
(5, 3, 10, 1, 80),
(6, 3, 11, 2, 90),
(7, 3, 12, 3, 80);

--mata kuliah yang diikuti terbagi untuk tiap semester
select mahasiswa.nim as nim, matkul.nama as matkul, nilai.nilai as nilai
from mahasiswa
join nilai on mahasiswa.mahasiswa_id = nilai.mahasiswa_id
join matkul on nilai.matkul_id = nilai.matkul_id
join semester on nilai.semester_id = semester.semester_id
where semester.semester  = 'semester dua';

-- rata rata nilai per mahasiswa secara keseluruhan
select mahasiswa.nim, avg(nilai.nilai) as rata_rata_nilai
from mahasiswa
join nilai on mahasiswa.mahasiswa_id = nilai.mahasiswa_id
group by mahasiswa.nim;


-- rata rata nilai per mahasiswa per semester
select mahasiswa.nim as nim, semester.semester_id as semester, avg(nilai.nilai) as rata_rata
from mahasiswa
join nilai on mahasiswa.mahasiswa_id = nilai.mahasiswa_id
join semester on nilai.semester_id = semester.semester_id
group by mahasiswa.nim, semester.semester_id 
order by mahasiswa.nim asc;