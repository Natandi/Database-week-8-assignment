-- Create Instructors Table
CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Create Courses Table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

-- Create Students Table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    enrollment_year INT NOT NULL
);

-- Create Enrollments Table (Many-to-Many between Students and Courses)
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (student_id, course_id) -- To prevent duplicate enrollments
);

-- Sample Data
INSERT INTO instructors (name, email) VALUES
('Dr. Smith', 'smith@example.com'),
('Prof. Jane', 'jane@example.com');

INSERT INTO courses (title, instructor_id) VALUES
('Mathematics', 1),
('Computer Science', 2);

INSERT INTO students (name, email, enrollment_year) VALUES
('Alice Johnson', 'alice@example.com', 2023),
('Bob Lee', 'bob@example.com', 2022);

INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 'A'),
(2, 2, 'B');
