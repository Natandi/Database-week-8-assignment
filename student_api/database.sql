-- Create the database (if it doesn't exist)
CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;

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

-- Create Enrollments Table (Many-to-Many)
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (student_id, course_id)
);
