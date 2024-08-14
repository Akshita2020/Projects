-- Entities and Attributes --

/*Patient (Patient_ID, Name, Date_of_Birth, Gender, Address, Contact_Number)
Doctor (Doctor_ID, Name, Specialization, Contact_Information)
Department (DepartmentID, DepartmentName)
Nurse (Nurse_ID, Name, DepartmentId, Contact_Information)
Ward (Ward_ID, Ward_Name, Capacity, Location)
Appointment (Appointment_ID, Patient_ID, Doctor_ID, DateandTime, Status)
MedicalRecord (Record_ID, Patient_ID, Doctor_ID, Date_of_Visit, Diagnosis, Treatment)

-- Relationships --

DoctorPatient (Doctor_ID, Patient_ID)
Patient_MedicalRecord (Patient_ID, MedicalRecord_ID)
Doctor_Appointment (Doctor_ID, Appointment_ID)
Nurse_Ward (Nurse_ID, Ward_ID)

-- Primary and Foreign Keys --

Patient:
  Primary Key: Patient_ID
Doctor:
  Primary Key: Doctor_ID
Department:
  Primary Key: DepartmentID
Nurse:
  Primary Key: Nurse_ID
  Foreign Key: DepartmentId references Department(DepartmentID)
Ward:
  Primary Key: Ward_ID
Appointment:
  Primary Key: Appointment_ID
  Foreign Key: Patient_ID references Patient(Patient_ID)
  Foreign Key: Doctor_ID references Doctor(Doctor_ID)
MedicalRecord:
  Primary Key: Record_ID
  Foreign Key: Patient_ID references Patient(Patient_ID)
  Foreign Key: Doctor_ID references Doctor(Doctor_ID)
DoctorPatient:
  Primary Key: (Doctor_ID, Patient_ID)
  Foreign Key: Doctor_ID references Doctor(Doctor_ID)
  Foreign Key: Patient_ID references Patient(Patient_ID)
Patient_MedicalRecord:
  Primary Key: (Patient_ID, MedicalRecord_ID)
  Foreign Key: Patient_ID references Patient(Patient_ID)
  Foreign Key: MedicalRecord_ID references MedicalRecord(Record_ID)
Doctor_Appointment:
  Primary Key: (Doctor_ID, Appointment_ID)
  Foreign Key: Doctor_ID references Doctor(Doctor_ID)
  Foreign Key: Appointment_ID references Appointment(Appointment_ID)
Nurse_Ward:
  Primary Key: (Nurse_ID, Ward_ID)
  Foreign Key: Nurse_ID references Nurse(Nurse_ID)
  Foreign Key: Ward_ID references Ward(Ward_ID) */ 
  
  -- Create Database
CREATE DATABASE IF NOT EXISTS HOSPITAL_MANAGEMENT;
USE HOSPITAL_MANAGEMENT;


-- Create Tables
CREATE TABLE IF NOT EXISTS Patient (
    Patient_ID int PRIMARY KEY,
    Name varchar(100) NOT NULL,
    Date_of_Birth date NOT NULL, 
    Gender char(1) NOT NULL, 
    Address varchar(200),
    Contact_Number varchar(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Doctor (
    Doctor_ID int PRIMARY KEY,
    Name varchar(100) NOT NULL,
    Specialization varchar(100) NOT NULL,
    Contact_Information varchar(100) 
);

CREATE TABLE IF NOT EXISTS Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Nurse (
    Nurse_ID int PRIMARY KEY,
    Name varchar(100) NOT NULL,
    DepartmentId int NOT NULL,
    Contact_Information varchar(100),
    FOREIGN KEY (DepartmentId) REFERENCES Department(DepartmentID)
);

CREATE TABLE IF NOT EXISTS Ward (
    Ward_ID int PRIMARY KEY,
    Ward_Name varchar(100) NOT NULL,
    Capacity int NOT NULL check( Capacity > 0 ),
    Location varchar(200) NOT NULL
);
CREATE TABLE IF NOT EXISTS Appointment (
    Appointment_ID int PRIMARY KEY,
    Patient_ID int,
    Doctor_ID int,
    DateandTime datetime NOT NULL,
    Status varchar(50) NOT NULL,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

CREATE TABLE IF NOT EXISTS MedicalRecord (
    Record_ID int PRIMARY KEY,
    Patient_ID int,
    Doctor_ID int,
    Date_of_Visit date NOT NULL,
    Diagnosis text,
    Treatment text,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

CREATE TABLE IF NOT EXISTS DoctorPatient (
    Doctor_ID INT,
    Patient_ID INT,
    DateAssigned DATE,
    PRIMARY KEY (Doctor_ID, Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

CREATE TABLE IF NOT EXISTS Patient_MedicalRecord (
    Patient_ID INT NOT NULL,
    MedicalRecord_ID INT NOT NULL,
    PRIMARY KEY (Patient_ID, MedicalRecord_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (MedicalRecord_ID) REFERENCES MedicalRecord(Record_ID)
);

CREATE TABLE IF NOT EXISTS Doctor_Appointment (
    Doctor_ID INT NOT NULL,
    Appointment_ID INT NOT NULL,
    PRIMARY KEY (Doctor_ID, Appointment_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID)
);

CREATE TABLE IF NOT EXISTS Nurse_Ward (
    Nurse_ID INT NOT NULL,
    Ward_ID INT NOT NULL,
    PRIMARY KEY (Nurse_ID, Ward_ID),
    FOREIGN KEY (Nurse_ID) REFERENCES Nurse(Nurse_ID),
    FOREIGN KEY (Ward_ID) REFERENCES Ward(Ward_ID)
);

-- Sample data for Patient table
INSERT INTO Patient (Patient_ID, Name, Date_of_Birth, Gender, Address, Contact_Number) VALUES
(1, 'John Doe', '1990-05-15', 'M', '123 Main St', '123-456-7890'),
(2, 'Jane Smith', '1985-09-20', 'F', '456 Elm St', '987-654-3210'),
(3, 'Michael Johnson', '1982-07-10', 'M', '789 Oak St', '555-123-4567'),
(4, 'Emily Brown', '1976-12-03', 'F', '321 Maple St', '111-222-3333'),
(5, 'David Wilson', '1995-03-25', 'M', '567 Pine St', '999-888-7777'),
(6, 'Sarah Miller', '1988-08-18', 'F', '876 Cedar St', '444-555-6666'),
(7, 'Robert Taylor', '1970-11-12', 'M', '234 Birch St', '777-666-5555'),
(8, 'Jessica Martinez', '1983-06-30', 'F', '432 Spruce St', '333-444-5555'),
(9, 'Daniel Garcia', '1992-09-05', 'M', '654 Walnut St', '222-111-9999'),
(10, 'Amanda Jones', '1978-04-17', 'F', '987 Pine St', '888-777-6666');

-- Sample data for Doctor table
INSERT INTO Doctor (Doctor_ID, Name, Specialization, Contact_Information) VALUES
(1, 'Dr. John Johnson', 'Cardiology', 'doctorjohn@example.com'),
(2, 'Dr. Emily Davis', 'Pediatrics', 'doctoremmily@example.com'),
(3, 'Dr. Michael Wilson', 'Orthopedics', 'doctormichael@example.com'),
(4, 'Dr. Sarah Brown', 'Dermatology', 'doctorsarah@example.com'),
(5, 'Dr. Robert Garcia', 'Neurology', 'doctorrobert@example.com'),
(6, 'Dr. Jessica Taylor', 'Oncology', 'doctorjessica@example.com'),
(7, 'Dr. David Martinez', 'Gastroenterology', 'doctordavid@example.com'),
(8, 'Dr. Amanda Miller', 'Endocrinology', 'doctoramanda@example.com'),
(9, 'Dr. Daniel Jones', 'Psychiatry', 'doctordaniel@example.com'),
(10, 'Dr. Emily Wilson', 'Ophthalmology', 'doctoremily@example.com');
INSERT INTO Doctor (Doctor_ID, Name, Specialization, Contact_Information) VALUES
(11, 'Dr. John Smith', 'Cardiology', 'john.smith@example.com'),
(12, 'Dr. Emily Johnson', 'Pediatrics', 'emily.johnson@example.com'),
(13, 'Dr. Michael Williams', 'Orthopedics', 'michael.williams@example.com');
INSERT INTO Doctor (Doctor_ID, Name, Specialization, Contact_Information) VALUES
(14, 'Dr. Sarah Jones', 'Oncology', 'sarah.jones@example.com'),
(15, 'Dr. Mark Wilson', 'Neurology', 'mark.wilson@example.com');

-- Sample data for Department table
INSERT INTO Department (DepartmentID, DepartmentName) VALUES
(1, 'Cardiology'),
(2, 'Pediatrics'),
(3, 'Orthopedics'),
(4, 'Dermatology'),
(5, 'Neurology'),
(6, 'Oncology'),
(7, 'Gastroenterology'),
(8, 'Endocrinology'),
(9, 'Psychiatry'),
(10, 'Ophthalmology');

-- Sample data for Nurse table
INSERT INTO Nurse (Nurse_ID, Name, DepartmentId, Contact_Information) VALUES
(1, 'Nurse Sarah', 1, 'nursesarah@example.com'),
(2, 'Nurse Michael', 2, 'nursemichael@example.com'),
(3, 'Nurse Jessica', 3, 'nursejessica@example.com'),
(4, 'Nurse David', 4, 'nursedavid@example.com'),
(5, 'Nurse Emily', 5, 'nurseemily@example.com'),
(6, 'Nurse Robert', 6, 'nurserobert@example.com'),
(7, 'Nurse Amanda', 7, 'nurseamanda@example.com'),
(8, 'Nurse Daniel', 8, 'nursedaniel@example.com'),
(9, 'Nurse Emily', 9, 'nurseemily@example.com'),
(10, 'Nurse Sarah', 10, 'nursesarah@example.com');

-- Sample data for Ward table
INSERT INTO Ward (Ward_ID, Ward_Name, Capacity, Location) VALUES
(1, 'Cardiology Ward', 20, 'East Wing'),
(2, 'Pediatrics Ward', 30, 'West Wing'),
(3, 'Orthopedics Ward', 15, 'North Wing'),
(4, 'Dermatology Ward', 25, 'South Wing'),
(5, 'Neurology Ward', 10, 'Central Wing'),
(6, 'Oncology Ward', 18, 'East Wing'),
(7, 'Gastroenterology Ward', 22, 'West Wing'),
(8, 'Endocrinology Ward', 17, 'North Wing'),
(9, 'Psychiatry Ward', 12, 'South Wing'),
(10, 'Ophthalmology Ward', 8, 'Central Wing');

-- Sample data for Appointment table
INSERT INTO Appointment (Appointment_ID, Patient_ID, Doctor_ID, DateandTime, Status) VALUES
(1, 1, 1, '2024-02-22 09:00:00', 'Scheduled'),
(2, 2, 2, '2024-02-25 10:00:00', 'Scheduled'),
(3, 3, 3, '2024-02-28 11:00:00', 'Scheduled'),
(4, 4, 4, '2024-03-01 13:00:00', 'Scheduled'),
(5, 5, 5, '2024-03-05 14:00:00', 'Scheduled'),
(6, 6, 6, '2024-03-08 15:00:00', 'Scheduled'),
(7, 7, 7, '2024-03-10 16:00:00', 'Scheduled'),
(8, 8, 8, '2024-03-12 17:00:00', 'Scheduled'),
(9, 9, 9, '2024-03-15 18:00:00', 'Scheduled'),
(10, 10, 10, '2024-03-18 19:00:00', 'Scheduled');

-- Sample data for MedicalRecord table
INSERT INTO MedicalRecord (Record_ID, Patient_ID, Doctor_ID, Date_of_Visit, Diagnosis, Treatment) VALUES
(1, 1, 1, '2024-02-22', 'Hypertension', 'Medication and lifestyle changes'),
(2, 2, 2, '2024-02-25', 'Upper Respiratory Infection', 'Antibiotics and rest'),
(3, 3, 3, '2024-02-28', 'Fractured Leg', 'Surgery and physical therapy'),
(4, 4, 4, '2024-03-01', 'Eczema', 'Topical steroids and moisturizers'),
(5, 5, 5, '2024-03-05', 'Migraine', 'Painkillers and relaxation techniques'),
(6, 6, 6, '2024-03-08', 'Breast Cancer', 'Surgery, chemotherapy, and radiation therapy'),
(7, 7, 7, '2024-03-10', 'Gastritis', 'Antacids and dietary changes'),
(8, 8, 8, '2024-03-12', 'Diabetes', 'Insulin therapy and dietary management'),
(9, 9, 9, '2024-03-15', 'Depression', 'Therapy and antidepressants'),
(10, 10, 10, '2024-03-18', 'Cataracts', 'Cataract surgery and corrective lenses');
INSERT INTO MedicalRecord (Record_ID, Patient_ID, Doctor_ID, Date_of_Visit, Diagnosis, Treatment) VALUES
(11, 1, 11, '2024-02-20', 'Heart Disease', 'Medication and lifestyle changes'),
(12, 2, 12, '2024-02-21', 'Common Cold', 'Rest and hydration'),
(13, 3, 13, '2024-02-22', 'Fractured Arm', 'Casting and physical therapy'),
(14, 4, 11, '2024-02-23', 'Psoriasis', 'Topical treatments and UV therapy'),
(15, 5, 12, '2024-02-24', 'Asthma', 'Bronchodilators and inhaled corticosteroids');




-- Sample data for DoctorPatient junction table
INSERT INTO DoctorPatient (Doctor_ID, Patient_ID, DateAssigned)
VALUES
(1, 1, '2024-02-22'), -- Dr. John Johnson assigned to John Doe
(2, 2, '2024-02-25'), -- Dr. Emily Davis assigned to Jane Smith
(3, 3, '2024-02-28'), -- Dr. Michael Wilson assigned to Michael Johnson
(4, 4, '2024-03-01'), -- Dr. Sarah Brown assigned to Emily Brown
(5, 5, '2024-03-05'), -- Dr. Robert Garcia assigned to David Wilson
(6, 6, '2024-03-08'), -- Dr. Jessica Taylor assigned to Sarah Miller
(7, 7, '2024-03-10'), -- Dr. David Martinez assigned to Robert Taylor
(8, 8, '2024-03-12'), -- Dr. Amanda Miller assigned to Jessica Martinez
(9, 9, '2024-03-15'), -- Dr. Daniel Jones assigned to Daniel Garcia
(10, 10, '2024-03-18'); -- Dr. Emily Wilson assigned to Amanda Jones
INSERT INTO DoctorPatient (Doctor_ID, Patient_ID, DateAssigned) VALUES
(11, 1, '2024-02-20'), -- Dr. John Smith assigned to John Doe on 2024-02-20
(12, 2, '2024-02-21'), -- Dr. Emily Johnson assigned to Jane Smith on 2024-02-21
(13, 3, '2024-02-22'), -- Dr. Michael Williams assigned to Michael Johnson on 2024-02-22
(11, 4, '2024-02-23'), -- Dr. John Smith assigned to Emily Brown on 2024-02-23
(12, 5, '2024-02-24'); -- Dr. Emily Johnson assigned to David Wilson on 2024-02-24


-- Sample data for Patient_MedicalRecord junction table
INSERT INTO Patient_MedicalRecord (Patient_ID, MedicalRecord_ID)
VALUES
(1, 1), -- John Doe's medical record
(2, 2), -- Jane Smith's medical record
(3, 3), -- Michael Johnson's medical record
(4, 4), -- Emily Brown's medical record
(5, 5), -- David Wilson's medical record
(6, 6), -- Sarah Miller's medical record
(7, 7), -- Robert Taylor's medical record
(8, 8), -- Jessica Martinez's medical record
(9, 9), -- Daniel Garcia's medical record
(10, 10); -- Amanda Jones's medical record

-- Sample data for Nurse_Ward junction table
INSERT INTO Nurse_Ward (Nurse_ID, Ward_ID)
VALUES
(1, 1), -- Nurse Sarah assigned to Cardiology Ward
(2, 2), -- Nurse Michael assigned to Pediatrics Ward
(3, 3), -- Nurse Jessica assigned to Orthopedics Ward
(4, 4), -- Nurse David assigned to Dermatology Ward
(5, 5), -- Nurse Emily assigned to Neurology Ward
(6, 6), -- Nurse Robert assigned to Oncology Ward
(7, 7), -- Nurse Amanda assigned to Gastroenterology Ward
(8, 8), -- Nurse Daniel assigned to Endocrinology Ward
(9, 9), -- Nurse Emily assigned to Psychiatry Ward
(10, 10); -- Nurse Sarah assigned to Ophthalmology Ward

-- Sample data for Doctor_Appointment junction table
INSERT INTO Doctor_Appointment (Doctor_ID, Appointment_ID)
VALUES
(1, 1), -- Dr. John Johnson assigned to John Doe's appointment
(2, 2), -- Dr. Emily Davis assigned to Jane Smith's appointment
(3, 3), -- Dr. Michael Wilson assigned to Michael Johnson's appointment
(4, 4), -- Dr. Sarah Brown assigned to Emily Brown's appointment
(5, 5), -- Dr. Robert Garcia assigned to David Wilson's appointment
(6, 6), -- Dr. Jessica Taylor assigned to Sarah Miller's appointment
(7, 7), -- Dr. David Martinez assigned to Robert Taylor's appointment
(8, 8), -- Dr. Amanda Miller assigned to Jessica Martinez's appointment
(9, 9), -- Dr. Daniel Jones assigned to Daniel Garcia's appointment
(10, 10); -- Dr. Emily Wilson assigned to Amanda Jones's appointment


-- 1. Retrieve the names and specialties of all doctors.
SELECT Name, Specialization
FROM Doctor;




-- 2. Retrieve the names and genders of all patients aged 30 or older.
SELECT Name, Gender
FROM Patient 
WHERE DATEDIFF(CURDATE(), Date_of_Birth) >= 30;

-- 3. Retrieve the names of patients treated by Dr. John Johnson. 
SELECT p.Name
FROM Patient p
INNER JOIN MedicalRecord m ON p.Patient_ID = m.Patient_ID
INNER JOIN Doctor d ON m.Doctor_ID = d.Doctor_ID
WHERE d.Name = 'Dr. John Johnson';

-- 4. Retrieve the names of doctors who specialize in Pediatrics, ordered alphabetically by name.
SELECT Name
FROM Doctor
WHERE Specialization = 'Pediatrics'
ORDER BY Name;

-- 5. Retrieve the total count of patients treated by each doctor.
SELECT d.Name, COUNT(*) AS TotalPatients
FROM Doctor d
INNER JOIN MedicalRecord m ON d.Doctor_ID = m.Doctor_ID
GROUP BY d.Name;


-- 6. Retrieve the average age of patients, grouped by gender.
SELECT Gender, AVG(DATEDIFF(CURDATE(), Date_of_Birth) / 365) AS AvgAge
FROM Patient
GROUP BY Gender;

-- 7. Retrieve the names of patients and their corresponding doctors, sorted by patient name.
SELECT p.Name AS PatientName, d.Name AS DoctorName
FROM Patient p
INNER JOIN MedicalRecord m ON p.Patient_ID = m.Patient_ID
INNER JOIN Doctor d ON m.Doctor_ID = d.Doctor_ID
ORDER BY p.Name;

-- 8. Retrieve the names of doctors who have not been assigned any patients.
SELECT d.Name
FROM Doctor d
LEFT JOIN MedicalRecord m ON d.Doctor_ID = m.Doctor_ID
WHERE m.Doctor_ID IS NULL;


-- 9. Retrieve the names of patients who have been treated by more than one doctor.
SELECT p.Name
FROM Patient p
INNER JOIN (
    SELECT Patient_ID
    FROM MedicalRecord
    GROUP BY Patient_ID
    HAVING COUNT(DISTINCT Doctor_ID) > 1
) AS multiple_doctors ON p.Patient_ID = multiple_doctors.Patient_ID;

-- 10. Retrieve the names of doctors and patients along with the date they were assigned to
-- each other (assuming there's a "DateAssigned" column in the DoctorPatient table).

SELECT Doctor.Name AS DoctorName, Patient.Name AS PatientName, DoctorPatient.DateAssigned
FROM DoctorPatient
JOIN Doctor ON DoctorPatient.Doctor_ID = Doctor.Doctor_ID
JOIN Patient ON DoctorPatient.Patient_ID = Patient.Patient_ID;

COMMIT;