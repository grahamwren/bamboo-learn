## README

![build status](https://travis-ci.org/grahamwren/bamboo-learn.svg?branch=master)

Public repository: https://github.com/grahamwren/bamboo-learn
* See README on Github
* To access the UI, please use the links below. The passwords are included in final report.  
   * [https://bamboo-learn.herokuapp.com/users/sign_in?user[email]=student@bamboo.com](Student)
   * [https://bamboo-learn.herokuapp.com/users/sign_in?user[email]=teacher@bamboo.com](Teacher)
   * [https://bamboo-learn.herokuapp.com/users/sign_in?user[email]=admin@bamboo.com](Admin)


Instructions on setting up local instance: 
* DO NOT SETUP THE DATABASE FROM THE PROVIDED MYSQL DUMP
* Ensure that you are running an OS based on Unix or Linux (if not go here)
* Run `git clone https://github.com/grahamwren/bamboo-learn.git` or unzip the package bamboo-learn.zip into the current directory
* Follow the instructions here https://gorails.com/setup/ubuntu/16.04 (apparently takes 30 mins), skipping the "final steps" instructions, or just go to https://bamboo-learn.herokuapp.com with the above links.


Page-by-page description:
* Homepage
    * Login
* /users/sign_in
    * Enter email and password
    * Change password
    * Unlock my account 
* /users/password/new 
    * Enter email and choose “Send me reset password instructions”
    * Use this path to change account password
* /users/unlock
    * Enter email and choose “Resend unlock instructions”
    * Use this path to recover accounts that have been locked after too many incorrect login attempts.


If logged in as a student:
* Student Homepage 
    * My Courses
    * Users
    * Registration
    * Logout
* /courses/_course_id_
    * Drop Course
    * List of assignments for this course with option of view 
    * If you click view, you can view assignment details, which include course name, description of assignment, total points, and due date.
* /users
    * List of users with option of view
    * If you click view, you can view user details, which include school id, email, first name, last name, date of birth, and user type.
    * User with option of edit: only for this user
    * If you click edit, you can edit you can view and edit your information, which include email, first name, last name, and date of birth.
* /registration
    * List of courses with option of add
    * If you click add, you can enroll yourself in the course.
    * List of courses with option of view
    * If you click view, you can view course details, which include short name, long name, description, and instructor.


If logged in as a teacher:
* Teacher Homepage 
    * My Courses
        * Courses this teacher is teaching display as “Lectures”, and courses this teacher is enrolled in as a student display as “My Courses”.
    * Users
    * Registration
    * Logout
* /courses/course_id
    * List of assignments for this course with option of edit
        * If you click edit,  you can edit assignment details, which include name of assignment, description of assignment, total points, and due date.
    * List of assignments for this course with option of delete
    * New Assignment 
* /assignments/new
    * If you click new assignment, you can create an assignment for this course and specify its name, description, total points, and due date.
* /users
    * List of users with option of view
    * If you click view, you can view user details, which include school id, email, first name, last name, date of birth, and user type.
    * User with option of edit: only for this user
        * If you click edit, you can edit you can view and edit your information, which include email, first name, last name, and date of birth.
* /registration
    * List of courses with options of add
        * If you click add, you can enroll yourself in the course.
    * List of courses with options of view
        * If you click view, you can view course details, which include short name, long name, description, and instructor.


If logged in as an admin:
* Admin Homepage 
    * Users
    * Registration
    * Logout
* /users
    * List of users with option of edit 
        * If you click edit, you can edit you can view and edit your information, which include email, first name, last name, and date of birth.
    * List of users with option of delete
    * Add User
* /users/new
    * If you click add user, you can create a user and specify his/her school id, email, first name, last name, description, date of birth, and user type.
* /registration
   * List of courses with options of add
        * If you click add, you can enroll yourself in the course.
    * List of courses with options of edit
        * If you click edit, you can edit course details, which include short name, long name, description, and instructor.
    * List of courses with option of delete
    * Create Course
* /courses/new
    * If you click on create course, you can create a course and specify its short name, long name, description, and instructor.
