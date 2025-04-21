from fastapi import FastAPI, HTTPException
import mysql.connector
from pydantic import BaseModel

app = FastAPI()
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import mysql.connector

app = FastAPI()

# Models
class Student(BaseModel):
    name: str
    email: str
    enrollment_year: int

# Function to get DB connection per request
def get_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Natalie@31!",
        database="student_db"
    )

# @app.get("/")
# def read_root():
#     return {"message": "It works!"}

@app.get("/")
def get_students():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM students")
    result = cursor.fetchall()
    db.close()
    return result

@app.post("/students")
def create_student(student: Student):
    try:
        db = get_db()
        cursor = db.cursor()
        cursor.execute(
            "INSERT INTO students (name, email, enrollment_year) VALUES (%s, %s, %s)",
            (student.name, student.email, student.enrollment_year)
        )
        db.commit()
        db.close()
        return {"message": "Student created"}
    except mysql.connector.IntegrityError as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.put("/students/{student_id}")
def update_student(student_id: int, student: Student):
    db = get_db()
    cursor = db.cursor()
    cursor.execute(
        "UPDATE students SET name=%s, email=%s, enrollment_year=%s WHERE student_id=%s",
        (student.name, student.email, student.enrollment_year, student_id)
    )
    db.commit()
    db.close()
    return {"message": "Student updated"}

@app.delete("/students/{student_id}")
def delete_student(student_id: int):
    db = get_db()
    cursor = db.cursor()
    cursor.execute("DELETE FROM students WHERE student_id=%s", (student_id,))
    db.commit()
    db.close()
    return {"message": "Student deleted"}
