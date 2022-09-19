DROP DATABASE IF EXISTS Account;
CREATE DATABASE Account;
USE Account;

CREATE TABLE MEMBER (
Member_Id                           VARCHAR(50) UNIQUE NOT NULL,
Member_First_Name                   VARCHAR(255) NOT NULL,
Member_Last_Name                    VARCHAR(255) NOT NULL,
Member_Gender                       ENUM('Female', 'Male', 'Other') NOT NULL,
Member_Telephone_Number             VARCHAR(11) NOT NULL,
Member_Street                       VARCHAR(255) NOT NULL,
Member_Town                         VARCHAR(255) NOT NULL,
Member_Postcode                     VARCHAR(255) NOT NULL,
Member_Type                         ENUM('Student', 'Public') NOT NULL,
PRIMARY KEY (Member_Id)
);

CREATE TABLE STUDENT (
Member_Id                           VARCHAR(50) UNIQUE NOT NULL,
Student_URN                         VARCHAR(7) UNIQUE NOT NULL,
Student_Email_Address               VARCHAR(255) NOT NULL,
PRIMARY KEY (Member_Id),
FOREIGN KEY (Member_Id) REFERENCES MEMBER (Member_Id)
);

CREATE TABLE PUBLIC (
Member_Id                           VARCHAR(50) UNIQUE NOT NULL,
Public_Personal_Email_Address       VARCHAR(255) NOT NULL,
PRIMARY KEY (Member_Id),
FOREIGN KEY (Member_Id) REFERENCES MEMBER (Member_Id)
);

CREATE TABLE MEMBERSHIP (
Membership_Id                       VARCHAR(10) UNIQUE NOT NULL,
Membership_Type                     ENUM('Gold', 'Silver', 'Bronze') NOT NULL,
Membership_Start_Date               DATE,
Membership_End_Date                 DATE,
Member_Id                           VARCHAR(50) UNIQUE NOT NULL,
PRIMARY KEY (Membership_Id),
FOREIGN KEY (Member_Id) REFERENCES MEMBER (Member_Id)
);

CREATE TABLE EMERGENCY_CONTACT (
Emergency_Contact_Id                VARCHAR(10) UNIQUE NOT NULL,
Emergency_Contact_First_Name        VARCHAR(255) NOT NULL,
Emergency_Contact_Last_Name         VARCHAR(255) NOT NULL,
Emergency_Contact_Telephone_Number  VARCHAR(11) NOT NULL,
Member_Id                           VARCHAR(50) UNIQUE NOT NULL,
PRIMARY KEY (Emergency_Contact_Id),
FOREIGN KEY (Member_Id) REFERENCES MEMBER (Member_Id)
);

CREATE TABLE TREATMENT (
Treatment_Session_Id                VARCHAR(5) UNIQUE NOT NULL,
Treatment_Name                      VARCHAR(255),
Treatment_Max_Number_Of_Bookings    ENUM('1'),
Treatment_Time                      TIME,
Treatment_Day                       ENUM('Tuesday', 'Thursday'),
PRIMARY KEY (Treatment_Session_Id)
);

CREATE TABLE GYM_CLASS (
Gym_Class_Id                        VARCHAR(5) UNIQUE NOT NULL,
Gym_Class_Name                      VARCHAR(255),
Gym_Class_Name_Id                   VARCHAR(5) NOT NULL,
Gym_Class_Max_Number_Of_Bookings    INT(2),
Gym_Class_Level                     ENUM('Beginner', 'Intermediate', 'Advanced'),
Gym_Class_Time                      TIME,
Gym_Class_Day                       ENUM('Monday', 'Wednesday', 'Friday'),
PRIMARY KEY (Gym_Class_Id)
);

CREATE TABLE INSTRUCTOR (
Instructor_ID                       VARCHAR(10) UNIQUE NOT NULL,     
Instructor_First_Name               VARCHAR(255),
Instructor_Second_Name              VARCHAR(255),
Instructor_Salary                   DECIMAL (15, 2),
Instructor_Job_Title                VARCHAR(255),
Instructor_Title_Id                 VARCHAR(5) NOT NULL,
Gym_Class_Id                        VARCHAR(5) NOT NULL,
PRIMARY KEY (Instructor_Id),
FOREIGN KEY (Gym_Class_Id ) REFERENCES GYM_CLASS (Gym_Class_Id)
);

CREATE TABLE BOOK_GYM_CLASS (
Member_Id                           VARCHAR(50) NOT NULL,
Gym_Class_Id                        VARCHAR(10) NOT NULL,
Date_Of_Class_Booking               TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (Member_Id, Gym_Class_Id, Date_Of_Class_Booking),
FOREIGN KEY (Member_Id) REFERENCES MEMBER (Member_Id),
FOREIGN KEY (Gym_Class_Id) REFERENCES GYM_CLASS (Gym_Class_Id)
);

CREATE TABLE BOOK_TREATMENT (
Member_Id                           VARCHAR(50) NOT NULL,
Treatment_Session_Id                VARCHAR(10) NOT NULL,
Date_Of_Treatment_Booking           TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (Member_Id, Treatment_Session_Id, Date_Of_Treatment_Booking),
FOREIGN KEY (Member_Id) REFERENCES MEMBER (Member_Id),
FOREIGN KEY (Treatment_Session_Id) REFERENCES TREATMENT (Treatment_Session_Id)
);


INSERT INTO MEMBER VALUES ('MBX1234567', 'Adam', 'Bezos', 'Male', '0774786543', '1, Way Road', 'Guildford', 'GU167UR', 'Student'),
    ('MBX5643218', 'Romeo', 'Beckham', 'Male', '07779784283', '1, Towns Road', 'Kingston', 'KT69PP', 'Public'),
    ('MBX4329873', 'Alice', 'Bowie', 'Female', '07732169813', '13, Garcon Street', 'Farnham', 'GU167UR', 'Student'),
    ('MBX3352911', 'Tamsin', 'John', 'Female', '07872938109', '1, Maple Road', 'Woking', 'GU185TP', 'Public'),
    ('MBX8762810', 'Sophie', 'Farah', 'Female', '07435201833', '453, Chester Way', 'Cranleigh', 'GU67AU', 'Student'),
    ('MBX6635690', 'George', 'Lineker', 'Male', '07437756019', '77, Milky Way', 'Oxshott', 'KT112RY', 'Student'),
    ('MBX5553679', 'Harry', 'Barlow', 'Male', '07439899905', '21, Potter Road', 'Cobham', 'KT107RE', 'Student'),
    ('MBX7309284', 'Lucy', 'Branson', 'Female', '0786625303', '10, Shrewsbury Cresent', 'London', 'SW157HQ', 'Public'),
    ('MBX0979369', 'Xavier', 'Musk', 'Male', '07834562117', '5, Royal Way', 'London', 'SW108PY', 'Public'),
    ('MBX1039476', 'Justin', 'Bieber', 'Male', '07765092102', '76, Bishops Road', 'Aldershot', 'GU124LT', 'Public');

INSERT INTO STUDENT VALUES ('MBX1234567', '6753893', 'a.bezos@surrey.ac.uk'),
    ('MBX4329873', '6793192', 'alice.bowie@surrey.ac.uk'),
    ('MBX8762810', '6888794', 'sophie.farah@surrey.ac.uk'),
    ('MBX6635690', '6987412', 'g.lineker@surrey.ac.uk'),
    ('MBX5553679', '6091293', 'harry.barlow@surrey.ac.uk');

INSERT INTO PUBLIC VALUES ('MBX5643218', 'romeo_beckham@gmail.com'),
    ('MBX3352911', 't_john@gmail.com'),
    ('MBX7309284', 'lucy.branson_100@yahoo.co.uk'),
    ('MBX0979369', 'x.musk@gmail.com'),
    ('MBX1039476', 'justin_bieber_99@hotmail.com');

INSERT INTO MEMBERSHIP VALUES ('0000000000', 'Gold', '20210801', '20220801', 'MBX1234567'),
    ('0000000001', 'Silver', '20210502', '20220502', 'MBX5643218'),
    ('0000000002', 'Bronze', '20211101', '20221101', 'MBX4329873'),
    ('0000000003', 'Bronze', '20211102', '20221102', 'MBX3352911'),
    ('0000000004', 'Silver', '20210702', '20220702', 'MBX8762810'),
    ('0000000005', 'Gold', '20210512', '20220512', 'MBX6635690'),
    ('0000000006', 'Gold', '20211208', '20221208', 'MBX5553679'),
    ('0000000007', 'Bronze', '20211018', '20221018', 'MBX7309284'),
    ('0000000008', 'Silver', '20210913', '20220913', 'MBX0979369'),
    ('0000000009', 'Silver', '20210214', '20220214', 'MBX1039476');

INSERT INTO EMERGENCY_CONTACT VALUES ('6666666660', 'Jeff', 'Bezos', '07764287143', 'MBX1234567'),
    ('6666666661', 'David', 'Beckham', '07865428321', 'MBX5643218'),
    ('6666666662', 'David', 'Bowie', '07768628611', 'MBX4329873'),
    ('6666666663', 'Elton', 'John', '07986453142', 'MBX3352911'),
    ('6666666664', 'Mo', 'Farah', '07876519012', 'MBX8762810'),
    ('6666666665', 'Gary', 'Lineker', '07987601624', 'MBX6635690'),
    ('6666666666', 'Gary', 'Barlow', '07709288369', 'MBX5553679'),
    ('6666666667', 'Richard', 'Branson', '07788905544', 'MBX7309284'),
    ('6666666668', 'Elon', 'Musk', '07548307832', 'MBX0979369'),
    ('6666666669', 'Hailey', 'Bieber', '07653281933', 'MBX1039476');

INSERT INTO GYM_CLASS VALUES ('00001', 'Yoga', '00011', '25', 'Beginner', '13:00', 'Monday'),
    ('00002', 'Strength and Tone', '00022', '20', 'Advanced', '13:30', 'Wednesday'),
    ('00003', 'Indoor Cycling', '00033', '15', 'Intermediate', '14:00', 'Friday'),
    ('00004', 'Dance Inspired Class', '00044', '20', 'Intermediate', '15:00', 'Wednesday'),
    ('00005', 'Aqua', '00055', '10', 'Intermediate', '15:30', 'Monday'); 

INSERT INTO TREATMENT VALUES ('001', 'Sports Massage', '1', '09:00', 'Thursday'),
    ('002', 'Sports Massage', '1', '09:30', 'Tuesday'),
    ('003', 'Sports Massage', '1', '10:00', 'Thursday'), 
    ('004', 'Osteopathy', '1', '10:30', 'Tuesday'),
    ('005', 'Sports Therapy', '1', '11:00', 'Thursday'),
    ('006', 'Physiotherapy', '1', '11:30', 'Tuesday'),
    ('007', 'Physiotherapy', '1', '12:00', 'Tuesday');

INSERT INTO INSTRUCTOR VALUES ('1111111111', 'Grace', 'Taylor', '70000.00', 'Yoga Instructor', '1111', '00001'),
    ('1111111112', 'Dan', 'Walker', '80000.00', 'Senior Gym Instructor', '1112', '00002'),
    ('1111111113', 'Abigale', 'White', '50000.00', 'Indoor Cycling Instructor', '1113', '00003'),
    ('1111111114', 'Lucy', 'Morgan', '50000.00', 'Gym Instructor', '1114', '00004'),
    ('1111111115', 'Pete', 'Kooper', '60000.00', 'Swimming Instructor', '1115', '00005');

INSERT INTO BOOK_GYM_CLASS (Member_Id, Gym_Class_Id) VALUES ('MBX4329873','00001'),
    ('MBX4329873','00004'),
    ('MBX3352911','00002'),
    ('MBX8762810','00001'),
    ('MBX6635690','00003'),
    ('MBX1039476','00005');

INSERT INTO BOOK_TREATMENT (Member_Id, Treatment_Session_Id) VALUES ('MBX4329873','001'),
    ('MBX4329873','004'),
    ('MBX1039476','002'),
    ('MBX0979369','003'),
    ('MBX7309284','002'),
    ('MBX5553679','003'),
    ('MBX8762810','005');

-- BELOW: ALL SQL QUERIES IN THE OTHER PHP FILES.

-- SQL QUERY 1: Selects a members first name and last name from the Member table based on the member ID they entered into Form1. Form1 is on the account.php page.
-- SELECT Member_First_Name, Member_Last_Name FROM MEMBER WHERE $where;

-- SQL QUERY 2: Selects a members membership type from the Membership table which can only be either, Gold, Silver or Bronze and the condition is based on the member ID they entered into Form1. Form1 is on the account.php page.
-- SELECT Membership_Type FROM MEMBERSHIP WHERE $where;

-- SQL QUERY 3: Selects the first and last name of a members emergency contact from the Emergency Contact table and the condition is based on the member ID they entered into Form1. Form1 is on the account.php page.
-- SELECT Emergency_Contact_First_Name, Emergency_Contact_Last_Name FROM EMERGENCY_CONTACT WHERE $where;

-- SQL QUERY 4: Counts the total number of classes that a member has booked.
-- SELECT COUNT(Gym_Class_Id) FROM BOOK_GYM_CLASS WHERE $where GROUP BY Member_Id;

-- SQL QUERY 5: Selects the names of gym classes a member has booked and also displays the number of gym classes booked at gym class name level. This design means the number of gym classes booked by name will be correct if another gym class that has the same name but a different time is added to the timetable in the future.
-- SELECT Gym_Class_Name, COUNT(Gym_Class_Name) FROM GYM_CLASS INNER JOIN BOOK_GYM_CLASS ON GYM_CLASS.Gym_Class_Id = BOOK_GYM_CLASS.Gym_Class_Id WHERE $where GROUP BY Gym_Class_Name;

-- SQL QUERY 6: Selects the gym class name, day and time of booked classes that the member has booked.
-- SELECT Gym_Class_Name, Gym_Class_Day, Gym_Class_Time FROM GYM_CLASS INNER JOIN BOOK_GYM_CLASS ON GYM_CLASS.Gym_Class_Id = BOOK_GYM_CLASS.Gym_Class_Id WHERE $where;

-- SQL QUERY 7: Selects the gym class day, time and id from the Gym Class table where the condition equals the gym class name.
-- SELECT Gym_Class_Day, Gym_Class_Time, Gym_Class_Id FROM GYM_CLASS WHERE $where;

-- SQL QUERY 8: Select an instructors first name from the Instructor table where the condition equals the gym class name ID.
-- SELECT Instructor_First_Name FROM INSTRUCTOR WHERE Gym_Class_Id = (SELECT Gym_Class_Id FROM GYM_CLASS WHERE $where);

-- SQL QUERY 9: Inserts into the Book Gym Class table the class ID and member ID using a cookie which saved the member ID and class ID so that the database now contains the new booking for the member.
-- INSERT INTO BOOK_GYM_CLASS (Member_Id, Gym_Class_Id) VALUES ('$member_id', '$class_id');

-- SQL QUERY 10: Selects the member ID and class ID from the book gym class table and if the result is 1 that class has already been booked for that user and the user is not able to book it again that week.
-- SELECT Member_Id, Gym_Class_Id FROM BOOK_GYM_CLASS WHERE $member_id_sql AND $class_id_sql";