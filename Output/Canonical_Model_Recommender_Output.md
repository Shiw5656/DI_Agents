#### Data Domain: Student & Programme Participation
**Description:** This domain covers the lifecycle of student participation in the institution, including student identity, academic standing, admission context, and participation in IB programmes at a school.
| Entity Name | Entity Description |
|---|---|
| Student | A learner enrolled or participating in the school, represented with personal and academic profile information such as name, birth date, grade level, candidate code, admission date, and enrollment status. |
| Student Programme Participation | The association of a student with an IB programme at a school, including candidate type, programme status, start date, and expected graduation date. |
| Programme | An IB educational programme such as PYP, MYP, DP, or CP, including its name and age range. |
| School | An IB school delivering programmes and courses, identified by school code and described by location, timezone, and authorized programmes. |

#### Data Domain: Academic Catalogue & Delivery
**Description:** This domain represents the academic structure used to define what is taught, when and where it is offered, and how instructional delivery is organized across schools and terms.
| Entity Name | Entity Description |
|---|---|
| Course | An academic offering or subject, such as an IB course or core component, described by course name, programme code, subject area, level, language of instruction, and teaching hours. |
| Course Section | A scheduled delivery instance of a course, represented by section-specific details such as section code, room, schedule period, capacity, and status. |
| Section Offering | The business concept that a course section is offered for a specific course in a given academic term at a specific school. |
| Academic Term | A defined instructional period such as a semester or term, described by term name, academic year, start date, end date, and instructional days. |

#### Data Domain: Teaching Workforce Assignment
**Description:** This domain covers instructional staff and their assignment to course delivery, supporting visibility into who teaches which sections and in what capacity.
| Entity Name | Entity Description |
|---|---|
| Teacher | A staff member responsible for instruction, described by identity, contact information, department, certification status, and active status. |
| Section Teacher Assignment | The assignment of a teacher to a course section, including the teaching role such as primary teacher, co-teacher, or substitute. |

#### Data Domain: Enrollment Management
**Description:** This domain tracks student participation in scheduled course sections, including enrollment status and course-level choices made by the student.
| Entity Name | Entity Description |
|---|---|
| Enrollment | A student's registration in a specific course section, including enrollment status, selected course level, enrollment date, and drop date. |

#### Data Domain: Attendance Monitoring
**Description:** This domain captures attendance events and attendance outcomes to support operational monitoring, intervention, and summarized attendance analysis over time.
| Entity Name | Entity Description |
|---|---|
| Attendance Event | A recorded instance of a student's attendance for a specific course section on a given date and period, including status, lateness, absence reason, and audit details about who recorded it and when. |
| Attendance Status | A reference classification for attendance outcomes, such as present, late, excused absence, or unexcused absence, including indicators for presence and excused status. |
| Enrollment Attendance Summary | A summarized view of attendance measures for an enrollment, including counts of present, late, excused absence, unexcused absence, and overall attendance percentage. |

#### Data Domain: Assessment & Academic Performance
**Description:** This domain covers the definition of assessments and the capture of student results used to evaluate academic performance and predicted or final outcomes.
| Entity Name | Entity Description |
|---|---|
| Assessment | An evaluative component associated with academic work, such as an internal assessment, exam, extended essay, TOK essay, or CAS-related measure, described by type, scoring range, and weighting. |
| Assessment Result | A student's recorded outcome for an assessment in a course section, including raw score, IB grade, predicted grade, result type, assessed date, and assessor information. |