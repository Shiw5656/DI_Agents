# Data Vault Glossary and Data Dictionary

## Executive Overview

This document is the glossary and data dictionary for the IB Data Vault (schema `Ib`), which models the International Baccalaureate School Academic Management domain: students, teachers, courses and sections, schools, academic terms, IB programmes, enrollments, attendance and assessments.

Sources used:

- SQL Server DDL: `IB_datavault_2.txt` (authoritative for tables, columns, types and declared constraints).
- Profiling results: `IB_Data_Profile_Report.pdf` (measured on 58 synthetic sample records across 13 datasets, 92 columns).

Table overview:

| Component | Count |
|---|---|
| Hubs | 8 |
| Links | 6 |
| Satellites | 13 |
| Reference | 1 |
| Business Vault | 1 |
| **Total tables** | **29** |

Limitations:

- Profiling is based on synthetic sample records only. Hash keys and other Data Vault technical metadata (Hk, LoadDts, LoadEndDts, HashDiff, RecordSource) are not part of the profiled workbook, so they are NOT_RUN.
- Profile datasets use business names (for example `Students`), not Data Vault table names. The dataset-to-table mapping in the Data Profiling Summary is inferred by name.
- Four tables have no matching profile dataset and are NOT_RUN: LnkSectionOffering, LnkSectionTeacher, LnkStudentProgramme, SatStudentProgrammeDetails.
- Profiler regex and type-detection artifacts are reported as profiler limitations, not as data defects.

## Table Inventory

| Schema | Table Name | Table Type | Business Description |
|---|---|---|---|
| Ib | HubStudent | Hub | Represents a student. |
| Ib | HubTeacher | Hub | Represents a teacher. |
| Ib | HubCourse | Hub | Represents a course. |
| Ib | HubCourseSection | Hub | Represents a specific section of a course. |
| Ib | HubSchool | Hub | Represents a school. |
| Ib | HubAcademicTerm | Hub | Represents an academic term. |
| Ib | HubProgramme | Hub | Represents an IB programme (e.g., PYP, MYP, DP, CP). |
| Ib | HubAssessment | Hub | Represents an assessment. |
| Ib | LnkSectionOffering | Link | A section is one course offered in one term at one school. |
| Ib | LnkSectionTeacher | Link | Teacher assigned to a section, by role (PRIMARY, CO-TEACHER, SUBSTITUTE). |
| Ib | LnkStudentProgramme | Link | Student in an IB programme at a school. |
| Ib | LnkEnrollment | Link | Student enrolled in a section. |
| Ib | LnkAttendance | Link | Attendance event: student + section + date + period. |
| Ib | LnkAssessmentResult | Link | Student result for an assessment in a section. |
| Ib | SatStudentPersonal | Satellite | Personal and PII attributes of a student. |
| Ib | SatStudentAcademic | Satellite | Academic attributes of a student. |
| Ib | SatTeacherDetails | Satellite | Details of a teacher. |
| Ib | SatCourseDetails | Satellite | Details of a course. |
| Ib | SatCourseSectionDetails | Satellite | Details of a course section. |
| Ib | SatSchoolDetails | Satellite | Details of a school. |
| Ib | SatAcademicTermDetails | Satellite | Details of an academic term. |
| Ib | SatProgrammeDetails | Satellite | Details of a programme. |
| Ib | SatAssessmentDetails | Satellite | Details of an assessment. |
| Ib | SatEnrollmentDetails | Satellite | Details of a student's enrollment in a section. |
| Ib | SatStudentProgrammeDetails | Satellite | Details of a student's programme enrollment. |
| Ib | SatAttendanceDetails | Satellite | Details of a student's attendance. |
| Ib | SatAssessmentResult | Satellite | Details of a student's assessment result. |
| Ib | RefAttendanceStatus | Reference | Reference table for attendance status codes. |
| Ib | BvSatAttendanceSummary | Business Vault | Computed satellite for attendance summary per enrollment. |

## Column Data Dictionary

### HubStudent (Hub)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Hash key for the student | binary(32) | PK, HK | |
| StudentBk | Business key for the student (school student ID) | varchar(50) | BK | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### HubTeacher (Hub)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| TeacherHk | Hash key for the teacher | binary(32) | PK, HK | |
| TeacherBk | Business key for the teacher (staff ID) | varchar(50) | BK | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### HubCourse (Hub)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseHk | Hash key for the course | binary(32) | PK, HK | |
| CourseBk | Business key for the course (e.g. MATH-AA-HL) | varchar(50) | BK | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### HubCourseSection (Hub)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseSectionHk | Hash key for the course section | binary(32) | PK, HK | |
| CourseSectionBk | Composite business key: school code, term code, course code, section code joined by \|\| | varchar(120) | BK | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### HubSchool (Hub)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SchoolHk | Hash key for the school | binary(32) | PK, HK | |
| SchoolBk | Business key for the school (IB school code) | varchar(20) | BK | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### HubAcademicTerm (Hub)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AcademicTermHk | Hash key for the academic term | binary(32) | PK, HK | |
| AcademicTermBk | Business key for the academic term (e.g. 2025-FALL) | varchar(30) | BK | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### HubProgramme (Hub)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| ProgrammeHk | Hash key for the programme | binary(32) | PK, HK | |
| ProgrammeBk | Business key for the programme (PYP, MYP, DP, CP) | varchar(10) | BK | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### HubAssessment (Hub)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentHk | Hash key for the assessment | binary(32) | PK, HK | |
| AssessmentBk | Business key for the assessment (e.g. MATH-AA-HL-IA, EE, TOK-ESSAY, CAS) | varchar(60) | BK | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### LnkSectionOffering (Link)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SectionOfferingHk | Hash key for the link | binary(32) | PK, HK | |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| CourseHk | Foreign key to HubCourse | binary(32) | FK | HubCourse |
| AcademicTermHk | Foreign key to HubAcademicTerm | binary(32) | FK | HubAcademicTerm |
| SchoolHk | Foreign key to HubSchool | binary(32) | FK | HubSchool |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### LnkSectionTeacher (Link)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SectionTeacherHk | Hash key for the link | binary(32) | PK, HK | |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| TeacherHk | Foreign key to HubTeacher | binary(32) | FK | HubTeacher |
| TeacherRole | Role of the teacher in the section | varchar(20) | | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### LnkStudentProgramme (Link)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentProgrammeHk | Hash key for the link | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| ProgrammeHk | Foreign key to HubProgramme | binary(32) | FK | HubProgramme |
| SchoolHk | Foreign key to HubSchool | binary(32) | FK | HubSchool |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### LnkEnrollment (Link)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Hash key for the link | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### LnkAttendance (Link)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceHk | Hash key for the link | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| AttendanceDate | Date of the attendance event | date | | |
| PeriodNumber | Period number of the attendance event | tinyint | | |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### LnkAssessmentResult (Link)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentResultHk | Hash key for the link | binary(32) | PK, HK | |
| StudentHk | Foreign key to HubStudent | binary(32) | FK | HubStudent |
| AssessmentHk | Foreign key to HubAssessment | binary(32) | FK | HubAssessment |
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | FK | HubCourseSection |
| LoadDts | Load date/time stamp | datetime2(7) | Metadata | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatStudentPersonal (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Foreign key to HubStudent | binary(32) | PK, FK | HubStudent |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| FirstName | Student's first name | varchar(100) | | |
| MiddleName | Student's middle name | varchar(100) | | |
| LastName | Student's last name | varchar(100) | | |
| PreferredName | Student's preferred name | varchar(100) | | |
| BirthDate | Student's birth date | date | | |
| Gender | Student's gender | char(1) | | |
| Nationality | Student's nationality (ISO 3166-1 alpha-2) | varchar(2) | | |
| NativeLanguage | Student's native language | varchar(50) | | |
| Email | Student's email address | varchar(255) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatStudentAcademic (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentHk | Foreign key to HubStudent | binary(32) | PK, FK | HubStudent |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| GradeLevel | Student's grade level (e.g. Grade 11 / Year 12) | varchar(10) | | |
| IbCandidateCode | IB candidate (personal) code | varchar(20) | | |
| EnrollmentStatus | Student's enrollment status (Active, Withdrawn, Graduated) | varchar(20) | | |
| AdmissionDate | Student's admission date | date | | |
| HouseOrHomeroom | Student's house or homeroom | varchar(30) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatTeacherDetails (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| TeacherHk | Foreign key to HubTeacher | binary(32) | PK, FK | HubTeacher |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| FirstName | Teacher's first name | varchar(100) | | |
| LastName | Teacher's last name | varchar(100) | | |
| Email | Teacher's email address | varchar(255) | | |
| Department | Teacher's department | varchar(100) | | |
| IbWorkshopCertified | Whether the teacher is IB workshop certified | bit | | |
| IsActive | Whether the teacher is active | bit | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatCourseDetails (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseHk | Foreign key to HubCourse | binary(32) | PK, FK | HubCourse |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| CourseName | Name of the course | varchar(200) | | |
| ProgrammeCode | Programme code (PYP, MYP, DP, CP) | varchar(10) | | |
| SubjectGroup | DP subject group (1-6) | tinyint | | |
| SubjectArea | Subject area | varchar(100) | | |
| CourseLevel | Course level (HL, SL, Standard) | varchar(10) | | |
| LanguageOfInstruction | Language of instruction | varchar(50) | | |
| TeachingHours | Recommended teaching hours (240 HL / 150 SL) | smallint | | |
| IsCore | Whether the course is a core requirement (TOK, EE, CAS) | bit | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatCourseSectionDetails (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| CourseSectionHk | Foreign key to HubCourseSection | binary(32) | PK, FK | HubCourseSection |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| SectionCode | Section code | varchar(20) | | |
| Room | Room number | varchar(30) | | |
| SchedulePeriod | Schedule period | varchar(30) | | |
| Capacity | Section capacity | smallint | | |
| SectionStatus | Section status | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatSchoolDetails (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| SchoolHk | Foreign key to HubSchool | binary(32) | PK, FK | HubSchool |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| SchoolName | Name of the school | varchar(200) | | |
| CountryCode | Country code | varchar(2) | | |
| City | City | varchar(100) | | |
| TimeZone | Time zone | varchar(50) | | |
| AuthorizedProgrammes | Authorized programmes (e.g. PYP,MYP,DP) | varchar(50) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatAcademicTermDetails (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AcademicTermHk | Foreign key to HubAcademicTerm | binary(32) | PK, FK | HubAcademicTerm |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| TermName | Name of the term | varchar(50) | | |
| AcademicYear | Academic year (2025-2026) | varchar(9) | | |
| StartDate | Start date of the term | date | | |
| EndDate | End date of the term | date | | |
| InstructionalDays | Number of instructional days | smallint | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatProgrammeDetails (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| ProgrammeHk | Foreign key to HubProgramme | binary(32) | PK, FK | HubProgramme |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| ProgrammeName | Name of the programme | varchar(100) | | |
| AgeRange | Age range for the programme (3-12, 11-16, 16-19) | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatAssessmentDetails (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentHk | Foreign key to HubAssessment | binary(32) | PK, FK | HubAssessment |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| AssessmentName | Name of the assessment | varchar(200) | | |
| AssessmentType | Type of assessment (IA, EE, TOK, CAS, EXAM, INTERNAL) | varchar(20) | | |
| IsInternal | Whether the assessment is internal | bit | | |
| MaxScore | Maximum score for the assessment | decimal(8,2) | | |
| WeightPercent | Weight of the assessment in percentage | decimal(5,2) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatEnrollmentDetails (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Foreign key to LnkEnrollment | binary(32) | PK, FK | LnkEnrollment |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| EnrollmentStatus | Enrollment status (Enrolled, Dropped, Completed) | varchar(20) | | |
| CourseLevel | Course level chosen by the student (HL / SL) | varchar(10) | | |
| EnrollDate | Date of enrollment | date | | |
| DropDate | Date of dropping the course | date | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatStudentProgrammeDetails (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| StudentProgrammeHk | Foreign key to LnkStudentProgramme | binary(32) | PK, FK | LnkStudentProgramme |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| CandidateType | Candidate type (Diploma, Course candidate) | varchar(30) | | |
| StartDate | Start date of the programme | date | | |
| ExpectedGraduationDate | Expected graduation date | date | | |
| ProgrammeStatus | Programme status | varchar(20) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatAttendanceDetails (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceHk | Foreign key to LnkAttendance | binary(32) | PK, FK | LnkAttendance |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| AttendanceStatusCode | Attendance status code (P, A, L, E) | varchar(10) | | RefAttendanceStatus (logical, not declared) |
| MinutesLate | Minutes late | smallint | | |
| AbsenceReason | Reason for absence | varchar(200) | | |
| RecordedBy | Person who recorded the attendance | varchar(100) | | |
| RecordedDts | Date/time of recording | datetime2(7) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### SatAssessmentResult (Satellite)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AssessmentResultHk | Foreign key to LnkAssessmentResult | binary(32) | PK, FK | LnkAssessmentResult |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| HashDiff | Hash difference | binary(32) | Metadata | |
| RawScore | Raw score | decimal(8,2) | | |
| IbGrade | IB grade (1-7) | tinyint | | |
| PredictedGrade | Predicted grade (1-7) | tinyint | | |
| ResultType | Result type (Predicted, Internal, Moderated, Final) | varchar(20) | | |
| AssessedDate | Date of assessment | date | | |
| AssessedBy | Person who assessed | varchar(100) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

### RefAttendanceStatus (Reference)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| AttendanceStatusCode | Attendance status code | varchar(10) | PK | |
| StatusName | Name of the status | varchar(50) | | |
| IsPresent | Whether the status means present | bit | | |
| IsExcused | Whether the status means excused | bit | | |

### BvSatAttendanceSummary (Business Vault)

| Column Name | Column Description | Data Type | Key Column Flag | Referenced Table Name |
|---|---|---|---|---|
| EnrollmentHk | Foreign key to LnkEnrollment | binary(32) | PK, FK | LnkEnrollment |
| LoadDts | Load date/time stamp | datetime2(7) | PK, Metadata | |
| LoadEndDts | Load end date/time stamp | datetime2(7) | Metadata | |
| DaysPresent | Number of days present | int | | |
| DaysLate | Number of days late | int | | |
| DaysAbsentExcused | Number of excused absence days | int | | |
| DaysAbsentUnexcused | Number of unexcused absence days | int | | |
| AttendancePercent | Attendance percentage | decimal(5,2) | | |
| RecordSource | Source of the record | varchar(100) | Metadata | |

## Relationship Inventory

### Declared foreign keys

| Table Name | Column Name | Relationship Type | Referenced Table Name | Referenced Column Name |
|---|---|---|---|---|
| LnkSectionOffering | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| LnkSectionOffering | CourseHk | FOREIGN KEY | HubCourse | CourseHk |
| LnkSectionOffering | AcademicTermHk | FOREIGN KEY | HubAcademicTerm | AcademicTermHk |
| LnkSectionOffering | SchoolHk | FOREIGN KEY | HubSchool | SchoolHk |
| LnkSectionTeacher | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| LnkSectionTeacher | TeacherHk | FOREIGN KEY | HubTeacher | TeacherHk |
| LnkStudentProgramme | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| LnkStudentProgramme | ProgrammeHk | FOREIGN KEY | HubProgramme | ProgrammeHk |
| LnkStudentProgramme | SchoolHk | FOREIGN KEY | HubSchool | SchoolHk |
| LnkEnrollment | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| LnkEnrollment | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| LnkAttendance | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| LnkAttendance | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| LnkAssessmentResult | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| LnkAssessmentResult | AssessmentHk | FOREIGN KEY | HubAssessment | AssessmentHk |
| LnkAssessmentResult | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| SatStudentPersonal | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| SatStudentAcademic | StudentHk | FOREIGN KEY | HubStudent | StudentHk |
| SatTeacherDetails | TeacherHk | FOREIGN KEY | HubTeacher | TeacherHk |
| SatCourseDetails | CourseHk | FOREIGN KEY | HubCourse | CourseHk |
| SatCourseSectionDetails | CourseSectionHk | FOREIGN KEY | HubCourseSection | CourseSectionHk |
| SatSchoolDetails | SchoolHk | FOREIGN KEY | HubSchool | SchoolHk |
| SatAcademicTermDetails | AcademicTermHk | FOREIGN KEY | HubAcademicTerm | AcademicTermHk |
| SatProgrammeDetails | ProgrammeHk | FOREIGN KEY | HubProgramme | ProgrammeHk |
| SatAssessmentDetails | AssessmentHk | FOREIGN KEY | HubAssessment | AssessmentHk |
| SatEnrollmentDetails | EnrollmentHk | FOREIGN KEY | LnkEnrollment | EnrollmentHk |
| SatStudentProgrammeDetails | StudentProgrammeHk | FOREIGN KEY | LnkStudentProgramme | StudentProgrammeHk |
| SatAttendanceDetails | AttendanceHk | FOREIGN KEY | LnkAttendance | AttendanceHk |
| SatAssessmentResult | AssessmentResultHk | FOREIGN KEY | LnkAssessmentResult | AssessmentResultHk |
| BvSatAttendanceSummary | EnrollmentHk | FOREIGN KEY | LnkEnrollment | EnrollmentHk |

### Inferred logical relationships (not declared in the DDL)

| Table Name | Column Name | Relationship Type | Referenced Table Name | Referenced Column Name | Evidence |
|---|---|---|---|---|---|
| SatAttendanceDetails | AttendanceStatusCode | Logical | RefAttendanceStatus | AttendanceStatusCode | Same column name and code domain (P, A, L, E); no FK declared; profile found code X absent from the reference data |
| SatCourseDetails | ProgrammeCode | Logical | HubProgramme | ProgrammeBk | Both describe the programme code domain (PYP, MYP, DP, CP); no FK declared |
| LnkAttendance | StudentHk, CourseSectionHk | Logical | LnkEnrollment | StudentHk, CourseSectionHk | Same student and section key pair; attendance logically belongs to an existing enrollment; no FK declared |

## Documentation Gaps

| Table Name | Column Name | Gap Type | Description | Recommended Clarification |
|---|---|---|---|---|
| SatAttendanceDetails | AttendanceStatusCode | Missing Foreign Key | No declared FK to RefAttendanceStatus; profile found code X not in the reference data. Without it, invalid codes can be loaded. | Add FK from SatAttendanceDetails(AttendanceStatusCode) to RefAttendanceStatus(AttendanceStatusCode), or document why it is omitted. |
| HubStudent | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL describing the business purpose. |
| HubTeacher | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL describing the business purpose. |
| HubCourse | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL describing the business purpose. |
| HubCourseSection | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL describing the business purpose. |
| HubSchool | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL describing the business purpose. |
| HubAcademicTerm | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL describing the business purpose. |
| HubProgramme | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL describing the business purpose. |
| HubAssessment | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL describing the business purpose. |
| SatStudentPersonal | Nationality | DDL vs Profile Conflict | Declared varchar(2), described as ISO 3166-1 alpha-2; profile sample value "USA" (3 characters) does not fit. Sample finding, not a confirmed production defect. | Confirm the source sends alpha-2 codes; validate against ISO 3166-1 alpha-2 on load. |
| SatStudentAcademic | IbCandidateCode | Profiler Limitation | DDL declares varchar(20); profiler detected the column as Date. Profiler type detection, not a DDL defect. | Treat as a code; correct profiler type detection. |
| SatCourseSectionDetails | Capacity | Missing Constraint | Profile found Capacity = -5; no non-negative rule is documented for smallint Capacity. | Confirm in the DDL whether a CHECK exists; add Capacity >= 0 if not. |
| SatAssessmentResult | IbGrade | Missing Constraint | Profile found IbGrade = 8, outside the documented 1-7 range; tinyint accepts 8 and no range rule is documented. | Add or document a 1-7 validation rule. |
| SatAssessmentResult | RawScore | Missing Constraint | Profile found RawScore = -5 and a score above the assessment maximum (TOK-ESSAY 12 > MaxScore 10). No rule links RawScore to SatAssessmentDetails.MaxScore. | Document or enforce RawScore >= 0 and RawScore <= MaxScore in load logic. |
| SatEnrollmentDetails | EnrollDate, DropDate | Missing Constraint | Profile found a drop date before the enroll date (ENR1004). No chronology rule is documented. | Document or enforce DropDate >= EnrollDate. |
| BvSatAttendanceSummary | AttendancePercent | Missing Constraint | Profile found 150, above 100; decimal(5,2) allows it and the calculation rule is not documented. | Document the calculation and enforce 0-100. |
| LnkAttendance | AttendanceHk, AttendanceDate, PeriodNumber | Ambiguous Grain | Profile shows two rows sharing the same event-grain keys (student, section, date, period). The DDL material does not state which columns define the attendance hash key or enforce uniqueness. | Confirm the event grain and how AttendanceHk is built; enforce uniqueness where appropriate. |
| SatSchoolDetails | AuthorizedProgrammes | Ambiguous Column | Described as a list (e.g. PYP,MYP,DP) stored in one varchar(50) column; multi-valued content is not documented as a rule. | Document the delimiter and allowed values, or model as a link to HubProgramme. |
| LnkEnrollment | CourseSectionHk | Extract Completeness | Profile found an enrollment section key (IB-GB-002\|\|2026-SPRING\|\|MATH-AA-HL\|\|SEC-E) with no matching section in the sample extract. | Check extract completeness before treating it as a production orphan. |

## Data Profiling Summary

Source: IB_Data_Profile_Report.pdf (58 synthetic records, 13 datasets, 92 columns). All Status = MEASURED values come from the report. Dataset-to-table mapping is inferred by name.

### Dataset to table mapping (inferred)

| Profile Dataset | Mapped Tables |
|---|---|
| Students | HubStudent, SatStudentPersonal, SatStudentAcademic |
| Teachers | HubTeacher, SatTeacherDetails |
| Schools | HubSchool, SatSchoolDetails |
| AcademicTerms | HubAcademicTerm, SatAcademicTermDetails |
| Programmes | HubProgramme, SatProgrammeDetails |
| Courses | HubCourse, SatCourseDetails |
| CourseSections | HubCourseSection, SatCourseSectionDetails |
| Enrollments | LnkEnrollment, SatEnrollmentDetails |
| Attendance | LnkAttendance, SatAttendanceDetails |
| Assessments | HubAssessment, SatAssessmentDetails |
| AssessmentResults | LnkAssessmentResult, SatAssessmentResult |
| AttendanceSummary | BvSatAttendanceSummary |
| RefAttendanceStatus | RefAttendanceStatus |

### Profiling results

| Table Name | Column Name | Profiling Check | Result | Count | Percentage | Status |
|---|---|---|---|---|---|---|
| HubStudent | StudentBk | Uniqueness | 6 distinct, 0 duplicates | 6 of 6 | 100.0% | MEASURED |
| HubTeacher | TeacherBk | Uniqueness | 4 distinct, 0 duplicates | 4 of 4 | 100.0% | MEASURED |
| HubCourse | CourseBk | Uniqueness | 4 distinct, 0 duplicates | 4 of 4 | 100.0% | MEASURED |
| HubCourseSection | CourseSectionBk | Uniqueness | 4 distinct, 0 duplicates | 4 of 4 | 100.0% | MEASURED |
| HubSchool | SchoolBk | Uniqueness | 2 distinct, 0 duplicates | 2 of 2 | 100.0% | MEASURED |
| HubAcademicTerm | AcademicTermBk | Uniqueness | 2 distinct, 0 duplicates | 2 of 2 | 100.0% | MEASURED |
| HubProgramme | ProgrammeBk | Uniqueness | 4 distinct, 0 duplicates | 4 of 4 | 100.0% | MEASURED |
| HubAssessment | AssessmentBk | Uniqueness | 4 distinct, 0 duplicates | 4 of 4 | 100.0% | MEASURED |
| HubCourseSection | CourseSectionBk | Regex pattern match (^[A-Za-z0-9_-]+$) | 0.0% match; profiler regex does not allow the "\|\|" separator. Profiler limitation, not a data defect. Same result for CourseSectionBk in Enrollments, Attendance and AssessmentResults. | n/a | 0.0% | MEASURED (PROFILER LIMITATION) |
| SatStudentPersonal | Email | Email format | All non-null values match email pattern | n/a | 100.0% | MEASURED |
| SatTeacherDetails | Email | Email format | All non-null values match email pattern | n/a | 100.0% | MEASURED |
| SatStudentPersonal | MiddleName | Missing values | 4 missing | 4 of 6 | 66.7% | MEASURED |
| SatStudentPersonal | BirthDate | Missing values | 1 missing | 1 of 6 | 16.7% | MEASURED |
| SatStudentPersonal | Email | Missing values | 1 missing | 1 of 6 | 16.7% | MEASURED |
| SatStudentPersonal | Nationality | Format consistency | Value "USA" is not a two-character ISO alpha-2 code | 1 | n/a | MEASURED |
| SatStudentAcademic | IbCandidateCode | Type detection | Profiler detected Date; DDL type is varchar(20). Profiler limitation. | n/a | n/a | MEASURED (PROFILER LIMITATION) |
| SatTeacherDetails | Email | Missing values | 1 missing | 1 of 4 | 25.0% | MEASURED |
| SatTeacherDetails | IbWorkshopCertified | Missing values | 1 missing | 1 of 4 | 25.0% | MEASURED |
| SatCourseDetails | SubjectGroup | Missing values | 1 missing | 1 of 4 | 25.0% | MEASURED |
| SatCourseSectionDetails | Room | Missing values | 1 missing | 1 of 4 | 25.0% | MEASURED |
| SatCourseSectionDetails | Capacity | Valid range | Minimum -5 (negative capacity) | 1 | n/a | MEASURED |
| SatEnrollmentDetails | DropDate | Missing values | 5 missing | 5 of 6 | 83.3% | MEASURED |
| SatEnrollmentDetails | EnrollDate, DropDate | Date consistency | Drop date precedes enrollment date (ENR1004) | 1 | n/a | MEASURED |
| LnkEnrollment | CourseSectionHk (profile: CourseSectionBk) | Key presence in extract | Section key IB-GB-002\|\|2026-SPRING\|\|MATH-AA-HL\|\|SEC-E absent from the sample extract | 1 | n/a | MEASURED |
| SatAttendanceDetails | MinutesLate | Missing values | 1 missing | 1 of 8 | 12.5% | MEASURED |
| SatAttendanceDetails | AbsenceReason | Missing values | 6 missing | 6 of 8 | 75.0% | MEASURED |
| SatAttendanceDetails | AttendanceStatusCode | Referential integrity | Code "X" not present in RefAttendanceStatus | 1 | n/a | MEASURED |
| LnkAttendance | StudentBk, CourseSectionBk, AttendanceDate, PeriodNumber | Event-grain uniqueness | 2 rows share the same event-grain keys (potential duplicate) | 2 | n/a | MEASURED |
| SatAssessmentResult | IbGrade | Valid range (1-7) | Maximum 8, outside the documented range | 1 | n/a | MEASURED |
| SatAssessmentResult | RawScore | Valid range | Minimum -5 (negative score) | 1 | n/a | MEASURED |
| SatAssessmentResult | RawScore vs MaxScore | Score within assessment maximum | TOK-ESSAY score 12 exceeds MaxScore 10 | 1 | n/a | MEASURED |
| BvSatAttendanceSummary | AttendancePercent | Valid range (0-100) | Maximum 150 exceeds 100 | 1 | n/a | MEASURED |
| LnkSectionOffering | All columns | All checks | No matching profile dataset supplied | n/a | n/a | NOT_RUN |
| LnkSectionTeacher | All columns | All checks | No matching profile dataset supplied | n/a | n/a | NOT_RUN |
| LnkStudentProgramme | All columns | All checks | No matching profile dataset supplied | n/a | n/a | NOT_RUN |
| SatStudentProgrammeDetails | All columns | All checks | No matching profile dataset supplied | n/a | n/a | NOT_RUN |
| All tables | Hk, LoadDts, LoadEndDts, HashDiff, RecordSource columns | All checks | Technical Data Vault metadata is not included in the profiled workbook | n/a | n/a | NOT_RUN |
