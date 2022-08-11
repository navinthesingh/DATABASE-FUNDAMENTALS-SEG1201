-----------------------------------------------------------------------
-- NOTE : make sure that the ORACLE default date setting is correct - 
-- need to check the default setting for date
-- SELECT sysdate FROM dual; 
-- Authors: -> Teo Wei Shuen
--          -> Naveen Ramarao
--          -> Navinder Singh
--          -> Lim Ee Hui
-----------------------------------------------------------------------


ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

-- Drop tables to reset values
DROP TABLE maintenance;
DROP TABLE vehicle_sold;
DROP TABLE vehicle_for_sale;
DROP TABLE vehicle_model;
DROP TABLE salesperson;
DROP TABLE mechanic;
DROP TABLE customer;
DROP TABLE people_info;

-- Recreate the tables
CREATE TABLE people_info ( 
      info_id CHAR(5) PRIMARY KEY,
      first_name VARCHAR(40), 
      last_name VARCHAR(40),
      city VARCHAR(40) ,
      contact_number NUMBER(11),
      status VARCHAR(11),
      CONSTRAINT check_status CHECK (status = 'CUSTOMER' or status = 'SALESPERSON' or status = 'MECHANIC' ) 
      );

CREATE TABLE customer ( 
      cust_id CHAR(5) PRIMARY KEY, 
      info_id CHAR(5),
      address VARCHAR(100),
      FOREIGN KEY (info_id) REFERENCES people_info (info_id)  
      ) ;


CREATE TABLE salesperson ( 
    salesperson_id CHAR(5) PRIMARY KEY,
    info_id CHAR(5),
    branch_name VARCHAR(10),
    monthly_salary NUMBER(7),
    commission_rate NUMBER(4,3),
    join_date DATE,
    resign_date DATE,
    FOREIGN KEY (info_id) REFERENCES people_info (info_id),
    CONSTRAINT check_salary CHECK (monthly_salary<=84000 and monthly_salary>=55000),
    CONSTRAINT check_branch CHECK (branch_name= 'HQ' or branch_name='Wako' or branch_name= 'Shirako' or branch_name='Yaesu')
    );

CREATE TABLE mechanic (
    mechanic_id CHAR(5) PRIMARY KEY,
    info_id CHAR(5),
    branch_name VARCHAR(10),
    monthly_salary NUMBER(6),
    join_date DATE,
    resign_date DATE,
    FOREIGN KEY (info_id) REFERENCES people_info(info_id),  
    CONSTRAINT check_salary2 CHECK (monthly_salary<=68000 and monthly_salary>=55000)
);

CREATE TABLE vehicle_model (
    model_code VARCHAR(30) PRIMARY KEY,
    model_name VARCHAR(30),
    engine_series VARCHAR(30),
    engine_horsepower VARCHAR(30),
    engine_RPM VARCHAR(30),
    manufactured_year NUMBER(4)
);

CREATE TABLE vehicle_for_sale (
    VIN CHAR(5) PRIMARY KEY,
    model_code VARCHAR(30),
    colour VARCHAR(20),
    FOREIGN KEY (model_code) REFERENCES vehicle_model (model_code)
   
);

CREATE TABLE vehicle_sold (
    vehicle_sold_id CHAR(5) PRIMARY KEY,
    VIN CHAR (5),
    vehicle_sold_date DATE,
    cust_id CHAR(5),
    salesperson_id CHAR(5),
    agreed_price NUMBER(8),
    warranty_years NUMBER(1),
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id),
    FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id),
    FOREIGN KEY (VIN) REFERENCES vehicle_for_sale(VIN),
    CONSTRAINT check_date2 CHECK (vehicle_sold_date BETWEEN date '2016-01-01' AND date '2099-12-31')  
);

CREATE TABLE maintenance (
    maintenance_id CHAR(5) PRIMARY KEY,
    maintenance_date DATE,
    vehicle_sold_id CHAR(5),
    mechanic_id CHAR(5),
    serviced_parts VARCHAR(10),
    maintenance_cost NUMBER(5),
    FOREIGN KEY (vehicle_sold_id) REFERENCES vehicle_sold(vehicle_sold_id),
    FOREIGN KEY (mechanic_id) REFERENCES mechanic(mechanic_id),
    CONSTRAINT check_date CHECK (maintenance_date BETWEEN date '2016-01-01' AND date '2099-12-31') 
);

-- Indexing the database
CREATE INDEX names ON people_info (first_name, last_name);

-- Insert dummy values into each tables
INSERT INTO people_info VALUES ('I1001', 'Rie', 'Shibuya', 'Nagoya', 81819796448 , 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1002', 'Saki', 'Kuwahara', 'Toyohashi', 81114556672, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1003', 'Kohaku', 'Taira', 'Ichinomiya', 81114650992, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1004', 'Mayumi', 'Sando', 'Handa', 81145470232, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1005', 'Kayo', 'Hino', 'Seto', 81124470672, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1006', 'Kiyomi', 'Okada', 'Handa', 81188670232, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1007', 'Atsuko', 'Fujimoto', 'Kasugai', 8113443032, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1008', 'Jack', 'Mah', 'Toyokawa', 81124472032, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1009', 'Kazumi', 'Kawano', 'Tsushima', 81118886297, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1010', 'Suzu', 'Shiraki', 'Hekinan', 81128988504, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1011', 'Ayano', 'Ono', 'Kariya', 81174563789, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1012', 'Tatsuo', 'Kishi', 'Toyota', 81144003439, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1013', 'Susumu', 'Kuba', 'Anjō', 81104164213, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1014', 'Kyou', 'Usui', 'Nishio', 81185896519, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1015', 'Mana', 'Maekawa', 'Gamagōri', 81147489978, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1016', 'Shuji', 'Fujiwara', 'Inuyama', 81111165557, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1017', 'Kyo', 'Doi', 'Tokoname', 81115540476, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1018', 'Shiro', 'Shiraki', 'Kōnan', 81109887582, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1019', 'Nao', 'Matsuzaki', 'Komaki', 81184612168, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1020', 'Chiyo', 'Yamamoto', 'Inazawa', 81118886977, 'CUSTOMER'); 
INSERT INTO people_info VALUES ('I1021', 'Yumiko', 'Tanji', 'Tōkai', 81134586977, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1022', 'Emi', 'Yokoyama', 'Komaki', 81128859677, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1023', 'Hisoka', 'Yoshioka', 'Gamagōri', 81134586977, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1024', 'Takao', 'Matsuyama', 'Gamagōri', 81148886789, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1025', 'Noboru', 'Shiraki', 'Tōkai', 81128886309, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1026', 'Takahiro', 'Goda', 'Tōkai', 81108840958, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1027', 'Toshiyuki', 'Shiraki', 'Tōkai', 81128886304, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1028', 'Katsumi', 'Tanigawa', 'Tōkai', 81135066977, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1029', 'Yuki', 'Asa', 'Ōbu', 81123359672, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1030', 'Minako', 'Nakama', 'Ōbu', 81168882097, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1031', 'Hiroyuki', 'Ueda', 'Chita', 81178309977, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1032', 'Iwao', 'Miyazaki', 'Chiryū', 81128886309, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1033', 'Mayumi', 'Takata', 'Takahama', 81138886497, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1034', 'Reiko', 'Kuse', 'Owariasahi', 81148886708, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1035', 'Takeo', 'Kanno', 'Nisshin', 81140786977, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1036', 'Yoshio', 'Mino', 'Aisai', 81128886077, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1037', 'Hachiro', 'Shintani', 'Kiyosu', 81138886077, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1038', 'Amaterasu', 'Mizuno', 'Kiyosu', 81128860798, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1039', 'Aiko', 'Maruyama', 'Kitanagoya', 81188886102, 'SALESPERSON'); 
INSERT INTO people_info VALUES ('I1040', 'Yasuhiro', 'Wakabayashi', 'Yatomi', 81128886103, 'SALESPERSON');
INSERT INTO people_info VALUES ('I1041', 'Katashi', 'Asa', 'Nagakute', 81128886120, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1042', 'Masaki', 'Kodama', 'Ōdate', 81134686977, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1043', 'Miyako', 'Kono', 'Kazuno', 81138886607, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1044', 'Yuki', 'Nakano', 'Daisen', 81128886456, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1045', 'Masayoshi', 'Ando', 'Katagami', 81138886507, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1046', 'Hideko', 'Minami', 'Kurume', 81128830477, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1047', 'Nori', 'Iwamoto', 'Chikuma', 81118886507, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1048', 'Hideaki', 'Kaneshiro', 'Sanjō', 81128886708, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1049', 'Masumi', 'Shimoda', 'Bungotakada', 81118886000, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1050', 'Kame', 'Ono', 'Bungo-ōno', 81118886506, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1051', 'Aika', 'Takai', 'Sōja', 81124566900, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1052', 'Osamu', 'Hamasaki', 'Takahashi', 81138886203, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1053', 'Tatsuya', 'Hitani', 'Osaka', 81128886102, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1054', 'Takeshi', 'Imada', 'Bizen', 81156786304, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1055', 'Hideo', 'Nakatomi', 'Setouchi', 81125066910, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1056', 'Hatari', 'Nanawo', 'Mimasaka', 81118886102, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1057', 'Ichika', 'Nanako', 'Ibara', 81134886109, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1058', 'Miku', 'Nanako', 'Taketa', 81128507977, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1059', 'Nino', 'Nanako', 'Taketa', 81138306977, 'MECHANIC');  
INSERT INTO people_info VALUES ('I1060', 'Yotsuba', 'Nanako', 'Uonuma', 81124056977, 'MECHANIC'); 
INSERT INTO people_info VALUES ('I1061', 'Itsuki', 'Nanako', 'Uonuma', 81344566977, 'MECHANIC'); 

INSERT INTO customer VALUES ('C2001', 'I1001', '10-32, Akasaka 8 Chome, Nagoya, Aichi');
INSERT INTO customer VALUES ('C2002', 'I1002', '406-1192, Yokkaichiba, Toyohashi, Aichi');
INSERT INTO customer VALUES ('C2003', 'I1003', '377-1289, Higashiimaizumi, Ichinomiya, Aichi');
INSERT INTO customer VALUES ('C2004', 'I1004', '200-1249, Soneai, Handa, Aichi');
INSERT INTO customer VALUES ('C2005', 'I1005', '454-1134, Mizusawaku Hanazonocho, Seto, Iwate');
INSERT INTO customer VALUES ('C2006', 'I1006', '149-1199, Asahimachi, Handa, Hokkaido');
INSERT INTO customer VALUES ('C2007', 'I1007', '172-1074, Nishishinjuku Tokyooperashitei(11-kai), Kasugai, Tokyo');
INSERT INTO customer VALUES ('C2008', 'I1008', '457-1279, Toyotomicho Kodani, Toyokawa, Hyogo');
INSERT INTO customer VALUES ('C2009', 'I1009', '431-1121, Shibacho, Tsushima, Aichi');
INSERT INTO customer VALUES ('C2010', 'I1010', '43-434, Nihonbashi 2-chome, Hekinan, Tokyo');
INSERT INTO customer VALUES ('C2011', 'I1011', '506-1290, Shimoatarashicho, Kariya, Kyoto');
INSERT INTO customer VALUES ('C2012', 'I1012', '292-1043, Akane, Toyota, Aichi');
INSERT INTO customer VALUES ('C2013', 'I1013', '477-1227, Fushikidocho, Anjo, Hokkaido');
INSERT INTO customer VALUES ('C2014', 'I1014', '329-1200, Mukai, Nishio, Mie');
INSERT INTO customer VALUES ('C2015', 'I1015', '308-1290, Sarufutsu, Gamagori, Hokkaido');
INSERT INTO customer VALUES ('C2016', 'I1016', '191-1251, Shimoyanagicho, Inuyama, Kyoto');
INSERT INTO customer VALUES ('C2017', 'I1017', '245-1201, Omiya, Tokoname, Tokyo');
INSERT INTO customer VALUES ('C2018', 'I1018', '180-1091, Fukasaku, Konan, Saitama');
INSERT INTO customer VALUES ('C2019', 'I1019', '320-1125, Kureda, Komaki, Okayama');
INSERT INTO customer VALUES ('C2020', 'I1020', '412-1129, Shimojima, Inazawa, Kochi');

INSERT INTO salesperson VALUES ('S3001', 'I1021', 'HQ', 55000, 0.16, '04-12-2018', '');
INSERT INTO salesperson VALUES ('S3002', 'I1022', 'Wako' , 57000, 0.14, '05-11-2020', '06-10-2021');
INSERT INTO salesperson VALUES ('S3003', 'I1023', 'Shirako', 80000, 0.16, '30-09-2014', '');
INSERT INTO salesperson VALUES ('S3004', 'I1024', 'Yaesu', 70000, 0.14, '11-11-2015', '');
INSERT INTO salesperson VALUES ('S3005', 'I1025', 'Shirako', 75000, 0.16, '20-12-2014', '');
INSERT INTO salesperson VALUES ('S3006', 'I1026', 'Shirako', 65000, 0.13, '21-01-2016', '');
INSERT INTO salesperson VALUES ('S3007', 'I1027', 'Wako' ,59000, 0.13, '19-01-2018', '');
INSERT INTO salesperson VALUES ('S3008', 'I1028', 'Wako' ,71000, 0.15, '10-01-2016', '');
INSERT INTO salesperson VALUES ('S3009', 'I1029', 'Shirako', 55000, 0.2, '05-06-2021', '');
INSERT INTO salesperson VALUES ('S3010', 'I1030', 'Wako' ,67000, 0.14, '04-08-2013', '');
INSERT INTO salesperson VALUES ('S3011', 'I1031', 'Shirako', 69000, 0.14, '19-10-2014', '');
INSERT INTO salesperson VALUES ('S3012', 'I1032', 'Yaesu', 70000, 0.20, '20-10-2017', '');
INSERT INTO salesperson VALUES ('S3013', 'I1033', 'Shirako', 80000, 0.25, '27-02-2014', '');
INSERT INTO salesperson VALUES ('S3014', 'I1034', 'HQ', 81000, 0.25, '20-11-2014', '');
INSERT INTO salesperson VALUES ('S3015', 'I1035', 'HQ', 82000, 0.30, '01-05-2014', '05-06-2020');
INSERT INTO salesperson VALUES ('S3016', 'I1036', 'HQ', 83000, 0.30, '07-07-2014', '');
INSERT INTO salesperson VALUES ('S3017', 'I1037', 'HQ', 84000, 0.27, '10-10-2014', '');
INSERT INTO salesperson VALUES ('S3018', 'I1038', 'HQ', 56000, 0.15, '11-11-2020', '');
INSERT INTO salesperson VALUES ('S3019', 'I1039', 'Yaesu', 57000, 0.16, '19-08-2020', '');
INSERT INTO salesperson VALUES ('S3020', 'I1040', 'Wako', 84000, 0.30, '01-12-2014', '07-07-2021');

INSERT INTO mechanic VALUES ('M4001', 'I1041', 'Yaesu', 55000, '28-05-2015', '11-11-2021');
INSERT INTO mechanic VALUES ('M4002', 'I1042', 'Yaesu', 68000, '20-01-2014', '');
INSERT INTO mechanic VALUES ('M4003', 'I1043', 'HQ', 56000, '10-05-2018', '');
INSERT INTO mechanic VALUES ('M4004', 'I1044', 'HQ', 60000, '25-01-2015', '');
INSERT INTO mechanic VALUES ('M4005', 'I1045', 'HQ', 65000, '15-05-2014', '06-05-2020');
INSERT INTO mechanic VALUES ('M4006', 'I1046', 'Shirako', 57000, '10-10-2017', '');
INSERT INTO mechanic VALUES ('M4007', 'I1047', 'Shirako', 59000, '07-11-2017', '');
INSERT INTO mechanic VALUES ('M4008', 'I1048', 'Wako' ,61000, '01-08-2015', '');
INSERT INTO mechanic VALUES ('M4009', 'I1049', 'Wako' ,62000, '11-04-2015', '');
INSERT INTO mechanic VALUES ('M4010', 'I1050', 'Wako' ,63000, '19-05-2015', '17-11-2021');
INSERT INTO mechanic VALUES ('M4011', 'I1051', 'Wako' ,64000, '20-12-2014', '');
INSERT INTO mechanic VALUES ('M4012', 'I1052', 'Shirako', 65000, '22-06-2014', '');
INSERT INTO mechanic VALUES ('M4013', 'I1053', 'Yaesu', 66000, '22-04-2014', '');
INSERT INTO mechanic VALUES ('M4014', 'I1054', 'Shirako', 63000, '10-01-2015', '');
INSERT INTO mechanic VALUES ('M4015', 'I1055', 'Shirako', 58000, '30-10-2017', '');
INSERT INTO mechanic VALUES ('M4016', 'I1056', 'Wako' ,59000, '31-12-2018', '');
INSERT INTO mechanic VALUES ('M4017', 'I1057', 'Yaesu', 60000, '29-10-2016', '');
INSERT INTO mechanic VALUES ('M4018', 'I1058', 'Yaesu', 55000, '30-01-2019', '');
INSERT INTO mechanic VALUES ('M4019', 'I1059', 'Yaesu', 56000, '01-09-2020', '10-03-2021');
INSERT INTO mechanic VALUES ('M4020', 'I1060', 'Yaesu', 57000, '01-01-2017', '');
INSERT INTO mechanic VALUES ('M4021', 'I1061', 'Yaesu', 57000, '01-01-2017', '');

INSERT INTO vehicle_model VALUES ('M0001','Honda Civic','C Series Engine','158 HP','5800', 2016); 
INSERT INTO vehicle_model VALUES ('M0002','Honda Accord','B Series Engine','192 HP','6500', 2016); 
INSERT INTO vehicle_model VALUES ('M0003','Honda CR-V','D Series Engine','190 HP','7000',2017); 
INSERT INTO vehicle_model VALUES ('M0004','Honda HR-V','D Series Engine','141 HP','5700', 2016); 
INSERT INTO vehicle_model VALUES ('M0005','Honda Insight','C Series Engine','151 HP','6760', 2018); 
INSERT INTO vehicle_model VALUES ('M0006','Honda Accord Hybrid','B Series Engine','212 HP','7000', 2020); 
INSERT INTO vehicle_model VALUES ('M0007','Honda Odyssey','D Series Engine','280 HP','5700', 2017); 
INSERT INTO vehicle_model VALUES ('M0008','Honda Civic Type R','C Series Engine','306 HP','5200', 2018); 
INSERT INTO vehicle_model VALUES ('M0009','Honda CR-V Hybrid','D Series Engine','212 HP','6000', 2020); 
INSERT INTO vehicle_model VALUES ('M0010','Honda Jazz','B Series Engine','130 HP','7000', 2021); 
INSERT INTO vehicle_model VALUES ('M0011','Honda Jazz Hybrid','B Series Engine','150 HP','5900', 2020); 
INSERT INTO vehicle_model VALUES ('M0012','Honda City','C Series Engine','130 HP','6200', 2016); 
INSERT INTO vehicle_model VALUES ('M0013','Honda City Hybrid','C Series Engine','160 HP','6900', 2019); 
INSERT INTO vehicle_model VALUES ('M0014','Honda BR-V E','B Series Engine','155 HP','5500', 2020); 
INSERT INTO vehicle_model VALUES ('M0015','Honda BR-V SE','B Series Engine','160 HP','7900', 2017); 
INSERT INTO vehicle_model VALUES ('M0016','Honda City Hatchback','C Series Engine','300 HP','8900', 2018); 
INSERT INTO vehicle_model VALUES ('M0017','Honda BR-V V','B Series Engine','250 HP','7900', 2018); 
INSERT INTO vehicle_model VALUES ('M0018','Honda Civic Premium','C Series Engine','350 HP','6900', 2016); 
INSERT INTO vehicle_model VALUES ('M0019','Honda Civic TC Premium','C Series Engine','270 HP','7500', 2016); 
INSERT INTO vehicle_model VALUES ('M0020','Honda Civic International','C Series Engine','250 HP','5900',2016); 

INSERT INTO vehicle_for_sale VALUES ('V0001', 'M0001', 'Red');
INSERT INTO vehicle_for_sale VALUES ('V0002', 'M0001', 'Blue');
INSERT INTO vehicle_for_sale VALUES ('V0003', 'M0002', 'Green');
INSERT INTO vehicle_for_sale VALUES ('V0004', 'M0001', 'Orange');
INSERT INTO vehicle_for_sale VALUES ('V0005', 'M0001', 'Black');
INSERT INTO vehicle_for_sale VALUES ('V0006', 'M0002', 'Silver');
INSERT INTO vehicle_for_sale VALUES ('V0007', 'M0002', 'Brown');
INSERT INTO vehicle_for_sale VALUES ('V0008', 'M0002', 'Blue');
INSERT INTO vehicle_for_sale VALUES ('V0009', 'M0001', 'Blue');
INSERT INTO vehicle_for_sale VALUES ('V0010', 'M0001', 'Silver');
INSERT INTO vehicle_for_sale VALUES ('V0011', 'M0001', 'Red');
INSERT INTO vehicle_for_sale VALUES ('V0012', 'M0002', 'Silver');
INSERT INTO vehicle_for_sale VALUES ('V0013', 'M0003', 'Silver');
INSERT INTO vehicle_for_sale VALUES ('V0014', 'M0003', 'Silver');
INSERT INTO vehicle_for_sale VALUES ('V0015', 'M0001', 'Orange');
INSERT INTO vehicle_for_sale VALUES ('V0016', 'M0001', 'Silver');
INSERT INTO vehicle_for_sale VALUES ('V0017', 'M0003', 'Blue');
INSERT INTO vehicle_for_sale VALUES ('V0018', 'M0003', 'Blue');
INSERT INTO vehicle_for_sale VALUES ('V0019', 'M0001', 'Orange');
INSERT INTO vehicle_for_sale VALUES ('V0020', 'M0004', 'Orange');
INSERT INTO vehicle_for_sale VALUES ('V0021', 'M0001', 'Red');
INSERT INTO vehicle_for_sale VALUES ('V0022', 'M0005', 'Black');
INSERT INTO vehicle_for_sale VALUES ('V0023', 'M0005', 'Black');
INSERT INTO vehicle_for_sale VALUES ('V0024', 'M0005', 'Black');
INSERT INTO vehicle_for_sale VALUES ('V0025', 'M0011', 'Brown');
INSERT INTO vehicle_for_sale VALUES ('V0026', 'M0012', 'Silver');
INSERT INTO vehicle_for_sale VALUES ('V0027', 'M0012', 'Silver');
INSERT INTO vehicle_for_sale VALUES ('V0028', 'M0015', 'Brown');
INSERT INTO vehicle_for_sale VALUES ('V0029', 'M0013', 'Brown');
INSERT INTO vehicle_for_sale VALUES ('V0030', 'M0015', 'Silver');
INSERT INTO vehicle_for_sale VALUES ('V0031', 'M0001', 'Red');
INSERT INTO vehicle_for_sale VALUES ('V0032', 'M0010', 'Silver');
INSERT INTO vehicle_for_sale VALUES ('V0033', 'M0010', 'Red');
INSERT INTO vehicle_for_sale VALUES ('V0034', 'M0010', 'Red');
INSERT INTO vehicle_for_sale VALUES ('V0035', 'M0006', 'Black');
INSERT INTO vehicle_for_sale VALUES ('V0036', 'M0006', 'Purple');
INSERT INTO vehicle_for_sale VALUES ('V0037', 'M0006', 'Black');
INSERT INTO vehicle_for_sale VALUES ('V0038', 'M0005', 'Black');
INSERT INTO vehicle_for_sale VALUES ('V0039', 'M0005', 'Purple');
INSERT INTO vehicle_for_sale VALUES ('V0040', 'M0016', 'Purple');
INSERT INTO vehicle_for_sale VALUES ('V0041', 'M0001', 'Red');
INSERT INTO vehicle_for_sale VALUES ('V0042', 'M0006', 'Metallic Blue');
INSERT INTO vehicle_for_sale VALUES ('V0043', 'M0007', 'Metallic Red');
INSERT INTO vehicle_for_sale VALUES ('V0044', 'M0007', 'Purple');
INSERT INTO vehicle_for_sale VALUES ('V0045', 'M0008', 'Purple');
INSERT INTO vehicle_for_sale VALUES ('V0046', 'M0017', 'Metallic Purple');
INSERT INTO vehicle_for_sale VALUES ('V0047', 'M0019', 'Metallic Purple');
INSERT INTO vehicle_for_sale VALUES ('V0048', 'M0019', 'Metallic Green');
INSERT INTO vehicle_for_sale VALUES ('V0049', 'M0008', 'Metallic Green');
INSERT INTO vehicle_for_sale VALUES ('V0050', 'M0008', 'Black');

INSERT INTO vehicle_sold VALUES ('P0001', 'V0011', '03-12-2020', 'C2001', 'S3001', 1332003, 5);
INSERT INTO vehicle_sold VALUES ('P0002', 'V0026', '04-11-2018', 'C2002', 'S3001', 1822241,5);
INSERT INTO vehicle_sold VALUES ('P0003', 'V0019', '20-04-2020', 'C2003', 'S3003', 1604330, 6);
INSERT INTO vehicle_sold VALUES ('P0004', 'V0008', '10-11-2021', 'C2004', 'S3004', 1403423, 8);
INSERT INTO vehicle_sold VALUES ('P0005', 'V0006', '23-06-2017', 'C2005', 'S3005', 1066159, 5);
INSERT INTO vehicle_sold VALUES ('P0006', 'V0002', '24-08-2019', 'C2006', 'S3006', 1729422, 7);
INSERT INTO vehicle_sold VALUES ('P0007', 'V0003', '14-05-2018', 'C2007', 'S3007', 1684375, 7);
INSERT INTO vehicle_sold VALUES ('P0008', 'V0027', '15-01-2016', 'C2008', 'S3008', 1138360, 7);
INSERT INTO vehicle_sold VALUES ('P0009', 'V0033', '16-03-2021', 'C2009', 'S3009', 1550570, 6);
INSERT INTO vehicle_sold VALUES ('P0010', 'V0041', '17-02-2019', 'C2010', 'S3010', 1422048, 7);
INSERT INTO vehicle_sold VALUES ('P0011', 'V0048', '20-12-2020', 'C2011', 'S3011', 1258309, 5);
INSERT INTO vehicle_sold VALUES ('P0012', 'V0010', '12-10-2021', 'C2012', 'S3012', 776728, 6);
INSERT INTO vehicle_sold VALUES ('P0013', 'V0001', '01-06-2017', 'C2013', 'S3013', 764445, 7);
INSERT INTO vehicle_sold VALUES ('P0014', 'V0018', '03-07-2018', 'C2014', 'S3014', 1139858, 6);
INSERT INTO vehicle_sold VALUES ('P0015', 'V0023', '05-08-2019', 'C2015', 'S3014', 1444513, 5);
INSERT INTO vehicle_sold VALUES ('P0016', 'V0032', '06-09-2021', 'C2016', 'S3016', 1033070, 7);
INSERT INTO vehicle_sold VALUES ('P0017', 'V0009', '17-10-2020', 'C2017', 'S3017', 683395, 5);
INSERT INTO vehicle_sold VALUES ('P0018', 'V0030', '18-11-2020', 'C2018', 'S3018', 780241, 5);
INSERT INTO vehicle_sold VALUES ('P0019', 'V0025', '08-12-2020', 'C2019', 'S3019', 551273, 5);
INSERT INTO vehicle_sold VALUES ('P0020', 'V0012', '09-03-2018', 'C2020', 'S3020', 605992, 7);
INSERT INTO vehicle_sold VALUES ('P0021', 'V0007', '08-04-2020', 'C2011', 'S3019', 1065235, 8);
INSERT INTO vehicle_sold VALUES ('P0022', 'V0019', '07-05-2019', 'C2012', 'S3011', 1029609, 7);
INSERT INTO vehicle_sold VALUES ('P0023', 'V0031', '20-10-2017', 'C2001', 'S3011', 793314, 5);
INSERT INTO vehicle_sold VALUES ('P0024', 'V0044', '31-12-2018', 'C2002', 'S3001', 1055836, 5);
INSERT INTO vehicle_sold VALUES ('P0025', 'V0050', '23-12-2019', 'C2003', 'S3003', 906750, 8);
INSERT INTO vehicle_sold VALUES ('P0026', 'V0028', '22-05-2017', 'C2004', 'S3004', 1477820, 7);
INSERT INTO vehicle_sold VALUES ('P0027', 'V0020', '04-04-2017', 'C2005', 'S3014', 907022, 5);
INSERT INTO vehicle_sold VALUES ('P0028', 'V0016', '05-04-2017', 'C2001', 'S3016', 822268, 8);
INSERT INTO vehicle_sold VALUES ('P0029', 'V0024', '10-01-2018', 'C2017', 'S3016', 1327618, 8);
INSERT INTO vehicle_sold VALUES ('P0030', 'V0015', '11-08-2019', 'C2019', 'S3017', 791789, 5);
INSERT INTO vehicle_sold VALUES ('P0031', 'V0038', '11-02-2018', 'C2010', 'S3011', 1060412, 6);
INSERT INTO vehicle_sold VALUES ('P0032', 'V0042', '12-05-2020', 'C2001', 'S3011', 793314, 7);
INSERT INTO vehicle_sold VALUES ('P0033', 'V0040', '15-06-2018', 'C2002', 'S3005', 696819, 6);
INSERT INTO vehicle_sold VALUES ('P0034', 'V0005', '16-07-2017', 'C2005', 'S3004', 1055836, 7);
INSERT INTO vehicle_sold VALUES ('P0035', 'V0021', '17-09-2020', 'C2005', 'S3006', 939432, 7);
INSERT INTO vehicle_sold VALUES ('P0036', 'V0004', '31-10-2021', 'C2001', 'S3007', 732418, 8);
INSERT INTO vehicle_sold VALUES ('P0037', 'V0013', '30-11-2020', 'C2002', 'S3008', 596214, 7);
INSERT INTO vehicle_sold VALUES ('P0038', 'V0036', '28-02-2021', 'C2008', 'S3002', 1145007, 8);
INSERT INTO vehicle_sold VALUES ('P0039', 'V0045', '21-12-2019', 'C2009', 'S3010', 876410, 5);
INSERT INTO vehicle_sold VALUES ('P0040', 'V0049', '01-01-2018', 'C2011', 'S3011', 14183891, 6);
INSERT INTO vehicle_sold VALUES ('P0041', 'V0047', '10-04-2021', 'C2020', 'S3020', 1342816, 7);
INSERT INTO vehicle_sold VALUES ('P0042', 'V0029', '11-05-2019', 'C2002', 'S3020', 912905, 5);
INSERT INTO vehicle_sold VALUES ('P0043', 'V0014', '15-06-2017', 'C2005', 'S3020', 1324868, 6);
INSERT INTO vehicle_sold VALUES ('P0044', 'V0039', '16-10-2020', 'C2007', 'S3020', 686281, 7);
INSERT INTO vehicle_sold VALUES ('P0045', 'V0035', '20-11-2020', 'C2010', 'S3020', 1457014, 7);
INSERT INTO vehicle_sold VALUES ('P0046', 'V0046', '21-12-2018', 'C2015', 'S3020', 1726944, 8);
INSERT INTO vehicle_sold VALUES ('P0047', 'V0034', '04-08-2021', 'C2017', 'S3020', 623449, 6);
INSERT INTO vehicle_sold VALUES ('P0048', 'V0037', '01-09-2021', 'C2019', 'S3020', 1326229, 6);
INSERT INTO vehicle_sold VALUES ('P0049', 'V0043', '02-01-2018', 'C2020', 'S3020', 1114422, 8);
INSERT INTO vehicle_sold VALUES ('P0050', 'V0022', '07-02-2018', 'C2001', 'S3020', 1277126, 8);

--> Insert records into ffmaintenence table
INSERT INTO maintenance VALUES ('M5001', '12-01-2017', 'P0001', 'M4002', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5002', '05-02-2018', 'P0002', 'M4011', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5003', '06-10-2019', 'P0002', 'M4010', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5004', '01-11-2021', 'P0003', 'M4002', 'AirCond', 20000); 
INSERT INTO maintenance VALUES ('M5005', '21-10-2021', 'P0003', 'M4012', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5006', '20-12-2019', 'P0001', 'M4004', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5007', '31-01-2021', 'P0001', 'M4009', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5008', '25-05-2019', 'P0005', 'M4010', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5009', '15-07-2018', 'P0006', 'M4015', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5010', '12-06-2017', 'P0006', 'M4020', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5011', '01-01-2016', 'P0002', 'M4001', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5012', '05-01-2016', 'P0002', 'M4012', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5013', '07-10-2017', 'P0009', 'M4013', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5014', '18-11-2018', 'P0009', 'M4002', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5015', '19-09-2020', 'P0010', 'M4006', 'Oil', 12000); 
INSERT INTO maintenance VALUES ('M5016', '19-09-2020', 'P0010', 'M4006', 'Brake', 20000); 
INSERT INTO maintenance VALUES ('M5017', '28-07-2018', 'P0014', 'M4007', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5018', '14-02-2019', 'P0011', 'M4008', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5019', '15-11-2021', 'P0002', 'M4010', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5020', '12-12-2019', 'P0015', 'M4011', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5021', '02-01-2021', 'P0014', 'M4002', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5022', '05-02-2019', 'P0002', 'M4001', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5023', '06-05-2019', 'P0014', 'M4005', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5024', '18-06-2018', 'P0001', 'M4008', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5025', '19-09-2017', 'P0001', 'M4009', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5026', '11-10-2016', 'P0015', 'M4011', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5027', '12-11-2017', 'P0015', 'M4015', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5028', '16-06-2018', 'P0005', 'M4017', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5029', '17-02-2019', 'P0019', 'M4018', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5030', '12-01-2020', 'P0006', 'M4020', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5031', '11-10-2021', 'P0005', 'M4001', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5032', '10-11-2017', 'P0002', 'M4002', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5033', '10-06-2019', 'P0009', 'M4003', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5034', '07-01-2016', 'P0019', 'M4014', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5035', '03-02-2017', 'P0009', 'M4004', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5036', '05-03-2018', 'P0003', 'M4006', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5037', '06-06-2016', 'P0011', 'M4007', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5038', '07-07-2018', 'P0019', 'M4008', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5039', '01-10-2019', 'P0015', 'M4009', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5040', '09-11-2020', 'P0001', 'M4011', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5041', '19-09-2020', 'P0010', 'M4019', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5042', '19-09-2020', 'P0010', 'M4020', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5043', '12-05-2020', 'P0016', 'M4020', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5044', '16-06-2020', 'P0016', 'M4020', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5045', '17-08-2016', 'P0016', 'M4002', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5046', '19-09-2019', 'P0016', 'M4003', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5047', '01-10-2019', 'P0005', 'M4004', 'AirCond',20000); 
INSERT INTO maintenance VALUES ('M5048', '02-06-2019', 'P0015', 'M4011', 'Engine', 12000); 
INSERT INTO maintenance VALUES ('M5049', '03-01-2021', 'P0016', 'M4015', 'Oil', 8000); 
INSERT INTO maintenance VALUES ('M5050', '05-02-2020', 'P0001', 'M4020', 'AirCond',20000);


 