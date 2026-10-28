# Data Vault Glossary and Data Dictionary

## Executive Overview

This document provides a complete data dictionary and glossary for the IB_datavault2 database. The documentation is generated from the SQL Server DDL file `IB_datavault 2.sql` and the data profiling plan `IB_DataVault_Data_Profiling_Plan.xlsx`. The database consists of 29 tables, including 8 Hubs, 6 Links, 13 Satellites, 1 Reference table, and 1 Business Vault table.

**Limitation**: The provided data profiling plan indicates that data-dependent checks have not been executed. Therefore, the Data Profiling Summary section only contains planned checks with a status of 'NOT_RUN'.

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
| CourseSectionBk | Business key for the course section (SchoolCode||TermCode||CourseCode||SectionCode) | varchar(120) | BK | |
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
| AttendanceStatusCode | Attendance status code (P, A, L, E) | varchar(10) | | |
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

## Documentation Gaps

| Table Name | Column Name | Gap Type | Description | Recommended Clarification |
|---|---|---|---|---|
| SatAttendanceDetails | AttendanceStatusCode | Missing Foreign Key | The `AttendanceStatusCode` column in `SatAttendanceDetails` does not have a declared foreign key relationship to the `RefAttendanceStatus` table. | Add a foreign key constraint from `SatAttendanceDetails(AttendanceStatusCode)` to `RefAttendanceStatus(AttendanceStatusCode)`. |
| HubStudent | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL to describe the business purpose of the table. |
| HubTeacher | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL to describe the business purpose of the table. |
| HubCourse | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL to describe the business purpose of the table. |
| HubCourseSection | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL to describe the business purpose of the table. |
| HubSchool | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL to describe the business purpose of the table. |
| HubAcademicTerm | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL to describe the business purpose of the table. |
| HubProgramme | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL to describe the business purpose of the table. |
| HubAssessment | | Missing Business Definition | Business definition for the table is not provided in the DDL. | Add comments to the DDL to describe the business purpose of the table. |

## Data Profiling Summary

| Table Name | Column Name | Profiling Check | Result | Count | Percentage | Status |
|---|---|---|---|---|---|---|
| HubStudent | StudentBk | Uniqueness | | | | NOT_RUN |
| HubTeacher | TeacherBk | Uniqueness | | | | NOT_RUN |
| HubCourse | CourseBk | Uniqueness | | | | NOT_RUN |
| HubCourseSection | CourseSectionBk | Uniqueness | | | | NOT_RUN |
| HubSchool | SchoolBk | Uniqueness | | | | NOT_RUN |
| HubAcademicTerm | AcademicTermBk | Uniqueness | | | | NOT_RUN |
| HubProgramme | ProgrammeBk | Uniqueness | | | | NOT_RUN |
| HubAssessment | AssessmentBk | Uniqueness | | | | NOT_RUN |
| SatStudentPersonal | Email | Email Format | | | | NOT_RUN |
| SatTeacherDetails | Email | Email Format | | | | NOT_RUN |
| SatAttendanceDetails | AttendanceStatusCode | Value Distribution | | | | NOT_RUN |
