CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    department VARCHAR(80) NOT NULL
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(120) NOT NULL,
    credit_hours INT NOT NULL CHECK (credit_hours BETWEEN 1 AND 6)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    course_id INT NOT NULL REFERENCES courses(course_id),
    grade DECIMAL(4,2) CHECK (grade BETWEEN 0 AND 4),
    UNIQUE(student_id, course_id)
);

INSERT INTO students (full_name, email, department) VALUES
('Ahmed Ali', 'ahmed@example.com', 'Computer Science'),
('Sara Mohamed', 'sara@example.com', 'Data Science'),
('Omar Hassan', 'omar@example.com', 'Information Systems');

INSERT INTO courses (course_name, credit_hours) VALUES
('Python Programming', 3),
('Database Systems', 3),
('Machine Learning', 4);

INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 1, 3.5),
(1, 2, 3.0),
(2, 1, 3.8),
(2, 3, 3.6),
(3, 2, 2.9);

-- Students with their courses and grades
SELECT s.full_name, c.course_name, e.grade
FROM enrollments e
JOIN students s ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
ORDER BY s.full_name;

-- Average grade per student
SELECT s.full_name, ROUND(AVG(e.grade), 2) AS average_grade
FROM students s
JOIN enrollments e ON e.student_id = s.student_id
GROUP BY s.student_id, s.full_name
ORDER BY average_grade DESC;

-- Course enrollment counts
SELECT c.course_name, COUNT(e.enrollment_id) AS students_count
FROM courses c
LEFT JOIN enrollments e ON e.course_id = c.course_id
GROUP BY c.course_id, c.course_name;
