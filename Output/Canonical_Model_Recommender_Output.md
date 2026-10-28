#### Data Domain: Student Management
**Description:** Covers the core student master data and the student's academic identity and standing within the institution.
| Entity Name | Entity Description |
|---|---|
| Student | Represents an individual learner, combining personal identification and academic attributes such as name, birth date, grade level, candidate code, enrollment status, and admission details. |
| Student Programme Enrollment | Represents a student's participation in an academic programme at a school, including candidate type, programme start date, expected graduation date, and programme status. |

#### Data Domain: Academic Programme and Curriculum
**Description:** Covers the academic structures that define what is taught, including programmes, courses, and the way courses are organized into sections.
| Entity Name | Entity Description |
|---|---|
| Programme | Represents an academic programme such as PYP, MYP, DP, or CP, including its name and age range. |
| Course | Represents an academic course within a programme, including course name, subject area, subject group, level, language of instruction, recommended teaching hours, and whether it is a core requirement. |
| Course Section | Represents a scheduled section of a course, including section code, room, schedule period, capacity, and section status. |

#### Data Domain: Academic Operations
**Description:** Covers the operational setup and delivery context for academic activities, including schools, academic terms, section offerings, and teacher assignments.
| Entity Name | Entity Description |
|---|---|
| School | Represents an educational institution delivering programmes and courses, including school name, location, time zone, and authorized programmes. |
| Academic Term | Represents a defined teaching period within an academic year, including term name, academic year, start date, end date, and instructional days. |
| Section Offering | Represents the business context in which a course section is offered at a particular school during a specific academic term for a course. |
| Teacher | Represents an instructor or staff member involved in academic delivery, including identity, department, certification status, and active status. |
| Section Teacher Assignment | Represents the assignment of a teacher to a course section, including the teacher's role such as primary, co-teacher, or substitute. |

#### Data Domain: Enrollment Management
**Description:** Covers the student's participation in specific course sections and the lifecycle of those enrollments.
| Entity Name | Entity Description |
|---|---|
| Course Enrollment | Represents a student's enrollment in a course section, including enrollment status, selected course level, enrollment date, and drop date. |

#### Data Domain: Attendance Management
**Description:** Covers the recording and interpretation of student attendance for scheduled course section participation.
| Entity Name | Entity Description |
|---|---|
| Attendance Event | Represents a student's attendance occurrence for a course section on a specific date and period, including attendance status, lateness, absence reason, and recording details. |
| Attendance Status | Represents the reference classification of attendance outcomes, such as present, absent, late, or excused, and indicates whether the status counts as present or excused. |
| Attendance Summary | Represents the summarized attendance performance for a student's course enrollment, including days present, days late, excused and unexcused absences, and attendance percentage. |

#### Data Domain: Assessment and Achievement
**Description:** Covers academic assessments and the results achieved by students within course sections.
| Entity Name | Entity Description |
|---|---|
| Assessment | Represents an assessment activity associated with academic evaluation, including assessment name, type, internal indicator, maximum score, and weight percentage. |
| Assessment Result | Represents a student's outcome for an assessment within a course section, including raw score, IB grade, predicted grade, result type, assessment date, and assessor. |