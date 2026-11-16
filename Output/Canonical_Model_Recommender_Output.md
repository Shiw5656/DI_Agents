#### Data Domain: Student and Academic Participation
**Description:** This domain covers the core student lifecycle in academic operations, including student identity, academic status, programme participation, and course enrollment. It supports admissions, programme enrollment, student status tracking, and participation in scheduled learning activities.
| Entity Name | Entity Description |
|---|---|
| Student | A learner participating in the institution’s academic programmes, with personal and academic attributes such as name, birth date, grade level, candidate code, admission date, and enrollment status. |
| Student Programme Enrollment | The student’s participation in an IB programme at a school, including candidate type, start date, expected graduation date, and programme status. |
| Course Enrollment | The student’s enrollment in a specific course section, including enrollment status, selected course level, enrollment date, and drop date. |

#### Data Domain: Academic Structure and Delivery
**Description:** This domain represents the academic offerings and delivery structure used by the institution, including programmes, courses, sections, schools, academic terms, and teaching assignments. It supports programme delivery, course scheduling, and instructional organization.
| Entity Name | Entity Description |
|---|---|
| School | An IB school delivering academic programmes, identified by school code and described by attributes such as school name, country, city, time zone, and authorized programmes. |
| Academic Term | A defined instructional period in which courses and sections are offered, including term name, academic year, start date, end date, and instructional days. |
| Programme | An IB academic programme such as PYP, MYP, DP, or CP, including programme name and age range. |
| Course | An academic subject or learning offering delivered within a programme, described by course name, programme code, subject group, subject area, level, language of instruction, teaching hours, and core-course indicator. |
| Course Section | A scheduled instance of a course offered to students, with operational details such as section code, room, schedule period, capacity, and section status. |
| Section Offering | The business concept representing a course section as offered by a specific school in a specific academic term, combining section, course, school, and term into a single academic offering context. |
| Teacher | An educator responsible for teaching and academic delivery, with details such as name, email, department, certification status, and active status. |
| Section Teacher Assignment | The assignment of a teacher to a course section, including the instructional role such as primary teacher, co-teacher, or substitute. |

#### Data Domain: Attendance and Engagement
**Description:** This domain captures student attendance events and derived attendance measures used to monitor participation, lateness, absences, and attendance performance over time. It supports attendance tracking, intervention, and operational monitoring.
| Entity Name | Entity Description |
|---|---|
| Attendance Event | A recorded attendance occurrence for a student in a course section on a specific date and period, including attendance status, minutes late, absence reason, and recording details. |
| Attendance Status | A reference classification defining attendance outcomes such as present, late, excused absence, and unexcused absence, including indicators for presence and excusal. |
| Enrollment Attendance Summary | A summarized attendance view for a student’s course enrollment, including counts of present, late, excused absent, and unexcused absent days, along with attendance percentage. |

#### Data Domain: Assessment and Academic Performance
**Description:** This domain manages assessment definitions and student assessment outcomes used to evaluate academic progress and performance. It supports assessment coordination, grading analysis, predicted results, and academic monitoring.
| Entity Name | Entity Description |
|---|---|
| Assessment | An academic evaluation component associated with coursework or programme requirements, such as internal assessments, essays, exams, or CAS-related assessments, including type, maximum score, weighting, and internal indicator. |
| Assessment Result | A student’s outcome for an assessment within a course section, including raw score, IB grade, predicted grade, result type, assessed date, and assessor information. |