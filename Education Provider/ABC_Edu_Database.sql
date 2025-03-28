-- Unit Code: COMP2350
-- Assignment#: 3
-- Student ID Number: 47542470
-- Student Name: Phuc Linh Nguyen
-- Tutor's Name: Mohib Ullah
-- Workshop Date/Time: Friday, 1-3pm

-- use your unit code followed by your student ID number. 
-- For example, if you are enrolled in COMP2350, and your student ID number is 123456
-- then, replace XXX with COMP2350_123456

create database `COMP2350_47542470`; 
use `COMP2350_47542470`;

DROP TABLE IF EXISTS Fee;
DROP TABLE IF EXISTS UnitGrade;
DROP TABLE IF EXISTS Registration;
DROP TABLE IF EXISTS Unit;
DROP TABLE IF EXISTS Student;

-- Create table for storing student information
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    is_current ENUM('YES', 'NO') DEFAULT 'YES'
);

-- Create table for storing courses information
CREATE TABLE Unit (
    unit_code VARCHAR(15) PRIMARY KEY,
    unit_name VARCHAR(100),
    is_advanced ENUM('YES', 'NO') DEFAULT 'NO',
    enrollment INT DEFAULT 0,
    registration_date DATE
);

-- Create table for storing registrations (student-unit relationship)   
-- Update on 03/10/2024: added new column no_penlty_deadline. See ilearn announcement on 03/10/2024
-- Update on 07/10/2024: added new columns droped_out_date and status. 
CREATE TABLE Registration (
    student_id INT,
    unit_code VARCHAR(15),
    semester varchar(15),
    registration_date DATE,
    no_penalty_deadline DATE, 
    dropped_out_date DATE,
    status ENUM('active', 'dropped_with_penalty', 'dropped_without_penalty') DEFAULT 'active',  -- Newly added column
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);


-- Create table for storing student grades
-- Update on 07/10/2024: added new column status.
CREATE TABLE UnitGrade (
    student_id INT,
    unit_code VARCHAR(15),
    semester VARCHAR(15),
    marks DECIMAL(5, 2),
    status ENUM('active', 'dropped') DEFAULT 'active', 
    PRIMARY KEY (student_id, unit_code, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (unit_code) REFERENCES Unit(unit_code)
);

-- Create table for storing fee information
CREATE TABLE Fee (
    student_id INT,
    semester varchar(15),
    fee_amount DECIMAL(10, 2),
    status ENUM('paid', 'unpaid') DEFAULT 'unpaid',
    description VARCHAR(255),
    PRIMARY KEY (student_id, semester),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);


-- Insert data into Student table
INSERT INTO Student (student_id, student_name, is_current) VALUES
(10001, 'Alice Smith', 'YES'),
(10002, 'Bob Johnson', 'YES'),
(10003, 'Charlie Brown', 'NO'),
(10004, 'David Wilson', 'YES'),
(10005, 'Emily Davis', 'NO'),
(10006, 'Frank Miller', 'YES'),
(10007, 'Grace Hall', 'YES'),
(10008, 'Hannah Lewis', 'YES'),
(10009, 'Ian Walker', 'NO'),
(10010, 'Julia Young', 'YES'),
(10011, 'Kevin Harris', 'YES'),
(10012, 'Lily Martin', 'YES'),
(10013, 'Mason White', 'NO'),
(10014, 'Nina Clark', 'YES'),
(10015, 'Oliver King', 'YES'),
(10016, 'Paul Scott', 'YES'),
(10017, 'Quinn Green', 'NO'),
(10018, 'Rachel Adams', 'YES'),
(10019, 'Samuel Turner', 'YES'),
(10020, 'Tina Baker', 'YES');

-- Insert data into Unit table
INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) VALUES
('IT101', 'Introduction to Programming', 'NO', 40, '2023-02-20'),
('IT102', 'Data Structures', 'NO', 35, '2023-02-20'),
('IT103', 'Database Systems', 'NO', 30, '2023-02-20'),
('IT401', 'Advanced Algorithms', 'YES', 20, '2023-02-20'),
('IT402', 'Machine Learning', 'YES', 25, '2023-02-20'),
('IT403', 'AI in Business', 'YES', 15, '2023-02-20'),
('IT404', 'Cybersecurity', 'YES', 18, '2023-02-20'),
('IT105', 'Operating Systems', 'NO', 30, '2023-02-20'),
('IT106', 'Web Development', 'NO', 28, '2023-02-20'),
('IT405', 'Cloud Computing', 'YES', 12, '2023-02-20');

-- Insert data into Registration table. 
-- Update on 07/10/2024: added data for new columns, droped_out_date and status. Also, updated no_penalty_deadline data
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) VALUES
(10001, 'IT101', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10001, 'IT102', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10002, 'IT103', '2023S1', '2023-01-16', '2023-02-13', NULL, 'active'), 
(10002, 'IT105', '2023S1', '2023-01-16', '2023-02-13', '2023-02-10', 'dropped_without_penalty'), 
(10003, 'IT101', '2023S1', '2023-01-17', '2023-02-12', '2023-02-15', 'dropped_with_penalty'), 
(10003, 'IT401', '2023S1', '2023-01-17', '2023-02-14', NULL, 'active'), 
(10004, 'IT402', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10004, 'IT403', '2023S1', '2023-01-18', '2023-02-15', NULL, 'active'), 
(10005, 'IT404', '2023S1', '2023-01-19', '2023-02-16', NULL, 'active'), 
(10005, 'IT102', '2023S1', '2023-01-19', '2023-02-12', '2023-02-20', 'dropped_with_penalty'), 
(10006, 'IT401', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10006, 'IT105', '2023S2', '2023-06-10', '2023-07-08', NULL, 'active'), 
(10007, 'IT402', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10007, 'IT101', '2023S2', '2023-06-11', '2023-07-09', NULL, 'active'), 
(10008, 'IT403', '2023S2', '2023-06-12', '2023-07-10', NULL, 'active'), 
(10008, 'IT102', '2023S2', '2023-06-12', '2023-07-10', '2023-07-15', 'dropped_with_penalty'), 
(10009, 'IT404', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10009, 'IT103', '2023S2', '2023-06-13', '2023-07-11', NULL, 'active'), 
(10010, 'IT401', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10010, 'IT405', '2023S2', '2023-06-14', '2023-07-08', NULL, 'active'), 
(10011, 'IT101', '2024S1', '2024-01-10', '2024-02-10', NULL, 'active'), 
(10011, 'IT402', '2024S1', '2024-01-10', '2024-02-07', NULL, 'active'), 
(10012, 'IT403', '2024S1', '2024-01-11', '2024-02-11', '2024-02-10', 'dropped_with_penalty'), 
(10012, 'IT102', '2024S1', '2024-01-11', '2024-02-11', NULL, 'active'), 
(10013, 'IT105', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10013, 'IT404', '2024S1', '2024-01-12', '2024-02-09', NULL, 'active'), 
(10014, 'IT101', '2024S1', '2024-01-13', '2024-02-10', '2024-02-12', 'dropped_with_penalty'), 
(10014, 'IT405', '2024S1', '2024-01-13', '2024-02-10', NULL, 'active'), 
(10015, 'IT102', '2024S1', '2024-01-14', '2024-02-11', '2024-02-01', 'dropped_without_penalty'), 
(10015, 'IT403', '2024S1', '2024-01-14', '2024-02-11', NULL, 'active'), 
(10016, 'IT401', '2024S1', '2024-01-15', '2024-02-07', NULL, 'active'), 
(10016, 'IT103', '2024S1', '2024-01-15', '2024-02-12', '2024-02-10', 'dropped_without_penalty'), 
(10017, 'IT102', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10017, 'IT404', '2024S2', '2024-06-01', '2024-06-29', NULL, 'active'), 
(10018, 'IT101', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10018, 'IT401', '2024S2', '2024-06-02', '2024-06-30', NULL, 'active'), 
(10019, 'IT105', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10019, 'IT402', '2024S2', '2024-06-03', '2024-07-01', NULL, 'active'), 
(10020, 'IT403', '2024S2', '2024-06-04', '2024-07-02', NULL, 'active'), 
(10020, 'IT101', '2024S2', '2024-06-04', '2024-06-30', NULL, 'active');


-- Insert data into UnitGrade table with semester, marks, and status (active or dropped)
-- Update on 07/10/2024: added data for new column status and updated marks for dropped units
INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) VALUES
(10001, 'IT101', '2023S1', 75.00, 'active'),
(10001, 'IT102', '2023S1', 65.00, 'active'),
(10002, 'IT103', '2023S1', 85.50, 'active'),
(10002, 'IT105', '2023S1', NULL, 'dropped'),
(10003, 'IT101', '2023S1', NULL, 'dropped'),
(10003, 'IT401', '2023S1', NULL, 'dropped'),
(10004, 'IT402', '2023S1', 55.00, 'active'),
(10004, 'IT403', '2023S1', 92.00, 'active'),
(10005, 'IT404', '2023S1', 50.00, 'active'), 
(10005, 'IT102', '2023S1', NULL, 'dropped'),
(10006, 'IT401', '2023S2', 47.00, 'active'),  
(10006, 'IT105', '2023S2', 60.00, 'active'),
(10007, 'IT402', '2023S2', 88.00, 'active'),
(10007, 'IT101', '2023S2', 30.00, 'active'), 
(10008, 'IT403', '2023S2', 90.00, 'active'),
(10008, 'IT102', '2023S2', NULL, 'dropped'), 
(10009, 'IT404', '2023S2', 40.00, 'active'),
(10009, 'IT103', '2023S2', 55.00, 'active'),
(10010, 'IT401', '2023S2', 85.00, 'active'),
(10010, 'IT405', '2023S2', 32.00, 'active'), 
(10011, 'IT101', '2024S1', 75.00, 'active'),
(10011, 'IT402', '2024S1', 65.00, 'active'),
(10012, 'IT403', '2024S1', NULL, 'dropped'), 
(10012, 'IT102', '2024S1', 70.00, 'active'),
(10013, 'IT105', '2024S1', 85.00, 'active'),
(10013, 'IT404', '2024S1', 48.00, 'active'),
(10014, 'IT101', '2024S1', NULL, 'dropped'), 
(10014, 'IT405', '2024S1', 88.00, 'active'),
(10015, 'IT102', '2024S1', NULL, 'dropped'), 
(10015, 'IT403', '2024S1', 90.00, 'active'),
(10016, 'IT401', '2024S1', 75.00, 'active'),
(10016, 'IT103', '2024S1', NULL, 'dropped'),  
(10017, 'IT102', '2024S2', 70.00, 'active'),
(10017, 'IT404', '2024S2', 68.00, 'active'),
(10018, 'IT101', '2024S2', 60.00, 'active'),
(10018, 'IT401', '2024S2', 80.00, 'active'),
(10019, 'IT105', '2024S2', 82.00, 'active'),
(10019, 'IT402', '2024S2', 90.00, 'active'),
(10020, 'IT403', '2024S2', 94.00, 'active'),
(10020, 'IT101', '2024S2', 78.00, 'active');


-- Insert data into Fee table
-- Update on 07/10/2024: updated data for fee_amount column 
INSERT INTO Fee (student_id, semester, fee_amount, status, description) VALUES
(10001, '2023S1', 6500.00, 'PAID', 'Tuition Fee'),
(10001, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10002, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10002, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10003, '2023S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10003, '2023S2', 7500.00, 'UNPAID', 'Tuition Fee'),
(10004, '2023S1', 8500.00, 'PAID', 'Tuition Fee'),
(10004, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10005, '2023S1', 6500.00, 'UNPAID', 'Tuition Fee'),
(10005, '2023S2', 6500.00, 'PAID', 'Late Unit Enrollment Fee'),
(10006, '2023S2', 7500.00, 'PAID', 'Tuition Fee'),
(10006, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10007, '2023S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10007, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10008, '2024S1', 8500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10009, '2023S2', 6500.00, 'UNPAID', 'Tuition Fee'),
(10009, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10010, '2023S2', 6500.00, 'PAID', 'Tuition Fee'),
(10010, '2024S1', 8500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10011, '2024S2', 7500.00, 'UNPAID', 'Tution Fee'),
(10012, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10012, '2024S2', 6500.00, 'PAID', 'Tuition Fee'),
(10013, '2024S1', 6500.00, 'PAID', 'Tuition Fee'),
(10013, '2024S2', 7500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10014, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10014, '2024S2', 8500.00, 'PAID', 'Dropped Unit Penalty'),
(10015, '2024S1', 7500.00, 'UNPAID', 'Tuition Fee'),
(10015, '2024S2', 6500.00, 'UNPAID', 'Tution Fee'),
(10016, '2024S1', 7500.00, 'PAID', 'Tuition Fee'),
(10016, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10017, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10017, '2023S2', 6500.00, 'UNPAID', 'Late Unit Enrollment Fee'),
(10018, '2024S2', 7500.00, 'PAID', 'Tuition Fee'),
(10018, '2023S2', 6500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10019, '2024S2', 8500.00, 'PAID', 'Tuition Fee'),
(10019, '2023S2', 7500.00, 'PAID', 'Tution Fee'),
(10020, '2024S2', 7500.00, 'UNPAID', 'Dropped Unit Penalty'),
(10020, '2023S2', 8500.00, 'PAID', 'Tuition Fee');

-- PART A: Database Programming and Implementation
-- Task 1: Insert data
INSERT INTO Student (student_id, student_name, is_current) VALUES
(10021, 'Felipe Hipolito', 'YES'),
(10022, 'Grete Klovaite', 'NO'),
(10023, 'Vivi Pham', 'YES');

INSERT INTO Unit (unit_code, unit_name, is_advanced, enrollment, registration_date) VALUES
('IT104', 'AI for Text and Vision', 'YES', 15, '2023-02-20'),
('IT406', 'Big Data', 'YES', 25, '2023-02-20'),
('FI101', 'Introduction to Finance', 'NO', 50, '2023-02-20'),
('FI102', 'Financial Statement Analysis', 'NO', 30, '2023-02-20'); 

-- Task 2: Stored function that determines a student's total outstanding balance
DROP FUNCTION IF EXISTS Outstanding_Balance;
DELIMITER //

CREATE FUNCTION Outstanding_Balance (p_student_id INT)
	RETURNS DECIMAL(10, 2)
    DETERMINISTIC
	BEGIN
		DECLARE total_balance DECIMAL(10, 2) DEFAULT 0;

		SELECT COALESCE(- SUM(fee_amount), 0) INTO total_balance
		FROM Fee
		WHERE student_id = p_student_id
		AND status = 'UNPAID';

		RETURN total_balance;
    END //
DELIMITER ;

-- Task 3: Stored procedure that implements business rules BR6, BR2, BR4
DROP PROCEDURE IF EXISTS Condition_Checking;
DELIMITER //

CREATE PROCEDURE Condition_Checking(
    IN stu_student_id INT,
    IN stu_unit_id VARCHAR(15),
    IN stu_semester VARCHAR(15),
    IN stu_action ENUM('Register unit', 'Drop unit')
)
BEGIN
    DECLARE var_outstanding_balance DECIMAL(10, 2);
    DECLARE var_failed_units INT;
    DECLARE var_is_advanced_unit INT;
    DECLARE var_drop_deadline DATE;
    DECLARE var_current_date DATE;
    DECLARE var_penalty_amount DECIMAL(10, 2);
    DECLARE var_enrolled_unit INT;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An error occurred during the process.';
    END;

    START TRANSACTION;
	CASE
		WHEN stu_action = 'Register unit' THEN
			-- Get outstanding balance using the stored function
			SET var_outstanding_balance = Outstanding_Balance(stu_student_id);

			-- Get number of failed units
			SELECT COUNT(*) INTO var_failed_units
			FROM UnitGrade
			WHERE student_id = stu_student_id AND marks < 50.00;

			-- Check if the unit is advanced-level
			SELECT is_advanced INTO var_is_advanced_unit
			FROM Unit
			WHERE unit_code = stu_unit_id;

			-- BR6: Prevent enrollment in advanced units if conditions are not met
			IF var_is_advanced_unit = 'YES' AND (var_outstanding_balance < 0 OR var_failed_units > 2) THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot enroll in advanced-level unit due to outstanding balance or failed units.';
			END IF;

			-- BR2: Enforce registration based on outstanding balance
			IF var_outstanding_balance < 0 THEN
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Cannot enroll due to outstanding balance from previous semester.';
			END IF;
			
			-- Enroll the student
			INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) VALUES
			(stu_student_id, stu_unit_id, stu_semester, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 28 DAY), NULL, 'active');
		ELSE BEGIN END;
	END CASE;
    CASE
		WHEN stu_action = 'Drop unit' THEN
			-- Check if student enrolled in unit
            SELECT COUNT(*) INTO var_enrolled_unit
            FROM Registration
            WHERE student_id = stu_student_id AND unit_code = stu_unit_id AND semester = stu_semester;
            
            IF var_enrolled_unit > 0 THEN
				-- BR4: Set up for potential penalty
				SELECT no_penalty_deadline INTO var_drop_deadline
				FROM Registration
				WHERE unit_code = stu_unit_id;

				SET var_current_date = CURDATE();
				IF var_is_advanced_unit = 'YES' THEN SET var_penalty_amount = 600.00;
				ELSE SET var_penalty_amount = 400.00;
				END IF;

				-- If current date is after drop deadline, update record in Registration table and apply penalty 
				IF var_current_date > var_drop_deadline THEN
                    UPDATE Registration
					SET dropped_out_date = CURDATE() AND status = 'dropped_with_penalty'
                    WHERE student_id = stu_student_id AND unit_code = stu_unit_id AND semester = stu_semester;
                    
                    INSERT INTO Fee (student_id, semester, fee_amount, status, description) VALUES
					(stu_student_id, stu_semester, var_penalty_amount, 'UNPAID', 'Dropped Unit Penalty');
				-- If current date is before drop deadline, update record in Registration table
				ELSE
					UPDATE Registration
					SET dropped_out_date = CURDATE() AND status = 'dropped_without_penalty'
                    WHERE student_id = stu_student_id AND unit_code = stu_unit_id AND semester = stu_semester;
				END IF;
			ELSE 
				SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'Unit not enrolled.';
			END IF;
		ELSE BEGIN END;
	END CASE;
    COMMIT;
END //

DELIMITER ;

-- Task 5: Add test data
INSERT INTO Registration (student_id, unit_code, semester, registration_date, no_penalty_deadline, dropped_out_date, status) VALUES
(10021, 'IT101', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'), 
(10021, 'IT102', '2024S1', '2024-01-15', '2024-02-12', '2024-02-11', 'dropped_without_penalty'),
(10022, 'IT104', '2023S1', '2023-01-15', '2023-02-12', NULL, 'active'),
(10022, 'IT406', '2024S1', '2024-01-15', '2024-02-12', '2024-02-15', 'dropped_with_penalty'),
(10023, 'FI101', '2024S1', '2023-01-15', '2023-02-12', NULL, 'active'),
(10023, 'FI102', '2024S2', '2024-07-15', '2023-08-12', NULL, 'active'),
(10023, 'IT406', '2024S2', '2024-07-15', '2023-08-12', NULL, 'active');

INSERT INTO UnitGrade (student_id, unit_code, semester, marks, status) VALUES
(10021, 'IT101', '2023S1', 70.00, 'active'),
(10021, 'IT102', '2024S1', NULL, 'dropped'),
(10022, 'IT104', '2023S1', 90.00, 'active'),
(10022, 'IT406', '2024S1', NULL, 'dropped'),
(10023, 'FI101', '2024S1', 45.00, 'active'),
(10023, 'FI102', '2024S2', 35.00, 'active'),
(10023, 'IT406', '2024S2', 30.00, 'active');

INSERT INTO Fee (student_id, semester, fee_amount, status, description) VALUES
(10021, '2023S1', 3000.00, 'PAID', 'Tuition Fee'),
(10022, '2023S1', 4000.00, 'PAID', 'Tuition Fee'),
(10022, '2024S1', 4400.00, 'UNPAID', 'Dropped Unit Penalty'),
(100223, '2024S1', 3000.00, 'PAID', 'Tuition Fee'),
(100223, '2024S2', 3000.00, 'PAID', 'Tuition Fee'),
(100223, '2024S2', 4000.00, 'UNPAID', 'Tuition Fee');

