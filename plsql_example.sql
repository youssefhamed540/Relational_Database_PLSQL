-- Oracle PL/SQL example
DECLARE
    v_student_name VARCHAR2(100);
    v_average NUMBER;
BEGIN
    SELECT s.full_name, AVG(e.grade)
    INTO v_student_name, v_average
    FROM students s
    JOIN enrollments e ON e.student_id = s.student_id
    WHERE s.student_id = 1
    GROUP BY s.full_name;

    DBMS_OUTPUT.PUT_LINE(
        'Student: ' || v_student_name ||
        ' | Average: ' || ROUND(v_average, 2)
    );
END;
/
